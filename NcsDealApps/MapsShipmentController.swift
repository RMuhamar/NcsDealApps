//
//  MapsShipmentController.swift
//  NcsDealApps
//
//  Created by Nusantara Card Semesta on 12/08/20.
//  Copyright © 2020 Nusantara Card Semesta. All rights reserved.
//

import UIKit
import GoogleMaps
import Alamofire
import SwiftyJSON

class MapsShipmentController: UIViewController {

    @IBOutlet weak var googleMaps: GMSMapView!
    private let locationManager = CLLocationManager()
    var address:String!
    var country:String!
    var state:String!
    var city:String!
    var pincode:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()

        // Do any additional setup after loading the view.
    }
    
    func getAddressFromLatLong(latitude: Double, longitude : Double) {
        let url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=\(latitude),\(longitude)&key=AIzaSyA8ltlASJln-nww4Mhukujo4b5Bdvsdhpg"

        AF.request(url).validate().responseJSON { response in
            switch response.result {
            case .success:

                let responseJson = response.result.value! as! NSDictionary

                if let results = responseJson.object(forKey: "results")! as? [NSDictionary] {
                    if results.count > 0 {
                        if let addressComponents = results[0]["address_components"]! as? [NSDictionary] {
                            self.address = results[0]["formatted_address"] as? String
                            for component in addressComponents {
                                if let temp = component.object(forKey: "types") as? [String] {
                                    if (temp[0] == "postal_code") {
                                        self.pincode = component["long_name"] as? String
                                    }
                                    if (temp[0] == "locality") {
                                        self.city = component["long_name"] as? String
                                    }
                                    if (temp[0] == "administrative_area_level_1") {
                                        self.state = component["long_name"] as? String
                                    }
                                    if (temp[0] == "country") {
                                        self.country = component["long_name"] as? String
                                    }
                                }
                            }
                        }
                    }
                }
                print("\(self.address), \(self.city), \(self.state), \(self.country)")
            case .failure(let error):
                print(error)
            }
        }
    }

}

extension MapsShipmentController: CLLocationManagerDelegate {
  // 2
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    // 3
    guard status == .authorizedWhenInUse else {
      return
    }
    // 4
    locationManager.startUpdatingLocation()
      
    //5
    googleMaps.isMyLocationEnabled = true
    googleMaps.settings.myLocationButton = true
    googleMaps.settings.compassButton = true
    googleMaps.settings.zoomGestures = true
    
  }
  
  // 6
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let location = locations.first else {
      return
    }
      
    // 7
    googleMaps.camera = GMSCameraPosition(target: location.coordinate, zoom: 18, bearing: 0, viewingAngle: 0)
    getAddressFromLatLong(latitude: Double(location.coordinate.latitude), longitude: Double(location.coordinate.longitude))
    let marker = GMSMarker()
    marker.position = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
//    marker.title =
    marker.map = self.googleMaps
    marker.icon = UIImage(named: "markerbranch")
    print(location.coordinate.self)
      
    // 8
    locationManager.stopUpdatingLocation()
  }
}
