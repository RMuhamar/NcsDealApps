//
//  RegisterController.swift
//  NcsDealApps
//
//  Created by Nusantara Card Semesta on 31/03/20.
//  Copyright © 2020 Nusantara Card Semesta. All rights reserved.
//

import UIKit
import SearchTextField

class RegisterController: UIViewController {

    @IBOutlet weak var firsView:UIView!
    @IBOutlet weak var secondView:UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Do any additional setup after loading the view.

    }
    
    @IBAction func switchView(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 1 {
            firsView.alpha = 1
            secondView.alpha = 0
        }else {
            firsView.alpha = 0
            secondView.alpha = 1
        }
        
    }
    
    

}

