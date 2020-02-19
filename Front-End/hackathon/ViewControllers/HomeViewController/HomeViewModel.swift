//
//  HomeViewModel.swift
//  hackathon
//
//  Created by Mayank Rikh on 19/02/20.
//  Copyright © 2020 Mayank Rikh. All rights reserved.
//

import Foundation

class HomeViewModel{

    enum DataType : Int, CaseIterable{
        case all = 0
        case fireStations = 1
        case hospitals = 2
        case pharmacy = 3

        var text : String{
            switch self{
            case .all : return StringConstants.all.localized
            case .fireStations : return StringConstants.fireStations.localized
            case .hospitals : return StringConstants.hospitals.localized
            case .pharmacy : StringConstants.pharmacy.localized
            }
        }
    }

    var type = DataType.all

    func nextType() -> DataType{

        let allTypes = DataType.allCases

        if self.type.rawValue == allTypes.count - 1{
            self.type = .all
        }else{
            self.type = DataType.init(rawValue: self.type.rawValue + 1) ?? .all
        }

        return self.type
    }

    func previousType() -> DataType{

        let allTypes = DataType.allCases

        if self.type.rawValue == 0{
            self.type = allTypes.last ?? .all
        }else{
            self.type = DataType.init(rawValue: self.type.rawValue - 1) ?? .all
        }

        return self.type
    }
}
