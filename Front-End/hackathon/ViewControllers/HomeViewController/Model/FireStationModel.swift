//
//  FireStationModel.swift
//  hackathon
//
//  Created by Mayank Rikh on 19/02/20.
//  Copyright © 2020 Mayank Rikh. All rights reserved.
//

import SwiftyJSON
import Foundation

struct FireStationModel : AnnotationData{
    
    var lat: Double
    var long: Double
    var name: String
    let address1 : String
    let address2 : String
    let address3 : String
    let address4 : String
    let phone : String
    let email : String
    let website : String
    var subtitle : String

    init(json : JSON) {

        name = json["Name"].stringValue
        address1 = json["Address1"].stringValue
        address2 = json["Address2"].stringValue
        address3 = json["Address3"].stringValue
        address4 = json["Address4"].stringValue
        phone = json["Phone"].stringValue
        email = json["Email"].stringValue
        website = json["Website"].stringValue
        lat = json["LAT"].doubleValue
        long = json["LONG"].doubleValue

        subtitle = [address1, address2, address3, address4].joined(separator: ", ")
    }
}
