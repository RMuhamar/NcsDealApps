//
//  Interest.swift
//  NcsDealApps
//
//  Created by RMuhamar on 13/03/20.
//  Copyright © 2020 RMuhamar. All rights reserved.
//

import UIKit
import ImageSlideshow

class Interest {
    // Mark : Public Api
    var title1 = ""
    var title2 = ""
    var title3 = ""
    var featuredImage:KingfisherSource
    var color:UIColor
    
    init(title1:String ,title2:String ,title3:String ,featuredImage:KingfisherSource,color:UIColor) {
        self.title1 = title1
        self.title2 = title2
        self.title3 = title3
        self.featuredImage = featuredImage
        self.color = color
    }
    
    static func fetchInterests() -> [Interest]{
        return [
            Interest (title1:"REGULER SERVICE" ,title2:"Est. pengiriman 2-3 Hari" ,title3:"#NRS", featuredImage:KingfisherSource(urlString: "https://idss.ptncs.com/api/php/ncs_deal/images/nrs.png")!,color:UIColor(red: 63/255.0, green: 71/255.0, blue: 80/255.0, alpha: 0.8)),
            Interest (title1:"ONE NIGHT SERVICE" ,title2:"Est. pengiriman 1 Hari" ,title3:"#ONS", featuredImage:KingfisherSource(urlString: "https://idss.ptncs.com/api/php/ncs_deal/images/ons.png")!,color: UIColor(red: 240/255.0, green: 133/255.0, blue: 91/255.0, alpha: 0.8)),
            Interest (title1:"SAME DAY SERVICE" ,title2:"Est. pengiriman 0 Hari" ,title3:"#SDS", featuredImage:KingfisherSource(urlString: "https://idss.ptncs.com/api/php/ncs_deal/images/sds.png")!,color: UIColor(red: 105/255.0, green: 80/255.0, blue: 227/255.0, alpha: 0.8)),
            Interest (title1:"DARAT REGULAR" ,title2:"Est. pengiriman 2-5 Hari" ,title3:"#DARAT", featuredImage:KingfisherSource(urlString: "https://idss.ptncs.com/api/php/ncs_deal/images/daratregular.png")!,color: UIColor(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 0.8)),
            Interest (title1:"DARAT MURAH" ,title2:"Est. pengiriman 2-5 Hari" ,title3:"#DARATMURAH", featuredImage:KingfisherSource(urlString: "https://idss.ptncs.com/api/php/ncs_deal/images/daratpromo.png")!,color: UIColor(red: 120/255.0, green: 230/255.0, blue: 120/255.0, alpha: 0.8)),
            Interest (title1:"CORPORATE PRICE" ,title2:"With agreements" ,title3:"#CORPRICE", featuredImage:KingfisherSource(urlString: "https://idss.ptncs.com/api/php/ncs_deal/images/corporate.png")!,color: UIColor(red: 240/255.0, green: 140/255.0, blue: 200/255.0, alpha: 0.8))
        ]
    }
    
}
