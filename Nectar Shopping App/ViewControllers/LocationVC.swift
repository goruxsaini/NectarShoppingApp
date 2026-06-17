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
        
        
        txtFldZone.returnKeyType = .next
        
        btnSubmit.configureBtn(title: "Submit", font: AppFonts.semibold.with(size: 20), bgClr: .primaryGreen, tint: .white,border: 1,borderColor: AppColors.textBlack)
        mapView.layer.cornerRadius = 15
        mapView.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        mapView.layer.masksToBounds = true
        
        
        txtFldView.layer.cornerRadius = 30
        txtFldView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        txtFldView.layer.masksToBounds = true
        
        txtFldZone.delegate = self
        txtFldZone.tag = 0
    }
    //MARK: -  action buttons
    // back action button
    @IBAction func actnBtnBack(_ sender: Any) {
        backToPop()
    }
    
    //action button for moving further after selecting locations
    @IBAction func actnBtnSubmit(_ sender: Any) {
//        let isValid = viewModel.validate(area: txtFldArea.text, zone: txtFldZone.text)
//        print(isValid)
        searchLocation()
    }
    private func searchLocation(){
        
        guard let locationName = txtFldZone.text, !locationName.isEmpty else { return }
        print("Searching:", locationName)
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = locationName
        let search = MKLocalSearch(request: request)
        search.start { [weak self] response , error in
            guard let self = self else { return }
            print("Response:", response as Any)
            print("Error:", error as Any)
            guard let item = response?.mapItems.first else {
                print("No Location Found")
                return }
            let coordinate = item.placemark.coordinate
            //Adds the pin to the desired location.
            self.mapView.removeAnnotations(self.mapView.annotations)
            let pin = MKPointAnnotation()
            pin.coordinate = coordinate
            pin.title = locationName
            self.mapView.addAnnotation(pin)
            let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
            self.mapView.setRegion(region, animated: true)
        }
    }
}
extension LocationVC : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtFldZone {
            searchLocation()
        }
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
