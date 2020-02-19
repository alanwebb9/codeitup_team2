//
//  HomeViewController.swift
//  hackathon
//
//  Created by Mayank Rikh on 19/02/20.
//  Copyright © 2020 Mayank Rikh. All rights reserved.
//

import FontAwesome_swift
import MapKit
import UIKit

class HomeViewController: BaseViewController {

    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var emergencyButton: UIButton!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var mapView : MKMapView!

    private let viewModel = HomeViewModel()
    private var workItem : DispatchWorkItem?
    private var coordinate : CLLocationCoordinate2D?
    private let radius = 1000.0

    override func viewDidLoad() {
        super.viewDidLoad()

        initialSetup()
    }

    override func viewDidLayoutSubviews() {

        super.viewDidLayoutSubviews()
        emergencyButton.layer.cornerRadius = emergencyButton.bounds.height/2.0
    }

    //MARK:- IBAction
    @IBAction func leftAction(_ sender: UIButton) {
        updateTitle(type: viewModel.previousType())
    }

    @IBAction func rightAction(_ sender: UIButton) {
        updateTitle(type: viewModel.nextType())
    }

    //MARK:- Private
    private func updateTitle(type : HomeViewModel.DataType){
        typeTextField.text = type.text
    }

    private func initialSetup(){

        emergencyButton.setTitle(nil, for: .normal)
        emergencyButton.backgroundColor = Colors.red
        emergencyButton.layer.borderColor = Colors.white.cgColor
        emergencyButton.layer.borderWidth = 3.0

        titleView.backgroundColor = Colors.clear
        typeTextField.text = viewModel.type.text
        typeTextField.backgroundColor = Colors.white
        typeTextField.layer.cornerRadius = 10.0
        titleView.addShadow(3.0)

        navigationController?.setNavigationBarHidden(true, animated: true)
        LocationManager.shared.delegate = self
        mapView.showsUserLocation = true

        viewModel.delegate = self

        configureSideButton(button : leftButton, text : FontAwesome.arrowLeft)
        configureSideButton(button : rightButton, text : FontAwesome.arrowRight)

        if let coordinate = coordinate{
            focus(coordinate: coordinate, title: nil, subTitle: nil)
        }else{
            let locationStatus = LocationManager.shared.locationEnabled
            if locationStatus.granted{
                if let current = LocationManager.shared.currentLocation{
                    focus(coordinate: current.coordinate, title: nil, subTitle: nil)
                }
            }
        }
    }

    private func configureSideButton(button : UIButton, text : FontAwesome){

        let leftText = String.fontAwesomeIcon(name: text)
        button.setTitle(leftText, for: .normal)
        button.setTitleColor(Colors.black, for: .normal)
        button.titleLabel?.font = UIFont.fontAwesome(ofSize: 20.0, style: .solid)
        button.backgroundColor = Colors.clear
    }

    private func show(coordinate : CLLocationCoordinate2D, title : String?, subTitle : String?){
        let coordinateRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: radius, longitudinalMeters: radius)
        mapView.setRegion(coordinateRegion, animated: true)
        dropPin(coordinate: coordinate, title: title, subTitle: subTitle)
    }

    private func focus(coordinate : CLLocationCoordinate2D, title : String?, subTitle : String?){

        workItem?.cancel()
        let item = DispatchWorkItem{ [weak self] in
            self?.show(coordinate : coordinate, title : title, subTitle : subTitle)
        }

        workItem = item
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: item)
    }



    private func dropPin(coordinate : CLLocationCoordinate2D, title : String?, subTitle : String?){

        let annotation = Annotation(title: title, subTitle: subTitle, coordinate: coordinate)
        mapView.addAnnotation(annotation)
    }
}

extension HomeViewController : LocationManagerDelegate{

    func statusChangedToAllowed() {}

    func didFetchLocation() {

        guard let current = LocationManager.shared.currentLocation else {return}
        focus(coordinate: current.coordinate, title: nil, subTitle: nil)
    }

    func locationFetchError() {}
}

extension HomeViewController : HomeViewModelDelegate{

    func reloadData() {

        
    }
}
