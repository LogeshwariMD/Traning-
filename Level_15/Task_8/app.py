from flask import Flask, render_template
import mysql.connector
import pandas as pd

app = Flask(__name__)

# Home route
@app.route('/')
def home():
    return '''
        <h2>Welcome to Shopping Report</h2>
        <ul>
            <li><a href="/report">Full Report</a></li>
            <li><a href="/monthly-sales">Monthly Sales</a></li>
        </ul>
    '''

# Report route (full data)
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

# New Monthly Sales Route
@app.route('/monthly-sales')
def monthly_sales():
    conn = mysql.connector.connect(
        host='localhost',
        user='root',
        password='Logesh',
        database='shopping'
    )
    
    query = """
       SELECT 
    DATE_FORMAT(STR_TO_DATE(invoice_date, '%m/%d/%Y'), '%Y-%m') AS month,
    ROUND(SUM(quantity * price), 2) AS monthly_sales, 
    ROUND(SUM(SUM(quantity * price)) OVER (ORDER BY DATE_FORMAT(STR_TO_DATE(invoice_date, '%m/%d/%Y'), '%Y-%m')), 2) AS cumulative_sales
FROM shopping_data
GROUP BY month
ORDER BY month;

    """
    
    df = pd.read_sql(query, conn)
    conn.close()
    
    return render_template('report.html', tables=[df.to_html(classes='data', index=False)], title="Monthly Cumulative Sales")

if __name__ == '__main__':
    app.run(debug=True)
