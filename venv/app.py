from flask import Flask, request, render_template, redirect, url_for
import psycopg2
import sqlite3
from datetime import datetime


app = Flask(__name__)
db_path = '/c:/Users/kcw13/OneDrive/Documents/CSwinter2024/data base/final project/database.db'


@app.route('/')
def index():
    conn = psycopg2.connect("dbname = 'protst' user = 'postgres' host= 'localhost' ")
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM Users")
    rows = cursor.fetchall()
    conn.close()
    return render_template('index.html', rows=rows)

@app.route('/create', methods=['GET', 'POST'])
def create():
    if request.method == 'POST':
        user_email = request.form['user_email']
        password = request.form['password']
        first_name = request.form['first_name']
        last_name = request.form['last_name']
        street_address = request.form['street_address']
        city = request.form['city']
        state = request.form['state']
        zip_code = request.form['zip_code']
        
        conn = sqlite3.connect(db_path)
        cursor = conn.cursor()
        cursor.execute("INSERT INTO Users (user_email, password, first_name, last_name, street_address, city, state, zip_code) VALUES (?, ?, ?, ?, ?, ?, ?, ?)", (user_email, password, first_name, last_name, street_address, city, state, zip_code))
        conn.commit()
        conn.close()
        
        return redirect('/')
    
    return render_template('create.html')



@app.route('/update/<int:user_id>', methods=['GET', 'POST'])
def update(user_id):
    if request.method == 'POST':
        user_email = request.form['user_email']
        password = request.form['password']
        first_name = request.form['first_name']
        last_name = request.form['last_name']
        street_address = request.form['street_address']
        city = request.form['city']
        state = request.form['state']
        zip_code = request.form['zip_code']
        
        conn = sqlite3.connect(db_path)
        cursor = conn.cursor()
        cursor.execute("UPDATE Users SET user_email=?, password=?, first_name=?, last_name=?, street_address=?, city=?, state=?, zip_code=? WHERE user_id=?", (user_email, password, first_name, last_name, street_address, city, state, zip_code, user_id))
        conn.commit()
        conn.close()
        
        return redirect('/')
    
    conn = sqlite3.connect(db_path)
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM Users WHERE user_id=?", (user_id,))
    row = cursor.fetchone()
    conn.close()
    
    return render_template('update.html', row=row)

@app.route('/delete/<int:user_id>')
def delete(user_id):
    conn = sqlite3.connect(db_path)
    cursor = conn.cursor()
    cursor.execute("DELETE FROM Users WHERE user_id=?", (user_id,))
    conn.commit()
    conn.close()
    
    return redirect('/')

if __name__ == '__main__':
    app.run(debug=True)