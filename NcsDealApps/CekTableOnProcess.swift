//
//  CekTableOnProcess.swift
//  NcsDealApps
//
//  Created by Nusantara Card Semesta on 22/07/20.
//  Copyright © 2020 Nusantara Card Semesta. All rights reserved.
//

import Foundation

class CekTableOnProcess {
    
    var Awb:String
    var PuBookNo:String
    var Date:String
    var Time:String
    var Service:String
    var Transport:String
    var Remarks:String
    
    init(_ Awb:String, _ PuBookNo:String, _ Date:String, _ Time:String, _ Service:String, _ Transport:String,_ Status:String, _ Remarks:String){
        self.Awb = Awb
        self.PuBookNo = PuBookNo
        self.Date = Date
        self.Time = Time
        self.Service = Service
        self.Transport = Transport
        self.Remarks = Remarks
        
      }
}
