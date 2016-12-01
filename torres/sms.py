from flask import Blueprint, request, render_template, g, abort

import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from twilio.rest import TwilioRestClient
from config import *

import json
from bson.objectid import ObjectId

from bson import json_util

sms = Blueprint('sms', __name__, template_folder='templates')

@sms.route('/admin/sms', methods=['GET', 'POST'])
@sms.route('/admin/sms/<_id>', methods=['GET', 'PUT', 'DELETE'])
def sms_rest():

    if request.method == 'GET':
        messages = []
        query = g.db['sms'].find()
        for message in query:
            messages.append(message)
        return json.dumps(messages, default=json_util.default)

    elif request.method == 'POST':
        if not (sender_sms and ACCOUNT_SID and AUTH_TOKEN):
            return ('', 403)

        content = request.get_json()

        client = TwilioRestClient(ACCOUNT_SID, AUTH_TOKEN)

        client.messages.create(
            to=int(content['number']),
            from_=sender_sms,
            body=content['message'],)

        message = {'from': sender_sms,
                   'to': content['number'],
                   'body': content['message']}

        g.db['sms'].save(message)
        return json.dumps(message, default=json_util.default)

    elif request.method == 'PUT':
        #this is a one off to update the database.
        smss = g.db['sms'].find()
        for sms in smss:
            g.db['sms'].update({'_id': sms['_id']},
                               {'$set':{'to':sender_sms}})

    elif request.method == 'DELETE':
        g.db['sms'].remove({'_id': _id})
        return ('', 204)


    return json.dumps({})

@sms.route('/admin/contact', methods=['GET', 'POST'])
@sms.route('/admin/contact/<_id>', methods=['GET', 'PUT', 'DELETE'])
def contact_rest(_id=None):

    if _id:
        _id = ObjectId(_id)

    if request.method == 'GET':
        contacts = []
        if _id:
            contact = g.db['contact'].find()
            return json.dumps(contacts, default=json_util.default)

        query = g.db['contact'].find()
        for contact in query:
            contacts.append(contact)
        return json.dumps(contacts, default=json_util.default)

    elif request.method == 'POST':
        contact = request.json
        if not contact['number'] and contact['name']:
            abort(400)

        contact['number'] = int(contact['number'])

        if 10000000000 < contact['number'] < 100000000000:
            g.db['contact'].save(contact)
            return json.dumps(contact, default=json_util.default)
        else:
            abort(400)

    elif request.method == 'PUT':
        contact = request.json
        if '_id' in contact:
            del contact['_id']
        contact['number'] = int(contact['number'])
        contact = g.db['contact'].update({'_id': _id}, {'$set': contact})
        return json.dumps(contact, default=json_util.default)

    elif request.method == 'DELETE':
        g.db['contact'].remove({'_id': _id})
        return ('', 204)

    return json.dumps({})

@sms.route('/admin/notify', methods=['POST', 'GET'])
def receive_sms():

    if not(notifier_email and notifier_password and notified_email):
       return

    msg = MIMEMultipart()
    msg['Subject'] = "text message"
    msg['From'] = notifier_email
    msg['To'] = notified_email
    message = {'from':request.form['From'],
               'to':request.form['To'],
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

@sms.route('/admin/message', methods=['POST'])
def send_sms():
    if not (sender_sms and ACCOUNT_SID and AUTH_TOKEN):
        return ('', 403)

    content = request.get_json()

    client = TwilioRestClient(ACCOUNT_SID, AUTH_TOKEN)

    client.messages.create(
        to=int(content['number']),
        from_=sender_sms,
        body=content['message'],)

    message = {'from': sender_sms,
               'to': content['number'],
               'body': content['message']}

    g.db['sms'].save(message)
    return ('', 204)
