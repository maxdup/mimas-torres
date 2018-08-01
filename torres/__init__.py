import os
import json
from flask import Flask, request, Response, g
from flask import render_template, send_from_directory, url_for
from flask_pymongo import PyMongo

from main import main, folio
from sms import sms

app = Flask(__name__)
app.register_blueprint(main)
app.register_blueprint(sms)
app.register_blueprint(folio)

app.config["MONGO_URI"] = "mongodb://localhost:27017/sms"

mongo = PyMongo(app)
@app.before_request
def before_request():
    g.db = mongo.db

app.debug = True

app.url_map.strict_slashes = True

if __name__ == "__main__":
    app.run()
