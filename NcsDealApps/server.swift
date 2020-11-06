//
//  server.swift
//  NcsDealApps
//
//  Created by RMuhamar on 19/03/20.
//  Copyright © 2020 Nusantara Card Semesta. All rights reserved.
//

import Foundation

class Server {
    
//    var URL:String = "https://api.ptncs.com/idss/android/php/ncs_price_tracking/"
//    var URL_NCSDEAL:String = "https://api.ptncs.com/idss/android/php/ncs_deal/"
    var URL_NCSDEAL:String = "https://apimobile.ptncs.com/php/ncs_deal/"
    var URL_MARKER:String = "https://api.ptncs.com/bot/ncsdealmarker/idss/idss123!"
    
    var LOGIN_SUCCESS = "success"
    
    var CheckPointList:String = "getCheckpointListIDSS.php?"
    var CheckPointListTTM:String = "getCheckpointListTTM.aspx?"
    var GetTracking:String = "getTrackingIDSS.php?"
    var GetTrackingTTM:String = "getTrackingTTM.aspx?"
    var GetProvinsi:String = "getProvinsi_v2.php"
    var GetKabupaten:String = "getKabupaten_v2.php?"
    var GetPrice:String = "getPriceByIDIos.php?"
    var GetData:String = "getUserData.php?"
    var GetBasicPrice = "basicCost.php?"
    var GetKecID = "getKecID.php?"
    var RequestPickup = "requestPickup.php"
    var ListOnProcess = "getListPickup.php?"
    var ListOnSuccess = "getListPickupSuccess.php?"
    var Login:String = "login.php"
    var GET_SEARCH_DATA_CORPORATE:String = "getSearchDataCorporate.php?"
    var URL_SIGNUP = "userRegister.php";
    
}
