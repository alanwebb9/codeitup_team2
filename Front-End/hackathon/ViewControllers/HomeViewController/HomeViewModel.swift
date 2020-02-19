//
//  HomeViewModel.swift
//  hackathon
//
//  Created by Mayank Rikh on 19/02/20.
//  Copyright © 2020 Mayank Rikh. All rights reserved.
//

import SwiftyJSON
import Foundation

protocol HomeViewModelDelegate : class{

    func reloadData()
}

class HomeViewModel{

    enum DataType : Int, CaseIterable{
        case all = 0
        case fireStations = 1
        case hospitals = 2
        case pharmacy = 3
        case garda = 4

        var text : String{
            switch self{
            case .all : return StringConstants.all.localized
            case .fireStations : return StringConstants.fireStations.localized
            case .hospitals : return StringConstants.hospitals.localized
            case .pharmacy : return StringConstants.pharmacy.localized
            case .garda : return StringConstants.garda.localized
            }
        }
    }

    var delegate : HomeViewModelDelegate?
    var pinDataArray = [AnnotationData]()
    var type = DataType.all

    private var fireStations = [FireStationModel]()
    private var hospitals = [HospitalModel]()
    private var pharmacy = [PharmacyModel]()
    private var garda = [GardaModel]()

    init(){
        readFromFireStationCSV()
        readFromHospitals()
        readGarda()
        readPharmacy()
    }

    func nextType() -> DataType{

        let allTypes = DataType.allCases

        if self.type.rawValue == allTypes.count - 1{
            self.type = .all
        }else{
            self.type = DataType.init(rawValue: self.type.rawValue + 1) ?? .all
        }

        updateData()
        return self.type
    }

    func previousType() -> DataType{

        let allTypes = DataType.allCases

        if self.type.rawValue == 0{
            self.type = allTypes.last ?? .all
        }else{
            self.type = DataType.init(rawValue: self.type.rawValue - 1) ?? .all
        }
        updateData()
        return self.type
    }

    func updateData(){

        switch type {
        case .fireStations:
            pinDataArray = fireStations
        case .hospitals:
            pinDataArray = hospitals
        case .garda:
            pinDataArray = garda
        case .pharmacy:
            pinDataArray = pharmacy
        default:
            pinDataArray = []
        }

        delegate?.reloadData()
    }

    //MARK:- Private
    private func readFromFireStationCSV(){

        if let path = Bundle.main.path(forResource: "fireStation", ofType: "json") {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe){
                if let jsonResult = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves){
                    if let jsonResult = jsonResult as? [[String : Any]]{
                        fireStations = JSON(jsonResult).arrayValue.map{FireStationModel(json: $0)}
                    }
                }
            }
        }
    }

    private func readFromHospitals(){

        if let path = Bundle.main.path(forResource: "hospitals", ofType: "json") {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe){
                if let jsonResult = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves){
                    if let jsonResult = jsonResult as? [[String : Any]]{
                        hospitals = JSON(jsonResult).arrayValue.map{HospitalModel(json: $0)}
                    }
                }
            }
        }
    }

    private func readPharmacy(){

        if let path = Bundle.main.path(forResource: "pharmacy", ofType: "json") {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe){
                if let jsonResult = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves){
                    if let jsonResult = jsonResult as? [[String : Any]]{
                        pharmacy = JSON(jsonResult).arrayValue.map{PharmacyModel(json: $0)}
                    }
                }
            }
        }
    }

    private func readGarda(){

        if let path = Bundle.main.path(forResource: "garda", ofType: "json") {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe){
                if let jsonResult = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves){
                    if let jsonResult = jsonResult as? [[String : Any]]{
                        garda = JSON(jsonResult).arrayValue.map{GardaModel(json: $0)}
                    }
                }
            }
        }
    }
}
