import mysql.connector



def databaseConnection():
    conn = mysql.connector.connect(
    user = 'b4170710f26515',
    password = '5009ee16',
    host = 'eu-cdbr-west-02.cleardb.net',
    port = 3306,
    database = 'heroku_4bdc9a2b0a22fb2')
    return conn

db = databaseConnection()