import dash
from dash import dcc
from dash import html
from dash.dependencies import Input, Output, State
import pandas as pd
import pandas_datareader.data as web
from datetime import date

app = dash.Dash()

nsdq = pd.read_csv('/app/NASDAQcompanylist.csv')
nsdq.set_index('Symbol', inplace=True)
options = [{'label' : nsdq.loc[tic]['Name'], 'value' : tic} for tic in nsdq.index]

app.layout = html.Div([
    html.H1('Stock Ticker Dashboard'),

    html.Div([
        html.H3(
            'Enter a stock symbol:', 
            style = {
                'paddingRight' : '30px'
            }
        ),
        dcc.Dropdown(            
            id = 'my_stock_picker',
            options = options,
            value = ['TSLA'],
            multi = True
        )
    ], style = {
        'display' : 'inline-block',
        'verticalAlign' : 'top',
        'width' : '30%'
    }),

    html.Div([
        html.H3('Select a start and end date:'),
        dcc.DatePickerRange(
            id = 'my_date_picker',
            min_date_allowed = date(2015, 1, 1),
            max_date_allowed = date.today(),
            start_date = date(2018, 1, 1),
            end_date = date.today()
        )
    ], style = {
        'display' : 'inline-block'
    }),

    html.Div([
        html.Button(
            id = 'submit-button',
            n_clicks = 0,
            children = 'Submit',
            style = {
                'fontSize' : 24,
                'marginLeft' : '30px'
            }
        )
    ], style = {
        'display' : 'inline-block'
    }),

    dcc.Graph(
        id = 'my_graph',
        figure = {
            'data' : [
                {
                    'x' : [1, 2],
                    'y' : [3, 1]
                }
            ],
            'layout' : {
                'title' : 'Default Title'
            }
        }
    )
])

@app.callback(
    Output('my_graph', 'figure'),
    Input('submit-button', 'n_clicks'),
    State('my_stock_picker', 'value'),
    State('my_date_picker', 'start_date'),
    State('my_date_picker', 'end_date')
)
def update_graph(n_clicks, stock_ticker, start_date, end_date):
    start = date.fromisoformat(start_date)
    end = date.fromisoformat(end_date)

    traces = []
    for tic in stock_ticker:
        df = web.DataReader(tic, 'yahoo', start, end)
        traces.append({'x' : df.index, 'y' : df['Close'], 'name' : tic})

    fig = {
        'data' : traces,
        'layout' : {
            'title' : stock_ticker
        }
    }
    return fig

if __name__ == '__main__':
    app.run_server(host='0.0.0.0')
