from flask import Flask

from torres import app

@app.route('/')
def index():
    return open('templates/index.html').read()
