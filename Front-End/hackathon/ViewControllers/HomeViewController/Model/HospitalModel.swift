//
//  HospitalModel.swift
//  hackathon
//
//  Created by Mayank Rikh on 19/02/20.
//  Copyright © 2020 Mayank Rikh. All rights reserved.
//

import SwiftyJSON
import Foundation

struct HospitalModel : AnnotationData{

    var lat: Double
    var long: Double
    var name: String
    var subtitle: String

    init(json : JSON) {

        lat = json["x"].doubleValue
        long = json["y"].doubleValue
        name = json["name"].stringValue
        subtitle = json["address"].stringValue
    }
}
