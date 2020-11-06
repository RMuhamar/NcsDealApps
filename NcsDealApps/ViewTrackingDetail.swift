//
//  ViewTrackingDetail.swift
//  NcsDealApps
//
//  Created by RMuhamaron 13/02/20.
//  Copyright © 2020 Nusantara Card Semesta. All rights reserved.
//

import UIKit

class ViewTrackingDetail: UITableViewCell {
    

    @IBOutlet weak var lPosition: UILabel!
    @IBOutlet weak var lDate: UILabel!
    @IBOutlet weak var lTime: UILabel!
    @IBOutlet weak var lBranch: UILabel!
    @IBOutlet weak var lRemarks: UILabel!
    
    var tracking:Tracking!
    var courier:String!
    var reason:String!
    var recipient:String!
    
    func setData(_ tracking:Tracking){
        self.tracking = tracking
        
        courier = tracking.courier
        reason = tracking.reason
        recipient = tracking.recipient
        
        lPosition.text = tracking.position
        lDate.text = tracking.date
        lTime.text = tracking.time
        lBranch.text = tracking.branch
        
        if tracking.awb.count == 13 {
            if recipient != "" {
                lRemarks.text = tracking.recipient
            }else{
                if reason != ""{
                    lRemarks.text = tracking.reason
                }else{
                    lRemarks.text = tracking.courier
                }
            }
        }else if tracking.awb.count == 11 {
            lRemarks.text = tracking.remarks
        }else{
            
        }
        
        
        
    }
    
}


