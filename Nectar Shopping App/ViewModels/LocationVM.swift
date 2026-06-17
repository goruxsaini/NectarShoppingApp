//
//  LocationVM.swift
//  Nectar Shopping App
//
//  Created by Goru Saini on 07/06/26.
//

import Foundation
import MapKit
final class LocationVM {
    var onLocationFound : ((LocationModel) -> Void)?
    var onError : ((String) -> Void)?
    
    func searchLocation(_ locationName : String) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = locationName
        
        let search = MKLocalSearch(request: request)
        
        search.start { [weak self] response, error in
            guard let self = self else { return }
            //If error occurs
            if let error = error {
                self.onError?(error.localizedDescription)
                return
            }
            //Get first matching location
            guard let item = response?.mapItems.first else {
                //if no location found return error to vc
                self.onError?("No Location Found")
                return
            }
            let model = LocationModel(name: locationName, coordinate: item.placemark.coordinate)
            self.onLocationFound?(model)
        }
    }
}
