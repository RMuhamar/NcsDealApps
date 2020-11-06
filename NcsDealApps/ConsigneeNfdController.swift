//
//  ConsigneeNfdController.swift
//  NcsDealApps
//
//  Created by Nusantara Card Semesta on 10/08/20.
//  Copyright © 2020 Nusantara Card Semesta. All rights reserved.
//

import UIKit
import OverlayContainer
import CoreLocation

protocol MapCordinateDelegate {
    func cordinates(cordinate:CLLocationCoordinate2D)
}

class ConsigneeNfdController: OverlayContainerViewController {

    private var detailController : DetailConsigneController!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let story = UIStoryboard(name: "Main", bundle: nil)
        
        let mapController = story.instantiateViewController(withIdentifier: "MapsConsigneeController") as!  MapsConsigneeController
        mapController.delegate = self
        
        detailController = story.instantiateViewController(withIdentifier: "DetailConsigneController") as! DetailConsigneController
        
        self.viewControllers = [mapController, detailController]
        self.delegate = self
    }

}

extension ConsigneeNfdController : OverlayContainerViewControllerDelegate {
    func overlayContainerViewController(_ containerViewController: OverlayContainerViewController, heightForNotchAt index: Int, availableSpace: CGFloat) -> CGFloat {
        switch Notches.allCases[index] {
        case .minimum:
            return availableSpace * 1/5
        case .medium:
            return availableSpace/2
        case .maximum:
            return availableSpace
        }
    }
    
    func numberOfNotches(in containerViewController: OverlayContainerViewController) -> Int {
        return Notches.allCases.count
    }
}
 
extension ConsigneeNfdController: MapCordinateDelegate{
    func cordinates(cordinate : CLLocationCoordinate2D) {
        detailController.cordinates(cordinate: cordinate)
    }
}

enum Notches : Int, CaseIterable {
    case minimum, medium, maximum
}
