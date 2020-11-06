//
//  ShipmentNfdController.swift
//  NcsDealApps
//
//  Created by Nusantara Card Semesta on 12/08/20.
//  Copyright © 2020 Nusantara Card Semesta. All rights reserved.
//

import UIKit
import OverlayContainer

class ShipmentNfdController: OverlayContainerViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let story = UIStoryboard(name: "Main", bundle: nil)
        
        let mapController = story.instantiateViewController(withIdentifier: "MapsShipmentController") as!  MapsShipmentController
        
        let detailController = story.instantiateViewController(withIdentifier: "DetailShipmentController") as! DetailShipmentController
        
        self.viewControllers = [mapController, detailController]
//        self.delegate = self
    }

}
extension ShipmentNfdController : OverlayContainerViewControllerDelegate {
    func overlayContainerViewController(_ containerViewController: OverlayContainerViewController, heightForNotchAt index: Int, availableSpace: CGFloat) -> CGFloat {
        switch not.allCases[index] {
        case .minimum:
            return availableSpace * 1/5
        case .medium:
            return availableSpace/2
        case .maximum:
            return availableSpace
        }
    }
    
    func numberOfNotches(in containerViewController: OverlayContainerViewController) -> Int {
        return not.allCases.count
    }

}
enum not : Int, CaseIterable {
       case minimum, medium, maximum
}


