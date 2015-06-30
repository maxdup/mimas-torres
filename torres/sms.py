from flask import Flask, request

import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from twilio.rest import TwilioRestClient
from torres import app
from torres.config import *

@app.route('/notify', methods=['POST', 'GET'])
def receive_sms():
    if not(notifier_email and notifier_password):
       return

    print(request.data)

    msg = MIMEMultipart()
    msg['Subject'] = "text"
    msg['From'] = notifier_email
    msg['To'] = notified_email

    html = '''<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w\
3.org/TR/xhtml1/DTD/xhtml1-transitional.d\
td"><html xmlns="http://www.w3.org/1999/xhtml"><body><h1>'''+str(request.data)+'''</h1></body></html>'''

    msg.attach(MIMEText(html, 'html'))

    server = smtplib.SMTP('smtp.gmail.com:587')
    server.starttls()
    server.login(notifier_email, notifier_password)
    server.sendmail(notifier_email, notified_email, msg.as_string())
    server.quit()
    return ('', 204)

@app.route('/message', methods=['post'])
def send_sms(commande_info):
    if not (sender_sms and ACCOUNT_SID and AUTH_TOKEN):
        return

    client = TwilioRestClient(ACCOUNT_SID, AUTH_TOKEN)
    client.messages.create(
        to=commande_info['details']['notify'],
        from_=sender_sms,
        body='hello',)
