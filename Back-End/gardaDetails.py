import database

def getDetails():
    gardaDictionary = {}
    gardaArray = []
    dbconn = database.databaseConnection()
    cursor = dbconn.cursor()
    query = "select * from gardadetails;"
    cursor.execute(query)
    data = cursor.fetchall()
    for row in data:
        Name = row[0]
        Address1 = row[1]
        Address2 = row[2]
        Address3 = row[3]
        Phone = row[4]
        Website = row[5]
        Division = row[6]
        Divisional_HQ = row[7]
        Divisional_HQ_Phone = row[8]
        District = row[9]
        District_HQ = row[10]
        District_HQ_Phone = row[11]
        Opening_Hours = row[12]
        latitude = row[13]
        longitude = row[14]
        gardaDictionary = {**gardaDictionary,**{"Name":Name, "Address1":Address1, "Address2":Address2,"Address3":Address3, "Phone":Phone, "Website":Website, "Division":Division,"Divisional_HQ":Divisional_HQ,"Divisional_HQ_Phone":Divisional_HQ_Phone,"District":District,"District_HQ":District_HQ,"District_HQ_Phone":District_HQ_Phone,"Opening_Hours":Opening_Hours,"latitude":latitude,"longitude":longitude}}
        gardaArray.append(gardaDictionary)
        
    return formatJSON(gardaArray,data)

def formatJSON(gardaArray,data):
    temp = {}
    if data ==[]:
        temp["code"] = 400
    else:
        temp["code"] = 200
    temp["data"] = gardaArray
    return temp
