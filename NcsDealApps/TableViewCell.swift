//
//  TableViewCell.swift
//  NcsDealApps
//
//  Created by RMuhamar on 03/03/20.
//  Copyright © 2020 Nusantara Card Semesta. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var service: UILabel!
    @IBOutlet weak var serviceName: UILabel!
    @IBOutlet weak var day: UILabel!
    @IBOutlet weak var priAmount: UILabel!
    @IBOutlet weak var minimum: UILabel!
    
    var CekTable:Tablelist!
    
    func setData(_ tablelist:Tablelist){
        self.CekTable = tablelist
        
        if tablelist.priamount == "0 "{
            
            if (tablelist.remarks == "LBA") {
                priAmount.text = "Luar Batas Antaran";
            } else if (tablelist.remarks == "HBA") {
                priAmount.text = "Harga Belum Ada";
            } else {
                priAmount.text = "Harga Belum Tersedia";
            }
            
        }else{
            priAmount.text = tablelist.priamount
        }
        
        service.text = tablelist.service
        serviceName.text = tablelist.servicename
        day.text = tablelist.leadtimestart + "-" + tablelist.leadtimeend + " Hari"

        minimum.text =  tablelist.minimum
        
        
        
        
    }
    
}
