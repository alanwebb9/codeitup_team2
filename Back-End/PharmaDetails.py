import database

def getDetails():
    print("Enter")
    pharmaDictionary = {}
    pharmaArray = []
    dbconn = database.databaseConnection()
    cursor = dbconn.cursor()
    query = "select * from pharmadetails;"
    cursor.execute(query)
    data = cursor.fetchall()
    for row in data:
        Name = row[0]
        Address = row[1]
        County = row[2]
        x = row[3]
        y = row[4]
        pharmaDictionary = {**pharmaDictionary,**{"Name":Name, "Address":Address, "County":County,"x":x,"y":y}}
        pharmaArray.append(pharmaDictionary)
        
    return formatJSON(pharmaArray,data)

def formatJSON(pharmaArray,data):
    temp = {}
    if data ==[]:
        temp["code"] = 400
    else:
        temp["code"] = 200
    temp["data"] = pharmaArray
    return temp
