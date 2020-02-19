//
//  PharmacyModel.swift
//  hackathon
//
//  Created by Mayank Rikh on 19/02/20.
//  Copyright © 2020 Mayank Rikh. All rights reserved.
//

import Foundation
import SwiftyJSON

struct PharmacyModel : AnnotationData {

    var lat: Double
    var name: String
    var long: Double
    var subtitle: String

    init(json : JSON) {
        lat = json["ig_xcord"].doubleValue
        long = json["ig_ycord"].doubleValue
        name = json["Service name"].stringValue
        subtitle = json["Address"].stringValue
    }
}
