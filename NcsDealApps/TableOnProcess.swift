//
//  TableOnProcess.swift
//  NcsDealApps
//
//  Created by Nusantara Card Semesta on 22/07/20.
//  Copyright © 2020 Nusantara Card Semesta. All rights reserved.
//

import UIKit

class TableOnProcess:UITableViewCell{
    
    @IBOutlet weak var lAwb: UILabel!
    @IBOutlet weak var lPuBookNo: UILabel!
    @IBOutlet weak var lDate: UILabel!
    @IBOutlet weak var lTime: UILabel!
    @IBOutlet weak var lService: UILabel!
    @IBOutlet weak var lTransport: UILabel!
    @IBOutlet weak var txtRemarks: UITextField!
    
    var CekTable:CekTableOnProcess!
    
    func setData(_ tablelist:CekTableOnProcess){
        self.CekTable = tablelist
        lAwb.text = tablelist.Awb
        lPuBookNo.text = tablelist.PuBookNo
        lDate.text = tablelist.Date
        lTime.text = tablelist.Time
        lService.text = tablelist.Service
        lTransport.text = tablelist.Transport
        txtRemarks.text = tablelist.Remarks
    }
}
