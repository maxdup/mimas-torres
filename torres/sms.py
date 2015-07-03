from flask import Blueprint, request, render_template, g

import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from twilio.rest import TwilioRestClient
from config import *

import json

from bson import json_util

sms = Blueprint('sms', __name__, template_folder='templates')

@sms.route('/sms', methods=['GET', 'POST'])
def sms_crud():
    if request.method == 'GET':
        message=[]
        smss = g.db['sms'].find()
        for s in smss:
            message.append(s)
        return json.dumps(message, default=json_util.default)
    return json.dumps({})

@sms.route('/notify', methods=['POST', 'GET'])
def receive_sms():

    if not(notifier_email and notifier_password and notified_email):
       return

    msg = MIMEMultipart()
    msg['Subject'] = "text message"
    msg['From'] = notifier_email
    msg['To'] = notified_email
    message = {'from':request.form['From'],
               'body':request.form['Body']}

    g.db['sms'].save(message)

    html = render_template('email_sms.html', msg=message)
    msg.attach(MIMEText(html, 'html'))

    server = smtplib.SMTP('smtp.gmail.com:587')
    server.starttls()
    server.login(notifier_email, notifier_password)
    server.sendmail(notifier_email, notified_email, msg.as_string())
    server.quit()

    return ('', 204)

@sms.route('/message', methods=['POST', 'GET'])
def send_sms():
    if not (sender_sms and ACCOUNT_SID and AUTH_TOKEN):
        return ('', 403)

    content = request.get_json()

    client = TwilioRestClient(ACCOUNT_SID, AUTH_TOKEN)
    client.messages.create(
        to=int(content['number']),
        from_=sender_sms,
        body=content['message'],)

    return ('', 204)
