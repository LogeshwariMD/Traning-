from flask import Flask, render_template
import mysql.connector
import pandas as pd

app = Flask(__name__)

@app.route('/')
def home():
    return '<h2>Welcome to Shopping Report</h2><a href="/report">View Report</a>'

@app.route('/report')
def report():
    conn = mysql.connector.connect(
        host='localhost',
        user='root',
        password='Logesh',
        database='shopping'
    )
    df = pd.read_sql("SELECT * FROM shopping_data", conn)
    conn.close()
    return render_template('report.html', tables=[df.to_html(classes='data', index=False)], title="Shopping Report")

if __name__ == '__main__':
    app.run(debug=True)
