//
//  PageTracking.swift
//  NcsDealApps
//
//  Created by RMuhamar on 06/01/20.
//  Copyright © 2020 Nusantara Card Semesta. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import TimelineView

class PageTracking: UIViewController {

    
    @IBOutlet weak var heightTimeline: NSLayoutConstraint!
    @IBOutlet weak var timeline: TimelineView!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var lblShipper: UILabel!
    @IBOutlet weak var lblConsignee: UILabel!
    @IBOutlet weak var lblOrigin: UILabel!
    @IBOutlet weak var lblDest: UILabel!
    @IBOutlet weak var lblWeight: UILabel!
    @IBOutlet weak var lblPcs: UILabel!
    @IBOutlet weak var viewAtas: UIView!
    @IBOutlet weak var viewScroll: UIView!
    
    var server = Server()
    var darkGreen = UIColor.init(red: 2/255, green: 138/255, blue: 75/255, alpha: 1)
    var lightBlack = UIColor(red:37/255, green:48/255, blue:64/255, alpha:1)
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        viewAtas.layer.shadowPath = UIBezierPath(rect: viewAtas.bounds).cgPath
        viewAtas.layer.shadowRadius = 5
        viewAtas.layer.shadowOffset = .zero
        viewAtas.layer.shadowOpacity = 0.3
        
        viewScroll.layer.shadowPath = UIBezierPath(rect: viewScroll.bounds).cgPath
        viewScroll.layer.shadowRadius = 5
        viewScroll.layer.shadowOffset = .zero
        viewScroll.layer.shadowOpacity = 0.3
        
        viewScroll.isHidden = true
        
