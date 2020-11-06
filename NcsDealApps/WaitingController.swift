//
//  WaitingController.swift
//  NcsDealApps
//
//  Created by Nusantara Card Semesta on 29/08/20.
//  Copyright © 2020 Nusantara Card Semesta. All rights reserved.
//

import UIKit

class WaitingController: UIViewController {

    @IBOutlet weak var viewWaiting: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewWaiting.roundCornersSucces(corners: [.topLeft, .topRight], radius: 30)
    }
    

}
extension UIView {
   func roundCornersSucces(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
