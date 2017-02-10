from flask import Blueprint, render_template

main = Blueprint('main', __name__, template_folder='templates')
folio = Blueprint('folio', __name__, template_folder='templates', static_folder='static')

@main.route('/admin/')
def index():
    return render_template('index.html')

@folio.route('/', defaults={'path': '', 'param': ''})
@folio.route('/<path:path>', defaults={'param': ''})
@folio.route('/<path:path>/<path:param>')
def index(path, param):
    return folio.send_static_file('partials/main.html')
