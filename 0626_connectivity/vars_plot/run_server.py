# -*- coding: utf-8 -*-
import dash
import dash_core_components as dcc
import dash_html_components as html
from dash.dependencies import Output, Input, State

external_stylesheets = ['https://codepen.io/chriddyp/pen/bWLwgP.css']

app = dash.Dash(__name__, external_stylesheets=external_stylesheets)


app.layout = html.Div(children=[
    dcc.Location(id='url', refresh=False),
    html.H1(children='DET Temp Logging Demo'),

    html.Div(children='''
        Eldon Schoop
    '''),

    dcc.Graph(
        id='example-graph',
        figure={
            'data': [
                {
                    'x': [],
                    'y': [],
                    'type': 'lines+markers',
                    'name': 'Temperature (F)',
                },
            ],
            'layout': {
                'title': 'Temperature Logger!'
            }
        }
    ),

    dcc.Store(id='temp-store', storage_type='session', children=[]),

])

@app.callback(Output('example-graph', 'figure'),
        [Input('temp-store', 'data'),])
def update_figure(temp_data):
    if not temp_data:
        temp_data = []
    return {
        'data': [
            {
                'x': list(range(len(temp_data))),
                'y': temp_data,
                'type': 'lines+markers',
                'name': 'Temperature (F)',
            },
        ],
        'layout': {
            'title': 'Temperature Logger!'
        }
    }

@app.callback(Output('temp-store', 'data'),
              [Input('url', 'pathname')],
              [State('temp-store', 'data'),])
def display_page(pathname, temp_data):
    if not temp_data:
        temp_data = []
    temp_val = pathname[pathname.rfind('/') + 1:]
    if not temp_val:
        return temp_data
    temp_val = [float(temp_val)]
    appended = temp_data + temp_val
    return appended


if __name__ == '__main__':
    app.run_server(debug=True, host='0.0.0.0', port=80)
