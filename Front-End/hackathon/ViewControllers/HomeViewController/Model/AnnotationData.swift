//
//  AnnotationData.swift
//  hackathon
//
//  Created by Mayank Rikh on 19/02/20.
//  Copyright © 2020 Mayank Rikh. All rights reserved.
//

import Foundation

protocol AnnotationData{

    var lat : Double {get set}
    var long : Double {get set}
    var name : String {get set}
    var subtitle : String {get set}
}
