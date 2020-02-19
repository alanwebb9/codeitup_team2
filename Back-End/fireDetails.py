import database
# def insertFireCSVData():
#     dbconn = databaseConnection()
#     cursor = dbconn.cursor()
#     csv_data = csv.reader(open('fccfirestationsp20111201-2134.csv'))
#     for row in csv_data:
#         cursor.execute("INSERT into fireStationDetails (Name, Address1, Address2, Address3, Address4,Phone, Email,Website,Fire_Service,latitude,longitude)values(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)", row)
#     dbconn.commit()
#     cursor.close()
#     print("Done")



def getDetails():
    print("Enter")
    fireDictionary = {}
    fireArray = []
    dbconn = database.databaseConnection()
    cursor = dbconn.cursor()
    query = "select * from fireStationDetails;"
    cursor.execute(query)
    data = cursor.fetchall()
    for row in data:
        Name = row[0]
        Address1 = row[1]
        Address2 = row[2]
        Address3 = row[3]
        Address4 = row[4]
        Phone = row[5]
        Email = row[6]
        Website = row[7]
        Fire_Service = row[8]
        latitude = row[9]
        longitude = row[10]
        fireDictionary = {**fireDictionary,**{'Name':Name, "Address1":Address1, "Address2":Address2, "Address3":Address3, "Address4":Address4,"Phone":Phone, "Email":Email,"Website":Website,"Fire_Service":Fire_Service,"latitude":latitude,"longitude":longitude}}
        fireArray.append(fireDictionary)
        
    return formatJSON(fireArray,data)

def formatJSON(fireArray,data):
    temp = {}
    if data ==[]:
        temp["code"] = 400
    else:
        temp["code"] = 200
    temp["data"] = fireArray
    return temp
