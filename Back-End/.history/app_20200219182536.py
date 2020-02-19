from flask import Flask, url_for, request, jsonify
import requests, csv
import mysql.connector
import os
import database
import HospitalDetails,GardaDetails,FireDetails,NursingHomes,PharmaDetails
app = Flask(__name__)


@app.route("/getFireList", methods =['GET'])
def getFireDetails():
    fireDetailsDictionary = {}
    fireDetailsDictionary = jsonify(FireDetails.getDetails())
    return fireDetailsDictionary

@app.route("/getNursingHomesList", methods =['GET'])
def getNursingHomesDetails():
    print("ainwayi")
    nursingHomesDetailsDictionary = {}
    nursingHomesDetailsDictionary = jsonify(NursingHomes.getDetails())
    return nursingHomesDetailsDictionary

@app.route("/getPharmaList", methods =['GET'])
def getPharmaDetails():
    pharmaDetailsDictionary = {}
    pharmaDetailsDictionary = jsonify(PharmaDetails.getDetails())
    return pharmaDetailsDictionary

@app.route("/getHospitalList", methods =['GET'])
def getHospitalDetails():
    hospitalDetailsDictionary = {}
    hospitalDetailsDictionary = jsonify(HospitalDetails.getDetails())
    return hospitalDetailsDictionary

@app.route("/getGardaList", methods =['GET'])
def getGardaDetails():
    gardaDetailsDictionary = {}
    gardaDetailsDictionary = jsonify(GardaDetails.getDetails())
    return gardaDetailsDictionary


if __name__ == "__main__":
    app.secret_key = os.urandom(24)
    app.jinja_env.cache = {}    
    app.run(debug=True, port=5000, threaded=True)






