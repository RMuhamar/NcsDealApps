//
//  Cektable.swift
//  NcsDealApps
//
//  Created by RMuhamar on 03/03/20.
//  Copyright © 2020 Nusantara Card Semesta. All rights reserved.
//

import Foundation

class Tablelist {
    
    var servicename:String
    var priamount:String
    var service:String
    var remarks:String
    var leadtimestart:String
    var leadtimeend:String
    var minimum:String
    
    init(_ servicename:String, _ priamount:String, _ service:String, _ remarks:String, _ leadtimestart:String, _ leadtimeend:String, _ minimum:String){
        self.servicename = servicename
        self.priamount = priamount
        self.service = service
        self.remarks = remarks
        self.leadtimestart = leadtimestart
        self.leadtimeend = leadtimeend
        self.minimum = minimum
        
      }
}
