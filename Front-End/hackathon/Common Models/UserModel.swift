//
//  UserModel.swift
//  
//
//  Created by Mayank on 03/12/18.
//  Copyright © 2018 Mayank Rikh. All rights reserved.
//

import SwiftyJSON
import Foundation

struct UserModel{
    
    static var current = UserModel(Defaults.value(forKey: .userInfo) ?? JSON())
    
    let user_id: Int
    var full_name: String
    let email: String
    
    init (_ json: JSON = JSON()) {
        
        user_id = json["user_id"].intValue
        full_name = json["full_name"].stringValue
        email = json["email"].stringValue
    }
    
    func saveToUserDefaults() {
        
        let dict = ["user_id" : user_id, "full_name" : full_name, "email" : email] as [String : Any]
        Defaults.save(value: dict, forKey: .userInfo)
    }
}
