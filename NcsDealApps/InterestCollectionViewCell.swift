//
//  InterestCollectionViewCell.swift
//  NcsDealApps
//
//  Created by RMuhamaron 12/03/20.
//  Copyright © 2020 RMuhamar. All rights reserved.
//

import UIKit
import ImageSlideshow

class InterestCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var img: ImageSlideshow!
    @IBOutlet weak var backgroundImageView:UIView!
    @IBOutlet weak var label1:UILabel!
    @IBOutlet weak var label2:UILabel!
    @IBOutlet weak var label3:UILabel!
    
    var interest:Interest!{
        didSet {
            self.updateUI()
        }
    }
    
    func updateUI(){
        if let interest = interest {
            img.setImageInputs([interest.featuredImage])
            backgroundImageView.backgroundColor = interest.color
            label1.text = interest.title1
            label2.text = interest.title2
            label3.text = interest.title3
        }else{
            img.setImageInputs([interest.featuredImage])
            label1.text = nil
            label2.text = nil
            label3.text = nil
        }
        backgroundImageView.layer.cornerRadius = 10.0
        backgroundImageView.layer.masksToBounds = true
    }
    
    
}
