from flask import Flask

from torres import app

@app.route('/')
def index():
    return open('torres/templates/index.html').read()
