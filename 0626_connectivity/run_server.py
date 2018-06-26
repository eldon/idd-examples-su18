#!venv/bin/python

from flask import Flask

app = Flask(__name__)

app.config['elapsed'] = 0
app.config['setval'] = 0

HTML_TMPL = '''<!DOCTYPE html>
<html>
<head><title>IDD Demo</title></head>
<body>{}</body>
</html>'''

@app.route('/')
def index():
    return HTML_TMPL.format(
        '''<h1>IDD Demo HTML page</h1>
<p>Counter: ''' + str(app.config['elapsed']) + '''</p>
<p>Set Value: ''' + str(app.config['setval']) + '''</p>''',
    )

@app.route('/api/incr')
def incr():
    app.config['elapsed'] += 1
    return '0'

@app.route('/api/set/<val>')
def setval(val):
    app.config['setval'] = val
    return '0'

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8888)
