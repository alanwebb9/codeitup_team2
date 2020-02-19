from flask import Flask, url_for, request, jsonify
import requests
import mysql.connector
import os

app = Flask(__name__)

def databaseConnection():
    conn = mysql.connector.connect(
    user = 'b4170710f26515',
    password = '5009ee16',
    host = 'eu-cdbr-west-02.cleardb.net',
    port = 3306,
    database = 'heroku_4bdc9a2b0a22fb2')
    return conn

@app.route("/getDetails", methods =['GET'])
def getDetails():
    print("Enter")
    userDictionary = {}
    userArray = []
    dbconn = databaseConnection()
    cursor = dbconn.cursor()
    query = "select * from user;"
    cursor.execute(query)
    data = cursor.fetchall()
    for row in data:
        name = row[0]
        print(name)
        age = row[1]
        location = row[2]
        userDictionary = {**userDictionary,**{'name':name,'age':age,'location':location}}
        userArray.append(userDictionary)
        
    return jsonify(userArray)
    

if __name__ == "__main__":
    app.secret_key = os.urandom(24)
    #app.jinja_env.cache = {}    
    app.run(debug=True, port=5000, threaded=True)






