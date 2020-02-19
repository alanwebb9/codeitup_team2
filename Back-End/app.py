from flask import Flask, url_for, request, jsonify
import requests, csv
import mysql.connector
import os
import fireDetails

app = Flask(__name__)

@app.route("/getFireDetails", methods =['GET'])
def getFireDetails():
    fireDetailsDictionary = {}
    fireDetailsDictionary = jsonify(fireDetails.getDetails())
    return fireDetailsDictionary

    

if __name__ == "__main__":
    app.secret_key = os.urandom(24)
    app.jinja_env.cache = {}    
    app.run(debug=True, port=5000, threaded=True)






