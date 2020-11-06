//
//  MapsConsigneeController.swift
//  NcsDealApps
//
//  Created by Nusantara Card Semesta on 10/08/20.
//  Copyright © 2020 Nusantara Card Semesta. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class MapsConsigneeController: UIViewController {

    @IBOutlet weak var mapKit: MKMapView!
    
    var delegate : MapCordinateDelegate?
    var location: CLLocation!
    
    private var locationManager : CLLocationManager!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.locationManager = CLLocationManager()
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
    }
    
    private var isZoom : Bool = false
    private func zoom(){
        let camera = MKMapCamera(lookingAtCenter: self.mapKit.userLocation.coordinate, fromEyeCoordinate: self.mapKit.userLocation.coordinate, eyeAltitude: 5000)
        self.mapKit.setCamera(camera, animated: true)
    }

}
extension MapsConsigneeController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(manager.location?.coordinate ?? "Nothing Found")
        self.mapKit.showsUserLocation = true
        self.zoom()
        delegate?.cordinates(cordinate: manager.location!.coordinate)
    }

}

extension CLLocation {
    func address(cordinate : CLLocationCoordinate2D, complition : @escaping (_ add : String?) -> ()) {
        let location = CLLocation(latitude: cordinate.latitude, longitude: cordinate.longitude)
        
        CLGeocoder().reverseGeocodeLocation(location) { (places, error) in
            if let place = places?.first {
                
                var addressString : String = ""
                if place.subLocality != nil {
                    addressString = addressString + place.subLocality! + ", "
                }
                if place.name != nil {
                    addressString = addressString + place.name! + ", "
                }
                if place.locality != nil {
                    addressString = addressString + place.locality! + ", "
                }
                if place.country != nil {
                    addressString = addressString + place.country! + ", "
                }
                if place.postalCode != nil {
                    addressString = addressString + place.postalCode! + ", "
                }
                if place.administrativeArea != nil {
                    addressString = addressString + place.administrativeArea! + ""
                }
                
                complition(addressString)
            }
        }
    }
}
