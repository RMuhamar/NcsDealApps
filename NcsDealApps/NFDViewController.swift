//
//  NFDViewController.swift
//  NcsDealApps
//
//  Created by Nusantara Card Semesta on 27/07/20.
//  Copyright © 2020 Nusantara Card Semesta. All rights reserved.
//

import UIKit

class NFDViewController: UIViewController {

    @IBOutlet weak var viewShipper: UIView!
    @IBOutlet weak var viewConsignee: UIView!
    @IBOutlet weak var viewShipment: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viewShipper = UITapGestureRecognizer(target: self, action:  #selector(self.intentShipper))
        self.viewShipper.addGestureRecognizer(viewShipper)
        
        let viewConsignee = UITapGestureRecognizer(target: self, action:  #selector(self.intentConsignee))
        self.viewConsignee.addGestureRecognizer(viewConsignee)
        
        let viewShipment = UITapGestureRecognizer(target: self, action:  #selector(self.intentShipment))
        self.viewShipment.addGestureRecognizer(viewShipment)

        // Do any additional setup after loading the view.
    }
    
    @objc func intentShipper(sender : UITapGestureRecognizer) {
        let ShipperVc = self.storyboard?.instantiateViewController(withIdentifier: "ShipperNfdController") as! ShipperNfdController
            self.navigationController?.pushViewController(ShipperVc, animated: true)
    }
    
    @objc func intentConsignee(sender : UITapGestureRecognizer) {
        let ConsigneeVc = self.storyboard?.instantiateViewController(withIdentifier: "ConsigneeNfdController") as! ConsigneeNfdController
            self.navigationController?.pushViewController(ConsigneeVc, animated: true)
    }
    
    @objc func intentShipment(sender : UITapGestureRecognizer) {
        let ShipmentVc = self.storyboard?.instantiateViewController(withIdentifier: "ShipmentNfdController") as! ShipmentNfdController
            self.navigationController?.pushViewController(ShipmentVc, animated: true)
    }

}
