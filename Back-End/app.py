from flask import Flask, url_for, request, jsonify
import requests, csv
import mysql.connector
import os
import fireDetails
import database
import hospitalDetails,gardaDetails
app = Flask(__name__)

@app.route("/getFireList", methods =['GET'])
def getFireDetails():
    fireDetailsDictionary = {}
    fireDetailsDictionary = jsonify(fireDetails.getDetails())
    return fireDetailsDictionary


@app.route("/getHospitalList", methods =['GET'])
def getHospitalDetails():
    hospitalDetailsDictionary = {}
    hospitalDetailsDictionary = jsonify(hospitalDetails.getDetails())
    return hospitalDetailsDictionary

@app.route("/getGardaList", methods =['GET'])
def getGardaDetails():
    gardaDetailsDictionary = {}
    gardaDetailsDictionary = jsonify(gardaDetails.getDetails())
    return gardaDetailsDictionary


if __name__ == "__main__":
    app.secret_key = os.urandom(24)
    app.jinja_env.cache = {}    
    app.run(debug=True, port=5000, threaded=True)






