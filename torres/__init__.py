import os
import json
from flask import Flask, request, Response
from flask import render_template, send_from_directory, url_for

from main import main
from sms import sms

app = Flask(__name__)
app.register_blueprint(main)
app.config.from_object('settings')

app.url_map.strict_slashes = True

app.run(port=5000)
