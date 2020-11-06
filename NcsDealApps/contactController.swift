//
//  contactController.swift
//  NcsDealApps
//
//  Created by RMuhamar on 06/03/20.
//  Copyright © 2020 Nusantara Card Semesta. All rights reserved.
//

import UIKit

class contactController: UIViewController{
    
    @IBOutlet weak var viewClick: UIView!
    @IBOutlet weak var link: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        updateTextLabel()
        updateTextLabel2()
        // Do any additional setup after loading the view.
        
    }
    
//    func updateTextLabel(){
//        let path = "http://ncskurir.com/"
//        let text = linkncskurir.text ?? ""
//        let attributedString = NSAttributedString.makeHyperLink(for: path, in: text, as: "ncskurir.com")
//        linkncskurir.attributedText = attributedString
//    }
    
    func updateTextLabel2(){
        let path = "http://ncskurir.com/"
        let text = link.text ?? ""
        let attributedString = NSAttributedString.makeHyperLink(for: path, in: text, as: "ncskurir.com")
        link.attributedText = attributedString
    }

}
