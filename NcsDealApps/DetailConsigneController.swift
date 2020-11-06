//
//  DetailConsigneController.swift
//  NcsDealApps
//
//  Created by Nusantara Card Semesta on 10/08/20.
//  Copyright © 2020 Nusantara Card Semesta. All rights reserved.
//

import UIKit
import CoreLocation

class DetailConsigneController: UIViewController {

    @IBOutlet weak var consAddress: UILabel!
    @IBOutlet weak var consAddressDetail: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func cordinates(cordinate:CLLocationCoordinate2D) {
        CLLocation().address(cordinate: cordinate){ (address) in
            print(address ?? "NOT FOUND")
            let address    = address
            let fulladd = address!.components(separatedBy: ", ")

            let Kecamatan:String? = fulladd[2]
            
            self.consAddress.text = Kecamatan
            self.consAddressDetail.text = address
        }
    }

}
