//
//  ShipperNfdController.swift
//  NcsDealApps
//
//  Created by Nusantara Card Semesta on 03/08/20.
//  Copyright © 2020 Nusantara Card Semesta. All rights reserved.
//

import UIKit
import MapKit

class ShipperNfdController: UIViewController {

    @IBOutlet weak var map: MKMapView!
    
          override func viewDidLoad() {
              super.viewDidLoad()
              
              let sourceLocation = CLLocationCoordinate2D(latitude: -6.3707576, longitude: 106.7182987)
              let destinationLocation = CLLocationCoordinate2D(latitude: -6.1890586, longitude: 106.7988119)
              
              createPath(sourceLocation: sourceLocation, destinationLocation: destinationLocation)
              
            self.map.delegate = self
          }
       
          func createPath(sourceLocation : CLLocationCoordinate2D, destinationLocation : CLLocationCoordinate2D) {
              let sourcePlaceMark = MKPlacemark(coordinate: sourceLocation, addressDictionary: nil)
              let destinationPlaceMark = MKPlacemark(coordinate: destinationLocation, addressDictionary: nil)
              
              
              let sourceMapItem = MKMapItem(placemark: sourcePlaceMark)
              let destinationItem = MKMapItem(placemark: destinationPlaceMark)
              
              
              let sourceAnotation = MKPointAnnotation()
              sourceAnotation.title = "Rumah"
              sourceAnotation.subtitle = "Rumahnya Eza"
              if let location = sourcePlaceMark.location {
                  sourceAnotation.coordinate = location.coordinate
              }
              
              let destinationAnotation = MKPointAnnotation()
              destinationAnotation.title = "Kantor"
              destinationAnotation.subtitle = "Nusantara Card Semesta"
              if let location = destinationPlaceMark.location {
                  destinationAnotation.coordinate = location.coordinate
              }
              
              self.map.showAnnotations([sourceAnotation, destinationAnotation], animated: true)
              
              
              
              let directionRequest = MKDirections.Request()
              directionRequest.source = sourceMapItem
              directionRequest.destination = destinationItem
              directionRequest.transportType = .automobile
              
              let direction = MKDirections(request: directionRequest)
              
              
              direction.calculate { (response, error) in
                  guard let response = response else {
                      if let error = error {
                          print("ERROR FOUND : \(error.localizedDescription)")
                      }
                      return
                  }
                  
                  let route = response.routes[0]
                  self.map.addOverlay(route.polyline, level: MKOverlayLevel.aboveRoads)
                  
                  let rect = route.polyline.boundingMapRect
                  
                  self.map.setRegion(MKCoordinateRegion(rect), animated: true)
                  
        }
    }
       
}
       
extension ShipperNfdController : MKMapViewDelegate {
  func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
      let rendere = MKPolylineRenderer(overlay: overlay)
      rendere.lineWidth = 5
      rendere.strokeColor = .systemBlue
      
      return rendere
  }
}

