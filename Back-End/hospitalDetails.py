import database

def getDetails():
    print("Enter")
    hospitalDictionary = {}
    hospitalArray = []
    dbconn = database.db
    cursor = dbconn.cursor()
    query = "select * from hospitalDetails;"
    cursor.execute(query)
    data = cursor.fetchall()
    for row in data:
        name = row[0]
        address = row[1]
        eircode = row[2]
        x = row[3]
        y = row[4]
        hospitalDictionary = {**hospitalDictionary,**{'name':name, "address":address, "eircode":eircode, "x":x, "y":y}}
        hospitalArray.append(hospitalDictionary)
        
    return formatJSON(hospitalArray,data)

def formatJSON(hospitalArray,data):
    temp = {}
    if data ==[]:
        temp["code"] = 400
    else:
        temp["code"] = 200
    temp["data"] = hospitalArray
    return temp
