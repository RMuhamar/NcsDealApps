//
//  PickupMainController.swift
//  NcsDealApps
//
//  Created by Nusantara Card Semesta on 15/06/20.
//  Copyright © 2020 Nusantara Card Semesta. All rights reserved.
//

import UIKit

class PickupMainController: UIViewController {
    
    @IBOutlet weak var emptyShipper: UILabel!
    @IBOutlet weak var imageShipper: UIImageView!
    @IBOutlet weak var emptyConsignee: UILabel!
    @IBOutlet weak var imageConsignee: UIImageView!
    
    @IBOutlet weak var txtShipperName: UILabel!
    @IBOutlet weak var txtShipperPhone: UILabel!
    @IBOutlet weak var txtShipperKecamatan: UILabel!
    @IBOutlet weak var txtShipperAddress: UILabel!
    
    
    @IBOutlet weak var txtConsigneeName: UILabel!
    @IBOutlet weak var txtConsigneePhone: UILabel!
    @IBOutlet weak var txtConsigneeKecamatan: UILabel!
    
    @IBOutlet weak var lDate: UILabel!
    @IBOutlet weak var lJam: UILabel!
    @IBOutlet weak var lkategori: UILabel!
    @IBOutlet weak var lserviceID: UILabel!
    @IBOutlet weak var lservice: UILabel!
    @IBOutlet weak var lpcs: UILabel!
    @IBOutlet weak var lfinalWeight: UILabel!
    @IBOutlet weak var ltransportasi: UILabel!
    @IBOutlet weak var emptyShipment: UILabel!
    @IBOutlet weak var imgShipment: UIImageView!
    
