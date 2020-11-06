//
//  ConfirmationController.swift
//  NcsDealApps
//
//  Created by Nusantara Card Semesta on 14/07/20.
//  Copyright © 2020 Nusantara Card Semesta. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ConfirmationController: UIViewController {
    
    var server = Server()
    
    @IBOutlet weak var lKategori: UILabel!
    @IBOutlet weak var lShipperName: UILabel!
    @IBOutlet weak var lKecShipper: UILabel!
    @IBOutlet weak var lConsigneeName: UILabel!
    @IBOutlet weak var lKecConsignee: UILabel!
    @IBOutlet weak var lServiceName: UILabel!
    @IBOutlet weak var lWeight: UILabel!
    @IBOutlet weak var fee: UILabel!
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var subTotal: UILabel!
    @IBOutlet weak var TotalAkhir: UILabel!
    @IBOutlet weak var Note: UITextField!
    
    let  PIC = UserDefaults.standard.string(forKey: "Username") ?? ""
    let  PICPhone = UserDefaults.standard.string(forKey: "Phone") ?? ""
    let  Email = UserDefaults.standard.string(forKey: "Email") ?? ""
    
    
    let Kategori = UserDefaults.standard.string(forKey: "kategoriShipment") ?? ""
    let ShipperName = UserDefaults.standard.string(forKey: "ShipperName") ?? ""
    let KecamatanShipper = UserDefaults.standard.string(forKey: "ShipperKecamatan") ?? ""
    let phoneShipper = UserDefaults.standard.string(forKey: "ShipperPhone") ?? ""
    let addressShipper = UserDefaults.standard.string(forKey: "ShipperStreet") ?? ""
    let kecShipper = UserDefaults.standard.string(forKey: "KecShipper") ?? ""
    let kabShipper = UserDefaults.standard.string(forKey: "KabShipper") ?? ""
    let provShipper = UserDefaults.standard.string(forKey: "ProvShipper") ?? ""
    
    let ConsigneeName = UserDefaults.standard.string(forKey: "ConsigneeName") ?? ""
    let KecamatanConsignee = UserDefaults.standard.string(forKey: "ConsigneeKecamatan") ?? ""
    let PhoneConsignee = UserDefaults.standard.string(forKey: "ConsigneePhone") ?? ""
    let addressConsignee = UserDefaults.standard.string(forKey: "ConsigneeStreet") ?? ""
    let KecConsignee = UserDefaults.standard.string(forKey: "KecConsignee") ?? ""
    let KabConsignee = UserDefaults.standard.string(forKey: "KabConsignee") ?? ""
    let ProvConsignee = UserDefaults.standard.string(forKey: "ProvConsignee") ?? ""
    
    let ServiceName = UserDefaults.standard.string(forKey: "serviceShipment") ?? ""
    let ServiceId = UserDefaults.standard.string(forKey: "serviceID") ?? ""
    let ServiceCode = UserDefaults.standard.string(forKey: "serviceCode") ?? ""
    let Weight = UserDefaults.standard.string(forKey: "weightShipment") ?? ""
    let Fee = UserDefaults.standard.string(forKey: "feeShipment") ?? ""
    let transportID = UserDefaults.standard.string(forKey: "transportID") ?? ""
    let Total = UserDefaults.standard.string(forKey: "totalShipment") ?? ""
    let SubTotal = UserDefaults.standard.string(forKey: "totalShipment") ?? ""
    let totalAkhir = UserDefaults.standard.string(forKey: "totalShipment") ?? ""
    let date = UserDefaults.standard.string(forKey: "DateShipment") ?? ""
    let fromjam = UserDefaults.standard.string(forKey: "fromJam") ?? ""
    let tojam = UserDefaults.standard.string(forKey: "toJam") ?? ""
    let pcs = UserDefaults.standard.string(forKey: "piecesShipment") ?? ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()

        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getData()
    }
    
    @IBAction func btnConfirm(_ sender: Any) {
        postData()
    }
    
    func getData() {
        
        lKategori.text = Kategori
        lShipperName.text = ShipperName
        lKecShipper.text = KecamatanShipper
        lConsigneeName.text = ConsigneeName
        lKecConsignee.text = KecamatanConsignee
        lServiceName.text = "\(ServiceCode) - \(ServiceName)"
        lWeight.text = Weight
        fee.text = Fee
        total.text = Total
        subTotal.text = SubTotal
        TotalAkhir.text = totalAkhir
    }
    
    func removeSession() {
        UserDefaults.standard.removeObject(forKey: "kategoriShipment")
        UserDefaults.standard.removeObject(forKey: "ShipperName")
        UserDefaults.standard.removeObject(forKey: "ShipperKecamatan")
        UserDefaults.standard.removeObject(forKey: "ShipperPhone")
        UserDefaults.standard.removeObject(forKey: "ShipperStreet")
        UserDefaults.standard.removeObject(forKey: "KecShipper")
        UserDefaults.standard.removeObject(forKey: "KabShipper")
        UserDefaults.standard.removeObject(forKey: "ProvShipper")
        
        UserDefaults.standard.removeObject(forKey: "ConsigneeName")
        UserDefaults.standard.removeObject(forKey: "ConsigneeKecamatan")
        UserDefaults.standard.removeObject(forKey: "ConsigneePhone")
        UserDefaults.standard.removeObject(forKey: "ConsigneeStreet")
        UserDefaults.standard.removeObject(forKey: "KecConsignee")
        UserDefaults.standard.removeObject(forKey: "KabConsignee")
        UserDefaults.standard.removeObject(forKey: "ProvConsignee")
        
        UserDefaults.standard.removeObject(forKey: "serviceShipment")
        UserDefaults.standard.removeObject(forKey: "serviceID")
        UserDefaults.standard.removeObject(forKey: "serviceCode")
        UserDefaults.standard.removeObject(forKey: "weightShipment")
        UserDefaults.standard.removeObject(forKey: "feeShipment")
        UserDefaults.standard.removeObject(forKey: "transportID")
        UserDefaults.standard.removeObject(forKey: "totalShipment")
        UserDefaults.standard.removeObject(forKey: "DateShipment")
        UserDefaults.standard.removeObject(forKey: "fromJam")
        UserDefaults.standard.removeObject(forKey: "toJam")
        UserDefaults.standard.removeObject(forKey: "piecesShipment")
        
    }
    
    private func postData(){
        showSpinner(onView: self.view)
        let parameters: Parameters = ["sAcctNo": "4231731000101656" ,
                                      "sPIC": PIC ,
                                      "sShipperName": ShipperName ,
                                      "sPICPhone": PICPhone ,
                                      "sShipperPhone": phoneShipper ,
                                      "sShipperAddress": addressShipper ,
                                      "sShipperKecamatan": kecShipper ,
                                      "sShipperKabupaten": kabShipper ,
                                      "sShipperProvinsi": provShipper ,
                                      "sShipperEmail": Email ,
                                      "sConsigneeName": ConsigneeName ,
                                      "sConsigneePhone": PhoneConsignee ,
                                      "sConsigneeAddress": addressConsignee ,
                                      "sConsigneeKecamatan": KecConsignee ,
                                      "sConsigneeKabupaten": KabConsignee ,
                                      "sConsigneeProvinsi": ProvConsignee ,
                                      "sInstruction": Note.text ?? "",
                                      "sLat": "" ,
                                      "sLng": "" ,
                                      "sServiceID": ServiceId ,
                                      "sServiceCode": ServiceCode ,
                                      "sTransportID": transportID ,
                                      "sEstPickupTimeFrom": fromjam ,
                                      "sEstPickupTimeTo": tojam ,
                                      "sEstPickupDateSend": date ,
                                      "sShipmentContent": Kategori ,
                                      "sActualWeight": Weight ,
                                      "sPieces": pcs ]
        
//        print(parameters)
        
            AF.request(self.server.URL_NCSDEAL + self.server.RequestPickup, method: .post, parameters: parameters)
                .responseJSON {(response) in
    //                let json = JSON(response.result.value!)

                    switch response.result{

                    case .success(let value):

                        let json = JSON(value)
                        let kode = json["success"].int

                        if kode == 1 {

                            print(json["message"].string)
                            self.removeSession()
                            let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! UITabBarController
                            self.present(viewController, animated: true, completion: nil)

                        }else{

                            print(json["message"].string)

                        }

                        self.removeSpinner()
                        break
                    case .failure(let error):
                        self.alertType(title:"",message:"\(error.localizedDescription)")
                        self.removeSpinner()
                        break
                    }

            }
        }
    
    

}

extension ConfirmationController {
    
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
    
    func alertType(title:String,message:String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title:"OK", style: .default)
        alertController.addAction(okAction)
        self.present(alertController,animated: true,completion: nil)
    }
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ConfirmationController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