        self.hideKeyboardWhenTappedAround()

    }
    
    func alertType(title:String,message:String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title:"OK", style: .default)
        alertController.addAction(okAction)
        self.present(alertController,animated: true,completion: nil)
    }
    
    @IBAction func lButtonSearch(_ sender: Any) {
        if (txtSearch.text == ""){
            self.alertType(title:"Invalid Entry",message:"Please enter a valid AWB")
        }else{
            
            let AWB = txtSearch.text
//            track.removeAll()
            loadData(awb:AWB!)
            loadDataAwb(awb:AWB!)
            viewScroll.isHidden = false
            
        }
    }
    
    private func loadData(awb : String){

        let parameters: Parameters = ["AWB": awb]
        var URL:String!

        if awb.count == 13 {
            URL = self.server.URL_NCSDEAL + self.server.CheckPointList
        }else if awb.count == 11 {
            URL = self.server.URL_NCSDEAL + self.server.CheckPointListTTM
        }else{
            self.alertType(title:"Invalid Entry",message:"Please enter a valid AWB")
            URL = ""
        }

        AF.request(URL, method: .get, parameters: parameters)
            .responseJSON {(response) in

//        let json = JSON(response.result.value!)
                switch response.result{
                case .success(let value):
                    
                    var recipient:String?
                    var reason:String?
                    var remarks:String?
                    var courier:String?
                    var branch:String?
                    var time:String?
                    var date:String?
                    var position:String?
                    var lRemarks:String?

                    let json = JSON(value)
                    self.timeline.timelineData.removeAll()

                    if json == JSON.null {
                        print ("Data Kosong")
                    }else{
                        for i in 0 ..< json.count{

                            position = json[i]["Checkpointt"].string
                            date = json[i]["Date"].string
                            time = json[i]["Time"].string
                            branch = json[i]["Branch"].string
                            courier = json[i]["Courier"].string
                            recipient = json[i]["Recipient"].string
                            reason = json[i]["Reason"].string
                           remarks = json[i]["Remarks"].string
                            
                            if awb.count == 13 {
                                if recipient == nil && reason == nil && courier != ""{
                                    lRemarks = "Courier : " + (courier ?? "")
                                }else if recipient != nil {
                                    lRemarks = recipient
                                }else if reason != nil {
                                    lRemarks = reason
                                }else{
                                    lRemarks = ""
                                }
                            }else if awb.count == 11 {
                                if recipient != ""{
                                    lRemarks = "Recipient : " + (recipient ?? "")
                                }else{
                                   lRemarks = remarks
                                }
                                
                            }else{
                                
                            }
                            
                            if json["result"].count == i {
                                self.timeline.timelineData.append(Timeline(title: position ?? "", timeString: (date ?? "") + " " + (time ?? ""),remarks: lRemarks ?? "", desc: branch ?? "", actionPerformed: ["Order Delivered","Order Loaded"], titleColor: self.darkGreen, actionItemColor: self.darkGreen))
                            }else {
                                self.timeline.timelineData.append(Timeline(title: position ?? "", timeString: (date ?? "") + " " + (time ?? ""),remarks: lRemarks ?? "", desc: branch ?? "", actionPerformed: ["Order Delivered","Order Loaded"], titleColor: self.lightBlack, actionItemColor: self.lightBlack))
                            }

                        }
                        
                    }

                    break
                case .failure:
                    
                    print("Connection Error")
                    self.removeSpinner()
                    break
                }
        }

    }
    
    private func loadDataAwb(awb:String){
        
        let parameters: Parameters = ["AWB": awb]
        var URL:String!
        
        self.showSpinner(onView: self.view)
        if awb.count == 13 {
            URL = self.server.URL_NCSDEAL + self.server.GetTracking
            
            AF.request(URL, method: .get, parameters: parameters)
                        .responseJSON {(response) in
            //                let json = JSON(response.result.value!)
                            
                            switch response.result{
                                
                            case .success(let value):
                                
                                let json = JSON(value)
                                
                                if json["result"][0]["ShipperName"].string != nil {
                                    let shippername = json["result"][0]["ShipperName"].string!
                                    let cnee = json["result"][0]["CneeName"].string!
                                    let origin = json["result"][0]["KabNameShipper"].string!
                                    let dest = json["result"][0]["KabNameCnee"].string!
                                    let weight = json["result"][0]["FinalWeight"].string!
                                    let pcs = json["result"][0]["Pieces"].string!
                                    
                                    self.lblShipper.text = shippername
                                    self.lblConsignee.text = cnee
                                    self.lblOrigin.text = origin
                                    self.lblDest.text = dest
                                    self.lblWeight.text = weight
                                    self.lblPcs.text = pcs
                                }else{
                                    self.alertType(title:"Alert",message:"No AWB Not Found")
                                    self.lblShipper.text = ""
                                    self.lblConsignee.text = ""
                                    self.lblOrigin.text = ""
                                    self.lblDest.text = ""
                                    self.lblWeight.text = ""
                                    self.lblPcs.text = ""
                                }
                                self.removeSpinner()
                                break
                            case .failure:
                                self.alertType(title:"",message:"Connection Error")
                                self.removeSpinner()
                                break
                            }
                            
            }
                            
        }else if awb.count == 11 {
            URL = self.server.URL_NCSDEAL + self.server.GetTrackingTTM
            AF.request(URL, method: .get, parameters: parameters)
                        .responseJSON {(response) in
            //                let json = JSON(response.result.value!)
                            
                switch response.result{
                                
                    case .success(let value):
                                
                        let json = JSON(value)
                                
                        if json["result"][0]["Shipper"].string != nil {
                            let shippername = json["result"][0]["Shipper"].string!
                            let cnee = json["result"][0]["Consignee"].string!
                            let origin = json["result"][0]["Origin"].string!
                            let dest = json["result"][0]["Destination"].string!
                            let weight = json["result"][0]["Weight"].string!
                            let pcs = json["result"][0]["Pcs"].string!
                                    
                            self.lblShipper.text = ": " + shippername
                            self.lblConsignee.text = ": " + cnee
                            self.lblOrigin.text = ": " + origin
                            self.lblDest.text = ": " + dest
                            self.lblWeight.text = ": " + weight
                            self.lblPcs.text = ": " + pcs
                        }else{
                            self.alertType(title:"Alert",message:"No AWB Not Found")
                            self.lblShipper.text = ""
                            self.lblConsignee.text = ""
                            self.lblOrigin.text = ""
                            self.lblDest.text = ""
                            self.lblWeight.text = ""
                            self.lblPcs.text = ""
                        }
                        self.removeSpinner()
                        break
                    case .failure:
                        self.alertType(title:"",message:"Connection Error")
                        self.removeSpinner()
                        break
                }
                            
            }
                            
        }else{
            self.alertType(title:"Invalid Entry",message:"Please enter a valid AWB")
            URL = ""
        }
        
    }
}

var vSpinner : UIView?

extension PageTracking {
    
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(PageTracking.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

