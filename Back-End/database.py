import mysql.connector
def databaseConnection():
    conn = mysql.connector.connect(
    user = 'b0e8e4e2396307',
    password = 'cb5f6e7f',
    host = 'eu-cdbr-west-02.cleardb.net',
    port = 3306,
    database = 'heroku_a7b70b2a9badd9d')
    return conn
