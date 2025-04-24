from flask import Flask, render_template, request, redirect, url_for
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
            <li><a href="/top-customers">Top 5 Customers by Category</a></li>
            <li><a href="/input">Input New Customer/Order</a></li>
        </ul>
    '''

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

# Task 9: Top 5 Customers by Category
@app.route('/top-customers')
def top_customers():
    conn = mysql.connector.connect(
        host='localhost',
        user='root',
        password='Logesh',
        database='shopping'
    )
    
    query = """
        SELECT 
            customer_id, 
            category, 
            ROUND(SUM(quantity * price), 2) AS total_spent
        FROM shopping_data
        GROUP BY customer_id, category
        ORDER BY total_spent DESC
        LIMIT 5;
    """
    
    df = pd.read_sql(query, conn)
    conn.close()
    
    if df.empty:
        return '<h3>No data available for the top 5 customers.</h3>'
    
    return render_template('report.html', tables=[df.to_html(classes='data', index=False)], title="Top 5 Customers by Category")

# Input route for customer/order details
@app.route('/input', methods=['GET', 'POST'])
def input_data():
    if request.method == 'POST':
        customer_id = request.form['customer_id']
        gender = request.form['gender']
        age = request.form['age']
        category = request.form['category']
        quantity = request.form['quantity']
        price = request.form['price']
        payment_method = request.form['payment_method']
        invoice_date = request.form['invoice_date']
        shopping_mall = request.form['shopping_mall']
        
        # Insert the data into the database
        conn = mysql.connector.connect(
            host='localhost',
            user='root',
            password='Logesh',
            database='shopping'
        )
        cursor = conn.cursor()
        
        insert_query = """
        INSERT INTO shopping_data (customer_id, gender, age, category, quantity, price, payment_method, invoice_date, shopping_mall)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
        """
        
        cursor.execute(insert_query, (customer_id, gender, age, category, quantity, price, payment_method, invoice_date, shopping_mall))
        conn.commit()
        conn.close()
        
        return redirect(url_for('report'))  # Redirect to the report page after inserting the data

    return render_template('input.html')  # Render the input form
import plotly.express as px
import plotly.io as pio

# Dashboard route for charts
@app.route('/dashboard')
def dashboard():
    conn = mysql.connector.connect(
        host='localhost',
        user='root',
        password='Logesh',
        database='shopping'
    )
    
    # Query for number of customers over months
    query = """
    SELECT 
        DATE_FORMAT(STR_TO_DATE(invoice_date, '%m/%d/%Y'), '%Y-%m') AS month,
        COUNT(DISTINCT customer_id) AS num_customers
    FROM shopping_data
    GROUP BY month
    ORDER BY month;
    """
    
    df = pd.read_sql(query, conn)
    conn.close()
    
    # Generate a bar chart using Plotly
    fig = px.bar(df, x='month', y='num_customers', title="Number of Customers Over Months")
    graph_html = pio.to_html(fig, full_html=False)  # Convert the plot to HTML
    
    return render_template('dashboard.html', graph_html=graph_html)
if __name__ == '__main__':
    app.run(debug=True)