    @IBOutlet weak var txtConsigneeAddress: UILabel!
    @IBOutlet weak var viewShipper: UIView!
    @IBOutlet weak var viewConsignee: UIView!
    @IBOutlet weak var viewShipmentDetail: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viewShipper = UITapGestureRecognizer(target: self, action:  #selector(self.intentShipper))
        self.viewShipper.addGestureRecognizer(viewShipper)
        self.viewShipper.layer.cornerRadius = 10
        self.viewShipper.layer.shadowPath = UIBezierPath(rect: self.viewShipper.bounds).cgPath
        self.viewShipper.layer.shadowRadius = 5
        self.viewShipper.layer.shadowOffset = .zero
        self.viewShipper.layer.shadowOpacity = 0.2
        
        let viewConsignee = UITapGestureRecognizer(target: self, action:  #selector(self.intentConsignee))
        self.viewConsignee.addGestureRecognizer(viewConsignee)
        self.viewConsignee.layer.cornerRadius = 10
        self.viewConsignee.layer.shadowPath = UIBezierPath(rect: self.viewConsignee.bounds).cgPath
        self.viewConsignee.layer.shadowRadius = 5
        self.viewConsignee.layer.shadowOffset = .zero
        self.viewConsignee.layer.shadowOpacity = 0.2
        
        let viewShippment = UITapGestureRecognizer(target: self, action:  #selector(self.intentShipment))
        self.viewShipmentDetail.addGestureRecognizer(viewShippment)
        self.viewShipmentDetail.layer.cornerRadius = 10
        self.viewShipmentDetail.layer.shadowPath = UIBezierPath(rect: self.viewShipmentDetail.bounds).cgPath
        self.viewShipmentDetail.layer.shadowRadius = 5
        self.viewShipmentDetail.layer.shadowOffset = .zero
        self.viewShipmentDetail.layer.shadowOpacity = 0.2

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getData()
        print(UserDefaults.standard.string(forKey: "kecIDShipper") ?? "")
        print(UserDefaults.standard.string(forKey: "kecIDConsignee") ?? "")
    }
    
    
    @IBAction func btnRequestPickup(_ sender: Any) {
        if txtShipperName.text == "" || txtConsigneeName.text == "" || lkategori.text == ""{
            self.alertType(title:"",message:"Lengkapi Data Terlebih Dahulu")
        }
    }
    
    @objc func intentShipper(sender : UITapGestureRecognizer) {
        let ShipperVc = self.storyboard?.instantiateViewController(withIdentifier: "ShipperController") as! ShipperController
        UserDefaults.standard.removeObject(forKey: "ShipperName")
        UserDefaults.standard.removeObject(forKey: "ShipperPhone")
        UserDefaults.standard.removeObject(forKey: "ShipperKecamatan")
        UserDefaults.standard.removeObject(forKey: "ShipperStreet")
        UserDefaults.standard.removeObject(forKey: "kecIDShipper")
            self.navigationController?.pushViewController(ShipperVc, animated: true)
    }
    
    @objc func intentConsignee(sender : UITapGestureRecognizer) {
        if txtShipperName.text == "" {
            self.alertType(title:"",message:"Data Shipper Blm di Isi")
        }else{
        let ConsigneeVc = self.storyboard?.instantiateViewController(withIdentifier: "ConsigneeController") as! ConsigneeController
        UserDefaults.standard.removeObject(forKey: "ConsigneeName")
        UserDefaults.standard.removeObject(forKey: "ConsigneePhone")
        UserDefaults.standard.removeObject(forKey: "ConsigneeKecamatan")
        UserDefaults.standard.removeObject(forKey: "ConsigneeStreet")
        UserDefaults.standard.removeObject(forKey: "kecIDConsignee")
        
        self.navigationController?.pushViewController(ConsigneeVc, animated: true)
        }
    }
    
    @objc func intentShipment(sender : UITapGestureRecognizer) {
        if txtShipperName.text == "" || txtConsigneeName.text == "" {
            self.alertType(title:"",message:"Data Shipper atau Consignee Blm di Isi")
        }else{
        let ShipmentVc = self.storyboard?.instantiateViewController(withIdentifier: "ShipmentController") as! ShipmentController
        self.navigationController?.pushViewController(ShipmentVc, animated: true)
        }
    }
    
    func getData(){
        let ShipperName  = UserDefaults.standard.string(forKey: "ShipperName") ?? ""
           let ShipperPhone  = UserDefaults.standard.string(forKey: "ShipperPhone") ?? ""
           let ShipperKecamatan  = UserDefaults.standard.string(forKey: "ShipperKecamatan") ?? ""
           let ShipperStreet  = UserDefaults.standard.string(forKey: "ShipperStreet") ?? ""
           let ConsigneeName = UserDefaults.standard.string(forKey: "ConsigneeName") ?? ""
           let ConsigneePhone  = UserDefaults.standard.string(forKey: "ConsigneePhone") ?? ""
           let ConsigneeKecamatan  = UserDefaults.standard.string(forKey: "ConsigneeKecamatan") ?? ""
           let ConsigneeStreet  = UserDefaults.standard.string(forKey: "ConsigneeStreet") ?? ""
           let DateShipment  = UserDefaults.standard.string(forKey: "DateShipment") ?? ""
           let jamShipment  = UserDefaults.standard.string(forKey: "jamShipment") ?? ""
           let serviceShipment  = UserDefaults.standard.string(forKey: "serviceShipment") ?? ""
           let serviceID  = UserDefaults.standard.string(forKey: "serviceID") ?? ""
           let piecesShipment  = UserDefaults.standard.string(forKey: "piecesShipment") ?? ""
           let weightShipment  = UserDefaults.standard.string(forKey: "weightShipment") ?? ""
           let kendaraanShipment  = UserDefaults.standard.string(forKey: "kendaraanShipment") ?? ""
           let kategoriShipment  = UserDefaults.standard.string(forKey: "kategoriShipment") ?? ""
        
        print(ShipperName)
         
        if ShipperName != "" {
            emptyShipper.isHidden = true
            imageShipper.isHidden = true
            txtShipperName.text = ShipperName
            txtShipperPhone.text = ShipperPhone
            txtShipperKecamatan.text = ShipperKecamatan
            txtShipperAddress.text = ShipperStreet
        }else{
            emptyShipper.isHidden = false
            imageShipper.isHidden = false
            txtShipperName.text = ShipperName
            txtShipperPhone.text = ShipperPhone
            txtShipperKecamatan.text = ShipperKecamatan
            txtShipperAddress.text = ShipperStreet
        }
        
        if ConsigneeName != "" {
            emptyConsignee.isHidden = true
            imageConsignee.isHidden = true
            txtConsigneeName.text = ConsigneeName
            txtConsigneePhone.text = ConsigneePhone
            txtConsigneeKecamatan.text = ConsigneeKecamatan
            txtConsigneeAddress.text = ConsigneeStreet
        }else{
            emptyConsignee.isHidden = false
            imageConsignee.isHidden = false
            txtConsigneeName.text = ConsigneeName
            txtConsigneePhone.text = ConsigneePhone
            txtConsigneeKecamatan.text = ConsigneeKecamatan
            txtConsigneeAddress.text = ConsigneeStreet
        }
        
        if serviceShipment != "" {
            emptyShipment.isHidden = true
            imgShipment.isHidden = true
            lDate.text = DateShipment
            lJam.text = jamShipment
            lkategori.text = kategoriShipment
            lserviceID.text = serviceID
            lservice.text = serviceShipment
            lpcs.text = "\(piecesShipment) Pcs,"
            lfinalWeight.text = "Final Weight : \(weightShipment)"
            ltransportasi.text = "Transportasi Pickup : \(kendaraanShipment)"
        }else{
            emptyShipment.isHidden = false
            imgShipment.isHidden = false
            lDate.text = DateShipment
            lJam.text = jamShipment
            lkategori.text = kategoriShipment
            lserviceID.text = serviceID
            lservice.text = serviceShipment
            lpcs.text = ""
            lfinalWeight.text = ""
            ltransportasi.text = ""
        }
        
    }
    

}
extension PickupMainController {
    
    func alertType(title:String,message:String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title:"OK", style: .default)
        alertController.addAction(okAction)
        self.present(alertController,animated: true,completion: nil)
    }
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(PickupMainController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
