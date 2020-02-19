//
//  HomeViewController.swift
//  hackathon
//
//  Created by Mayank Rikh on 19/02/20.
//  Copyright © 2020 Mayank Rikh. All rights reserved.
//

import MapKit
import UIKit

class HomeViewController: BaseViewController {

    @IBOutlet weak var mapView : MKMapView!

    private var workItem : DispatchWorkItem?
    private var coordinate : CLLocationCoordinate2D?
    private let radius = 1000.0

    override func viewDidLoad() {
        super.viewDidLoad()

        initialSetup()
    }

    //MARK:- Private
    private func initialSetup(){

        navigationController?.setNavigationBarHidden(true, animated: true)
        LocationManager.shared.delegate = self

        if let coordinate = self.coordinate{
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

        mapView.removeAnnotations(mapView.annotations)
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
