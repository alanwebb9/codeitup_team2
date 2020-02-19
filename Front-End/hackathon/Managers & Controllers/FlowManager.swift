//
//  FlowManager.swift
//  
//
//  Created by Mayank Rikh on 30/11/18.
//  Copyright © 2018 Mayank Rikh. All rights reserved.
//

import UIKit

class FlowManager{
    
    /// This method will check various properties to determine which screen we need to open.
    static func checkAppInitializationFlow(){

        if let _ = Defaults.value(forKey: Defaults.Key.userInfo){
            //user exists
        }
    }

    static func createNavigationController(_ viewController : UIViewController) -> UINavigationController{

        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.extendedLayoutIncludesOpaqueBars = true
        navigationController.setNavigationBarHidden(true, animated: false)
        return navigationController
    }

    static func clearAllData(){

        Defaults.removeValue(forKey: .userInfo)
    }
}
