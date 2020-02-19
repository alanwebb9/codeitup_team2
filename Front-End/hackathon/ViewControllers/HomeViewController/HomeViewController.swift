//
//  HomeViewController.swift
//  hackathon
//
//  Created by Mayank Rikh on 19/02/20.
//  Copyright © 2020 Mayank Rikh. All rights reserved.
//

import MaterialShowcase
import FontAwesome_swift
import Contacts
import MapKit
import UIKit

class HomeViewController: BaseViewController {

    @IBOutlet weak var rippleView: MRRippleView!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var emergencyButton: UIButton!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var mapView : MKMapView!

    private let viewModel = HomeViewModel()
    private var workItem : DispatchWorkItem?
    private var coordinate : CLLocationCoordinate2D?
    private let radius = 20000.0
    private var timer : Timer?
    private var firstTime = true

    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }

    override func viewDidLayoutSubviews() {

        super.viewDidLayoutSubviews()
        emergencyButton.layer.cornerRadius = emergencyButton.bounds.height/2.0
    }

    override func viewDidAppear(_ animated: Bool) {

        super.viewDidAppear(animated)
        if firstTime{
            viewModel.updateData()
            Utilities.showTutorial(on: emergencyButton, primaryText: "Emergency Button!", secondaryText: "Press and hold for 3 seconds to send a message to the cops!", isCircle: true, delegate: self, uniqueIdentifier: 0, completion: nil)
            firstTime = false
        }
    }

    //MARK:- IBAction
    @IBAction func leftAction(_ sender: UIButton) {
        updateTitle(type: viewModel.previousType())
    }

    @IBAction func rightAction(_ sender: UIButton) {
        updateTitle(type: viewModel.nextType())
    }

    @IBAction func touchDownEmergency(_ sender: UIButton) {
        rippleView.start = true
        timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false, block: { [weak self] (timer) in
            self?.stopEmergency()
            self?.showAlert(StringConstants.success.localized, withMessage: StringConstants.successBroadcast.localized, withCompletion: nil)
        })
    }

    @IBAction func touchUpEmergency(_ sender: UIButton) {
        stopEmergency()
    }

    @IBAction func touchUpOutsideEmergency(_ sender: UIButton) {
        stopEmergency()
    }

    //MARK:- Private
    private func updateTitle(type : HomeViewModel.DataType){
        typeTextField.text = type.text
    }

    private func stopEmergency(){
        rippleView.start = false
        timer?.invalidate()
        timer = nil
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
        mapView.delegate = self

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

        mapView.removeAnnotations(mapView.annotations)
        viewModel.pinDataArray.forEach { [weak self] (annotation) in
            let coordinate = CLLocationCoordinate2D(latitude: annotation.lat, longitude: annotation.long)
            self?.dropPin(coordinate: coordinate, title: annotation.name, subTitle: annotation.subtitle)
        }
    }
}

extension HomeViewController : MKMapViewDelegate{

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        guard let annotation = annotation as? Annotation else { return nil }
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }

    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {

        guard let location = view.annotation as? Annotation else {return}
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        let placemark = MKPlacemark(coordinate: location.coordinate, addressDictionary: [CNPostalAddressStreetKey : location.subtitle ?? ""])
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.openInMaps(launchOptions: launchOptions)
    }
}

extension HomeViewController : MaterialShowcaseDelegate{

    func showCaseDidDismiss(showcase: MaterialShowcase, didTapTarget: Bool) {


    }
}
