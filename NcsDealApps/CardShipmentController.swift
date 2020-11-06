//
//  CardShipmentController.swift
//  NcsDealApps
//
//  Created by Nusantara Card Semesta on 03/07/20.
//  Copyright © 2020 Nusantara Card Semesta. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CardShipmentController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var txtDatePicker: UITextField!
    @IBOutlet weak var handleArea: UIView!
    @IBOutlet weak var jamDropdown: UITextField!
    @IBOutlet weak var serviceDropDown: UITextField!
    @IBOutlet weak var kendaraanDropDown: UITextField!
    @IBOutlet weak var kategoriDropDown: UITextField!
    @IBOutlet weak var txtPieces: UITextField!
    @IBOutlet weak var txtWeight: UITextField!
    @IBOutlet weak var txtlength: UITextField!
    @IBOutlet weak var txtwidth: UITextField!
    @IBOutlet weak var txtheight: UITextField!
    @IBOutlet weak var lWeight: UILabel!
    @IBOutlet weak var lShipmentFee: UILabel!
    @IBOutlet weak var lTotal: UILabel!
    @IBOutlet weak var swicthDimension: UISwitch!
    @IBOutlet weak var viewDimension: UIView!
    @IBOutlet weak var heightDimensi: NSLayoutConstraint!
    
    var server = Server()
    
    
    let jam = ["08:00 - 10:00", "10:00 - 12:00", "12:00 - 14:00", "14:00 - 16:00", "16:00 - 18:00", "18:00 - 20:00", "20:00 - 22:00"]
    let service = ["REGULAR SERVICE","OVERNIGHT SERVICE","SAME DAY SERVICE"]
    let kendaraan = ["MotorCycle","Truck","Truck Double", "Van"]
    let kategori = ["Fashion & Apparel","Books & Documents","Sport & Entertainment", "Jewelry & Accesories", "Automobile & Motorcycle", "Makanan Beku", "Non-perishable Food & Snack", "Health & Beauty", "Electronics & Gadgets", "Toys & Hobbies", "Household & Homewares"]
    
    
      let datePicker = UIDatePicker()
    
    var categorySwitchIsOn:Bool =  false
    var serviceCode:String!
    var serviceID:String!
    var TransportID:String!

      override func viewDidLoad() {
//        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        
         showDatePicker()
        txtPieces.text = "1"
        txtWeight.text = "1"
        txtlength.text = "1"
        txtwidth.text = "1"
        txtheight.text = "1"
        lWeight.text = txtWeight.text
        swicthDimension.addTarget(self, action: #selector(categorySwitchValueChanged), for: .valueChanged)
        swicthDimension.isOn = false
        heightDimensi.constant = 0
        viewDimension.isHidden = true
        
        
        let pickerView = UIPickerView()
        let pickViewService = UIPickerView()
        let pickViewKendaraan = UIPickerView()
        let pickViewKategori = UIPickerView()
        pickerView.delegate = self
        pickViewService.delegate = self
        pickViewKendaraan.delegate = self
        pickViewKategori.delegate = self
        pickerView.tag = 0
        pickViewService.tag = 1
        pickViewKendaraan.tag = 2
        pickViewKategori.tag = 3
        
        jamDropdown.inputView = pickerView
        serviceDropDown.inputView = pickViewService
        kendaraanDropDown.inputView = pickViewKendaraan
        kategoriDropDown.inputView = pickViewKategori
        
      }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
    }

    @IBAction func LengthEvent(_ sender: Any) {
        getChargeWeight()
    }
    @IBAction func widthEvent(_ sender: Any) {
        getChargeWeight()
    }
    @IBAction func heightEvent(_ sender: Any) {
        getChargeWeight()
    }
    @IBAction func ChangeEventService(_ sender: Any) {
        getChargeWeight()
    }
    
    @IBAction func ChangeEvent(_ sender: UITextField) {
        getChargeWeight()
    }
    
    @IBAction func eventKendaraan(_ sender: Any) {
        if kendaraanDropDown.text == "MotorCycle" {
            TransportID = "101";
            UserDefaults.standard.set(TransportID, forKey: "transportID")
        } else if kendaraanDropDown.text == "Van" {
            TransportID = "102";
            UserDefaults.standard.set(TransportID, forKey: "transportID")
        } else if kendaraanDropDown.text == "Truck" {
            TransportID = "103";
            UserDefaults.standard.set(TransportID, forKey: "transportID")
        } else if kendaraanDropDown.text == "Truck Double" {
            TransportID = "104";
            UserDefaults.standard.set(TransportID, forKey: "transportID")
        }
    }
    
    @IBAction func eventJam(_ sender: Any) {
        
        let calendar = Calendar(identifier: .gregorian)
        let currentDate = Date()
        var components = DateComponents()
        let hour = calendar.component(.hour, from: currentDate)
        let minute = calendar.component(.minute, from: currentDate)
        let formattr = DateFormatter()
        let time = calendar.date(bySettingHour: hour, minute: minute, second:0, of: currentDate)
//        let hour = formattr.timeStyle = .short
        formattr.dateStyle = .none
        
        print(time)
        if txtDatePicker.isEqual(datePicker){
            print("tanggalnya sama")

//            let jam1 = jamDropdown.text
//            let fulljam1 = jam1!.components(separatedBy: " - ")
//
//            let from:String?    = fulljam1[0]
//            let to:String? = fulljam1[1]
        }
    }
    
    @IBAction func btnApply(_ sender: Any) {
        UserDefaults.standard.set(txtDatePicker.text, forKey: "DateShipment")
        UserDefaults.standard.set(jamDropdown.text, forKey: "jamShipment")
        UserDefaults.standard.set(serviceDropDown.text, forKey: "serviceShipment")
        UserDefaults.standard.set(serviceID, forKey: "serviceID")
        UserDefaults.standard.set(serviceCode, forKey: "serviceCode")
        UserDefaults.standard.set(txtPieces.text, forKey: "piecesShipment")
        UserDefaults.standard.set(lWeight.text, forKey: "weightShipment")
        UserDefaults.standard.set(txtlength.text, forKey: "lengthShipment")
        UserDefaults.standard.set(txtwidth.text, forKey: "widthShipment")
        UserDefaults.standard.set(txtheight.text, forKey: "heightShipment")
        UserDefaults.standard.set(kendaraanDropDown.text, forKey: "kendaraanShipment")
        UserDefaults.standard.set(kategoriDropDown.text, forKey: "kategoriShipment")
        UserDefaults.standard.set(lShipmentFee.text, forKey: "feeShipment")
        UserDefaults.standard.set(lTotal.text, forKey: "totalShipment")
        UserDefaults.standard.set(datePicker.date, forKey: "dateShipment")
        
        let jam    = jamDropdown.text
        let fulljam = jam!.components(separatedBy: " - ")

        let from:String?    = fulljam[0]
        let to:String? = fulljam[1]
        
        UserDefaults.standard.set(from, forKey: "fromJam")
        UserDefaults.standard.set(to, forKey: "toJam")
        
        
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func categorySwitchValueChanged(_ sender: UISwitch) {
        
        if sender.isOn {
            categorySwitchIsOn =  true
            heightDimensi.constant = 35
            viewDimension.isHidden = false

        } else {
            categorySwitchIsOn =  false
            heightDimensi.constant = 0
            viewDimension.isHidden = true
        }
    }
    
    private func getChargeWeight() {
        showSpinner(onView: self.view)
        let dVolume:Double
        let dActualWeight:Double

        var sPanjang = self.txtlength?.text;
        var sLebar = self.txtwidth?.text;
        var sTinggi = self.txtheight?.text;
        let sActualWeight = self.txtWeight.text;

        if sActualWeight == "" || sActualWeight == nil {
            print ("berat kosong") ;
        } else {

            dActualWeight = Double(sActualWeight!)!;

            if (sPanjang == "" || sLebar == "" || sTinggi == "") {
                sPanjang = "1";
                sLebar = "1";
                sTinggi = "1";
            }

            let dPanjang:Double = Double(sPanjang!)!;
            let dLebar:Double = Double(sLebar!)!;
            let dTinggi:Double = Double(sTinggi!)!;

            dVolume = (dPanjang * dLebar * dTinggi) / 6000;

            if (dVolume > dActualWeight) {
                getBasicPrice(sWeight: dVolume)
            } else if (dActualWeight > dVolume) {
                getBasicPrice(sWeight: dActualWeight)
            } else if (dVolume == dActualWeight) {
                getBasicPrice(sWeight: dActualWeight)
            }
        }
        removeSpinner()
    }
    
    func getBasicPrice(sWeight : Double){
        
        let kecIDShipper    = UserDefaults.standard.string(forKey: "kecIDShipper") ?? ""
        let kecIDConsignee  = UserDefaults.standard.string(forKey: "kecIDConsignee") ?? ""
        if serviceDropDown.text == "REGULAR SERVICE"{
            serviceCode = "NRS"
            serviceID = "101"
        }else if serviceDropDown.text == "OVERNIGHT SERVICE"{
            serviceCode = "ONS"
            serviceID = "102"
        }else if serviceDropDown.text == "SAME DAY SERVICE"{
            serviceCode = "SDS"
            serviceID = "103"
        }
        
        let lweight = self.txtWeight!.text
        
        let param: Parameters = ["OriKabID": kecIDShipper ,"DesKabID": kecIDConsignee ,"ServiceCode": serviceCode ?? ""]
        AF.request(self.server.URL_NCSDEAL + self.server.GetBasicPrice, method: .get,parameters: param).responseJSON{(response) in
                
            switch response.result{
                
            case .success(let value):
                
                let json = JSON(value)
                let PriAmount = json["result"][0]["PriAmount"].string ?? ""
                if PriAmount == "" {
                    self.lShipmentFee.text = "Belum Teersedia"
                    self.lTotal.text = "Belum Teersedia"
                }else{
                    self.lShipmentFee.text = PriAmount
                    self.lWeight.text = String(format: "%.01f", sWeight)
                    let Total = Double(PriAmount)! * sWeight
                    self.lTotal.text = String(format: "%ld %@", locale: Locale.current, Int(Total), " ")
                    print(String(format: "%ld %@", locale: Locale.current, Int(Total),""))
                }
                break
            case .failure(let value):
                print(value)
                break
            }
        }
    }
    
      func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        let calendar = Calendar(identifier: .gregorian)

        let currentDate = Date()
        var components = DateComponents()
        let hour = calendar.component(.hour, from: currentDate)

       //ToolBar
       let toolbar = UIToolbar();
       toolbar.sizeToFit()
       let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
      let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));

     toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)

      txtDatePicker.inputAccessoryView = toolbar
      txtDatePicker.inputView = datePicker
        let minDate = calendar.date(byAdding: components, to: currentDate)!

        datePicker.minimumDate = minDate

     }
    
      @objc func donedatePicker(){

       let formatter = DateFormatter()
       formatter.dateFormat = "yyyy-MM-dd"
       txtDatePicker.text = formatter.string(from: datePicker.date)
       self.view.endEditing(true)
     }

     @objc func cancelDatePicker(){
        self.view.endEditing(true)
      }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0{
            return jam.count
        }else if pickerView.tag == 1{
            return service.count
        }else if pickerView.tag == 2{
            return kendaraan.count
        }else if pickerView.tag == 3{
            return kategori.count
        }
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView.tag == 0{
            return jam[row]
        }else if pickerView.tag == 1{
            return service[row]
        }else if pickerView.tag == 2{
            return kendaraan[row]
        }else if pickerView.tag == 3{
            return kategori[row]
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView.tag == 0{
            jamDropdown.text = jam[row]
            jamDropdown.resignFirstResponder()
        }else if pickerView.tag == 1{
            serviceDropDown.text = service[row]
            serviceDropDown.resignFirstResponder()
        }else if pickerView.tag == 2{
            kendaraanDropDown.text = kendaraan[row]
            kendaraanDropDown.resignFirstResponder()
        }else if pickerView.tag == 3{
            kategoriDropDown.text = kategori[row]
            kategoriDropDown.resignFirstResponder()
        }
        
    }
}

extension CardShipmentController {
    
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
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CekPriceController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}





