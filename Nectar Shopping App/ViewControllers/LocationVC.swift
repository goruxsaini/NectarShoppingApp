//
//  LocationVC.swift
//  Nectar Shopping App
//
//  Created by Goru Saini on 04/06/26.
//

import UIKit
import MapKit
class LocationVC: UIViewController {
    //MARK: - OUTLETS
    
    @IBOutlet weak var txtFldView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var txtFldZone: UITextField!
    @IBOutlet weak var btnSubmit: UIButton!
    
    var viewModel = LocationVM()
    var locationManager : CLLocationManager?
    //MARK: -Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackgroundImage(named: "AppBackground")
        setupUI()
        dismissKeyboardOntap()
        mapView.addSubview(btnBack)
        mapView.showsUserLocation = true
        bindingModel()
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.requestLocation()
    }
    private func setupUI(){
        
        lblTitle.text = "Select Your Location"
        lblTitle.font = AppFonts.semibold.with(size: 25)
        lblTitle.textColor = AppColors.textBlack
        lblTitle.textAlignment = .center
        
        txtFldZone.font = AppFonts.medium.with(size: 17)
        txtFldZone.textColor = AppColors.textBlack
        txtFldZone.returnKeyType = .search
        
        btnSubmit.configureBtn(title: "Submit", font: AppFonts.semibold.with(size: 20), bgClr: .primaryGreen, tint: .white ,border: 1,borderColor: AppColors.textBlack)
        
        mapView.layer.cornerRadius = 15
        mapView.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        mapView.layer.masksToBounds = true
        
        txtFldView.layer.cornerRadius = 30
        txtFldView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        txtFldView.layer.masksToBounds = true
        
        txtFldZone.delegate = self
        txtFldZone.tag = 0
    }
    private func bindingModel() {
        viewModel.onLocationFound = { [weak self] location in
            guard let self = self else { return }
            self.updateMap(location)
        }
    }
    private func updateMap(_ location: LocationModel) {
        // Remove old pins
        mapView.removeAnnotations(mapView.annotations)
        let pin = MKPointAnnotation()
        pin.coordinate = location.coordinate
        pin.title = location.name
        mapView.addAnnotation(pin)
        let region = MKCoordinateRegion(center: location.coordinate,latitudinalMeters: 1000,longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
    }
    private func navigateToHome(){
        let vc = storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        navigationController?.setViewControllers([vc], animated: true)
    }
    //MARK: -  action buttons
    // back action button
    @IBAction func actnBtnBack(_ sender: Any) {
        backToPop()
    }
    
    //action button for moving further after selecting locations
    @IBAction func actnBtnSubmit(_ sender: Any) {

        guard let locationName = txtFldZone.text,!locationName.isEmpty else {
            showAlert(msg: "Please Select Location")
            return
        }
        UserDefaults.standard.set(locationName, forKey: "selectedLocation")
//        viewModel.searchLocation(locationName)
//this userdefaults is to save the login state to check if user has logged in or logged out.
        UserDefaults.standard.set(true, forKey: "isLoggedIn")
        navigateToHome()
    }
}
extension LocationVC : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let locationName = txtFldZone.text,!locationName.isEmpty else { return true }
        viewModel.searchLocation(locationName)
        textField.resignFirstResponder()
        return true
    }
}
extension LocationVC : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        
        let coordinate = location.coordinate
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 750, longitudinalMeters: 750)
        mapView.setRegion(region, animated: true)
        
        print(location.coordinate.latitude)
        print(location.coordinate.longitude)
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(error)
    }
}

