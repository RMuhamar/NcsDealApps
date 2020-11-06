//
//  Tracking.swift
//  NcsDealApps
//
//  Created by RMuhamar on 13/02/20.
//  Copyright © 2020 Nusantara Card Semesta. All rights reserved.
//

import Foundation

class Tracking{

    var position:String
    var date:String
    var time:String
    var branch:String
    var courier:String
    var recipient:String
    var reason:String
    var remarks:String
    var awb:String
  
    init(_ position:String, _ date:String, _ time:String, _ branch:String, _ courier:String, _ recipient:String, _ reason:String, _ remarks:String, _ awb:String){
        self.position = position
        self.date = date
        self.time = time
        self.branch = branch
        self.courier = courier
        self.recipient = recipient
        self.reason = reason
        self.remarks = remarks
        self.awb = awb
    }
}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


