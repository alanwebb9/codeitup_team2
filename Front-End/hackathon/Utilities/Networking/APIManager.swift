//
//  APIManager.swift
//  
//
//  Created by Mayank Rikh on 25/01/19.
//  Copyright © 2019 Mayank Rikh. All rights reserved.
//

import Foundation
import SwiftyJSON

class APIManager {

    static func getFireList(params : [String : Any], completion: ((JSON?, Error?)->())?){

        NetworkingManager.POST(endPoint: .getFireList, parameters: params, headers : headers, success: { (dict) in
            completion?(JSON(dict), nil)
        }) { (error) in
            completion?(nil, error)
        }
    }

    static var headers : [String : String]{
        return ["":""]
    }
}
