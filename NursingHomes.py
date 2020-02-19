import database

def getDetails():
    print("Enter")
    nursingDictionary = {}
    nursingArray = []
    dbconn = database.db
    cursor = dbconn.cursor()
    query = "select * from nursinghomesdetails;"
    cursor.execute(query)
    data = cursor.fetchall()
    for row in data:
        Name = row[0]
        Address = row[1]
        County = row[2]
        x = row[3]
        y = row[4]
        nursingDictionary = {**nursingDictionary,**{"Name":Name, "Address":Address, "County":County,"x":x,"y":y}}
        nursingArray.append(nursingDictionary)
        
    return formatJSON(nursingArray,data)

def formatJSON(nursingArray,data):
    temp = {}
    if data ==[]:
        temp["code"] = 400
    else:
        temp["code"] = 200
    temp["data"] = nursingArray
    return temp
