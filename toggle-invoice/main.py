import os
import sys
import csv
from datetime import datetime
from tempfile import NamedTemporaryFile

from InvoiceGenerator.api import Invoice, Item, Client, Provider, Creator, Address
from InvoiceGenerator.pdf import SimpleInvoice, ProformaInvoice, BaseInvoice, prepare_invoice_draw
from reportlab.lib.units import mm

from config import *

from operator import mul
import decimal
from decimal import Decimal
factors = (60, 1, 1/60)


class hourlyItem(Item):

    @Item.count.setter
    def count(self, value):
        self._count = Decimal(
            sum(map(mul, map(int, value.split(':')), factors)) / 60)


class MyInvoice(SimpleInvoice):
    def gen(self, filename):
        self.filename = filename
        prepare_invoice_draw(self)

        self._drawMain()
        self._drawTitle()

        self._drawProvider(self.TOP - 25, self.LEFT + 3)
        self._drawClient(self.TOP - 25, self.LEFT + 91)

        self._drawDates(self.TOP - 7, self.LEFT + 90)
        self._drawItems(self.TOP - 55, self.LEFT)

        self.pdf.showPage()
        self.pdf.save()

    def _drawCreator(self, TOP, LEFT):
        return

    def _drawMain(self):
        # Borders
        self.pdf.rect(
            self.LEFT * mm,
            (self.TOP - 45) * mm,
            (self.LEFT + 156) * mm,
            30 * mm,
            stroke=True,
            fill=False,
        )
        path = self.pdf.beginPath()
        path.moveTo((self.LEFT + 88) * mm, (self.TOP - 15) * mm)
        path.lineTo((self.LEFT + 88) * mm, (self.TOP - 45) * mm)
        self.pdf.drawPath(path, True, True)

    def _drawClient(self, TOP, LEFT):
        self._drawAddress(TOP, LEFT + 2, 88, 36,
                          'Customer', self.invoice.client)

    def _drawProvider(self, TOP, LEFT):
        self._drawAddress(TOP, LEFT + 2, 88, 36,
                          'Provider', self.invoice.provider)

    def _drawTitle(self):
        self.pdf.drawString(self.LEFT*mm, self.TOP*mm, self.invoice.title)
        self.pdf.drawString((self.LEFT + 90) * mm,
                            self.TOP*mm,
                            'Invoice num.: %s' % self.invoice.number)

    def _drawItemsHeader(self,  TOP,  LEFT):
        path = self.pdf.beginPath()
        path.moveTo(LEFT * mm, (TOP - 4) * mm)
        path.lineTo((LEFT + 176) * mm, (TOP - 4) * mm)
        self.pdf.drawPath(path, True, True)

        self.pdf.setFont('DejaVu-Bold', 7)
        self.pdf.drawString((LEFT + 1) * mm, (TOP - 2)
                            * mm, _(u'List of items'))

        self.pdf.drawString((LEFT + 1) * mm, (TOP - 9) * mm, _(u'Description'))
        items_are_with_tax = self.invoice.use_tax
        if items_are_with_tax:
            i = 9
            self.pdf.drawRightString(
                (LEFT + 73) * mm, (TOP - i) * mm, _(u'Units'))
            self.pdf.drawRightString(
                (LEFT + 88) * mm,
                (TOP - i) * mm,
                _(u'Price per one'),
            )
            self.pdf.drawRightString(
                (LEFT + 115) * mm,
                (TOP - i) * mm,
                _(u'Total price'),
            )
            self.pdf.drawRightString(
                (LEFT + 137) * mm,
                (TOP - i) * mm,
                _(u'Tax'),
            )
            self.pdf.drawRightString(
                (LEFT + 146) * mm,
                (TOP - i) * mm,
                _(u'Total price with tax'),
            )
            i += 5
        else:
            i = 9
            self.pdf.drawRightString(
                (LEFT + 118) * mm,
                (TOP - i) * mm,
                _(u'Hours'),
            )
            self.pdf.drawRightString(
                (LEFT + 148) * mm,
                (TOP - i) * mm,
                _(u'Hourly Rate'),
            )
            self.pdf.drawRightString(
                (LEFT + 173) * mm,
                (TOP - i) * mm,
                _(u'Total'),
            )
            i += 5
        return i


# choose english as language
os.environ["INVOICE_LANG"] = "en"

projects = {}
provider = Provider(**PROVIDER)
clients = {}
for k, v in CLIENTS.items():
    clients[k] = Client(**v)

with open(sys.argv[1]) as csv_file:
    csv_reader = csv.reader(csv_file, delimiter=',')
    columns = []
    items = []
    for row in csv_reader:
        if not columns:
            columns = row
        else:
            item = {}
            for i in range(0, len(columns)):
                item[columns[i]] = row[i]
            if item['Project'] not in projects:
                projects[item['Project']] = []
            projects[item['Project']].append(item)

for k, v in projects.items():
    creator = Creator('me')
    invoice = Invoice(clients[k], provider, creator)
    invoice.date = datetime.now()
    invoice.number = datetime.now().strftime('%Y%m%d')
    invoice.currency = '$'
    invoice.currency_locale = 'en_US'
    invoice.title = k.capitalize()

    for item in v:
        invoice.add_item(hourlyItem(item['Duration'], 30,
                                    description=item['Title']))
    pdfInvoice = MyInvoice(invoice)
    pdfInvoice.gen("invoices/invoice-" + k + "-" +
                   datetime.now().strftime('%Y%m%d') + ".pdf")
