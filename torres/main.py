from flask import Blueprint, render_template

main = Blueprint('main', __name__, template_folder='templates')
folio = Blueprint('folio', __name__, template_folder='templates')

@main.route('/admin/')
def index():
    return render_template('index.html')

@folio.route('/')
def index():
    return render_template('portfolio.html')
