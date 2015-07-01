from flask import Blueprint, request

import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from twilio.rest import TwilioRestClient
from config import *

sms = Blueprint('sms', __name__, template_folder='templates')

@sms.route('/notify', methods=['POST', 'GET'])
def receive_sms():
    if not(notifier_email and notifier_password and notified_email):
       return

    msg = MIMEMultipart()
    msg['Subject'] = "text message"
    msg['From'] = notifier_email
    msg['To'] = notified_email

    message = str(request.form)

    html = render_template('email_sms.html', from=request.form['from'], body=request.body['body'])

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
