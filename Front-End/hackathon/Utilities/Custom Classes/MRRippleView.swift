//
//  MRRippleView.swift
//  hackathon
//
//  Created by Mayank Rikh on 19/02/20.
//  Copyright © 2020 Mayank Rikh. All rights reserved.
//

import UIKit

class MRRippleView: UIView {

    @IBInspectable var start: Bool = false{
        willSet {
            if newValue{
                startAnimating()
            }else{
                endAnimating()
            }
        }
    }

    var timer : Timer?

    private func startAnimating(){

        if timer == nil{
            createRippleAndAnimate()
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(createRippleAndAnimate), userInfo: nil, repeats: true)
        }
    }

    private func endAnimating(){
        if timer != nil{
            timer?.invalidate()
            timer = nil
        }
    }

    @objc func createRippleAndAnimate(){

        let tempView = createRippleView()
        insertSubview(tempView, at: 0)
        UIView.animate(withDuration: 2.5, delay: 0.0, options: .curveEaseOut, animations: {
            tempView.transform = CGAffineTransform(scaleX: 3.0, y: 3.0)
            tempView.alpha = 0.0
        }) { (finished) in
            tempView.removeFromSuperview()
        }
    }

    private func createRippleView() -> UIView{

        let view = UIView(frame: bounds)
        view.isUserInteractionEnabled = false
        view.backgroundColor = UIColor(red: 255.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.5)
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 1.0
        view.clipsToBounds = true
        view.layer.cornerRadius = view.bounds.size.width/2.0
        return view
    }
}
