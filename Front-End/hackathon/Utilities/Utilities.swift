//
//  Utilities.swift
//  
//
//  Created by Mayank Rikh on 25/01/19.
//  Copyright © 2019 Mayank Rikh. All rights reserved.
//

import MaterialShowcase
import Foundation

class Utilities{

    static func showTutorial(on targetView : UIView, primaryText : String, secondaryText : String? = nil, isCircle : Bool = true, delegate : MaterialShowcaseDelegate? = nil, uniqueIdentifier : Int, completion : (()->())? = nil){

        let showcase = MaterialShowcase()
        showcase.primaryText = primaryText
        showcase.secondaryText = secondaryText ?? ""
        showcase.setTargetView(view: targetView)
        showcase.backgroundPromptColor = Colors.black
        showcase.backgroundPromptColorAlpha = 0.1
        showcase.backgroundColor = Colors.black.withAlphaComponent(0.5)
        showcase.targetHolderColor = Colors.white
        if !isCircle{
            showcase.targetHolderRadius = 0.0
        }
        showcase.show(completion: completion)
        showcase.layer.setValue(uniqueIdentifier, forKey: "unique")
        showcase.delegate = delegate
    }
}
