//
//  BranchCounter.swift
//  NcsDealApps
//
//  Created by RMuhamar on 17/02/20.
//  Copyright © 2020 RMuhamar. All rights reserved.
//

import UIKit
import GoogleMaps
import Alamofire
import SwiftyJSON

class BranchCounter: UIViewController {

    @IBOutlet weak var mapView: GMSMapView!
    let server = Server()
    
    private let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        loadData()

    }
    
    private func loadData(){

            AF.request(self.server.URL_MARKER, method: .get)
            .responseJSON {(response) in

    //        let json = JSON(response.result.value!)
                    switch response.result{
                    case .success(let value):
                        
                        var Branch:String?
                        var Street:String?
                        var Lat:String?
                        var Lng:String?

                        let json = JSON(value)

                        if json == JSON.null {
                            print ("Data Kosong")
                        }else{
                            for i in 0 ..< json.count{

                                Branch = json[i]["Branch"].string
                                Street = json[i]["Street"].string
                                Lat = json[i]["Lat"].string
                                Lng = json[i]["Lng"].string
                                
                                let marker = GMSMarker()
                                marker.position = CLLocationCoordinate2D(latitude: Double(Lat!) as! CLLocationDegrees, longitude: Double(Lng!) as! CLLocationDegrees)
                                marker.title = Branch
                                marker.snippet = Street
                                marker.map = self.mapView
                                marker.icon = UIImage(named: "markerbranch")
                                
                                
                            }
                            
                        }

                        break
                    case .failure:
                        print("Connection Error")
                        break
                    }
            }

        }
    
}
// MARK: - CLLocationManagerDelegate
//1
extension BranchCounter: CLLocationManagerDelegate {
  // 2
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    // 3
    guard status == .authorizedWhenInUse else {
      return
    }
    // 4
    locationManager.startUpdatingLocation()
      
    //5
    mapView.isMyLocationEnabled = true
    mapView.settings.myLocationButton = true
    mapView.settings.compassButton = true
    mapView.settings.zoomGestures = true
    
  }
  
  // 6
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let location = locations.first else {
      return
    }
      
    // 7
    mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 18, bearing: 0, viewingAngle: 0)
      
    // 8
    locationManager.stopUpdatingLocation()
  }
}

