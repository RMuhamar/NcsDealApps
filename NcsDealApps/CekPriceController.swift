//
//  CekPriceController.swift
//  NcsDealApps
//
//  Created by RMuhamar on 20/02/20.
//  Copyright © 2020 Nusantara Card Semesta. All rights reserved.
//

import UIKit
import iOSDropDown
import Alamofire
import SwiftyJSON

class CekPriceController: UIViewController ,UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var provinsiOrigin: DropDown!
    @IBOutlet weak var kabOrigin: DropDown!
    @IBOutlet weak var provinsiCons: DropDown!
    @IBOutlet weak var kabCons: DropDown!
    @IBOutlet weak var OriginView: UIImageView!
    @IBOutlet weak var Consigneeview: UIView!
    @IBOutlet weak var shipmentView: UIView!
    @IBOutlet weak var TableCekPrice: UITableView!
    @IBOutlet weak var txtBerat: UITextField!
    @IBOutlet weak var txtPanjang: UITextField?
    @IBOutlet weak var txtLebar: UITextField?
    @IBOutlet weak var txtTinggi: UITextField?
    
    var option =  Options()
    var cekPrice = [Tablelist]()
    var server = Server()
    
    var dataArrayProv:Array<Any> = []
    var idArrayProv:Array<Int> = []
    var dataArrayKab:Array<Any> = []
    var idArrayKab:Array<Int> = []
    var dataArrayProv2:Array<Any> = []
    var idArrayProv2:Array<Int> = []
    var dataArrayKab2:Array<Any> = []
    var idArrayKab2:Array<Int> = []
    var id :String = ""
    var id2:String = ""
    
//        let salutations = ["", "Mr.", "Ms.", "Mrs."]
//        let data = ["","lalla","lili","LELE","LOLO"]
     
        override func viewDidLoad() {
            super.viewDidLoad()
            self.OriginView.layer.cornerRadius = 10
            self.OriginView.layer.masksToBounds = true
            OriginView.layer.shadowPath = UIBezierPath(rect: OriginView.bounds).cgPath
            OriginView.layer.shadowRadius = 5
            OriginView.layer.shadowOffset = .zero
            OriginView.layer.shadowOpacity = 0.2
            
            self.Consigneeview.layer.cornerRadius = 10
            self.Consigneeview.layer.masksToBounds = true
            Consigneeview.layer.shadowPath = UIBezierPath(rect: Consigneeview.bounds).cgPath
            Consigneeview.layer.shadowRadius = 5
            Consigneeview.layer.shadowOffset = .zero
            Consigneeview.layer.shadowOpacity = 0.2
            
            self.shipmentView.layer.cornerRadius = 10
            self.shipmentView.layer.masksToBounds = true
            
            self.TableCekPrice.dataSource = self
            self.TableCekPrice.delegate = self
            
            self.showSpinner(onView: self.view)
            loadDataProvOrigin();
            loadDataProvConsigne();
            self.removeSpinner()
            self.hideKeyboardWhenTappedAround()
     
//            pickerTextField.loadDropdownData(data: salutations)
//            tralala.loadDropdownData(data: data)
        }
    
    @IBAction func clickButton(_ sender: Any) {
        if self.txtBerat.text == "" {
            self.cekPrice.removeAll()
            
        }else{
        self.cekPrice.removeAll()
        self.showSpinner(onView: self.view)
        getChargeWeight()
        }
    }
    
    private func loadDataProvOrigin() -> Void {
        AF.request(self.server.URL_NCSDEAL + self.server.GetProvinsi, method: .get)
            .responseJSON {(response) in
                
        switch response.result{
        case .success(let value):
            let json = JSON(response.result.value!)
            for i in 0 ..< json["result"].count{
            
                let proName = json["result"][i]["ProName"].string
                let proID = json["result"][i]["ProID"].string
                self.dataArrayProv.append(proName!)
                self.idArrayProv.append(Int(proID!) ?? 0)
            }
            self.provinsiOrigin.optionArray = self.dataArrayProv as! [String]
            self.provinsiOrigin.optionIds = self.idArrayProv
            self.provinsiOrigin.checkMarkEnabled = false
            
            self.provinsiOrigin.didSelect{(selectedText , index , id) in
                self.loadDataKabOrigin(data: String(id))
                //             self.valueLabel.text = "Selected String: \(selectedText) \n index: \(index) \n Id: \(id)"
            }
            break
        case .failure(let error):
            self.alertType(title:"",message: "\(error.localizedDescription)")
            break
        }
        
        }
        
    }
    
    private func loadDataKabOrigin(data: String) -> Void {
        let param: Parameters = ["ProID": data ]
        AF.request(self.server.URL_NCSDEAL + self.server.GetKabupaten, method: .get,parameters: param)
            .responseJSON {(response) in
        
        self.dataArrayKab.removeAll()
        self.idArrayKab.removeAll()
                
        let json = JSON(response.result.value!)

        for i in 0 ..< json["result"].count{
            
            let kabName = json["result"][i]["KabName"].string
            let kabID = json["result"][i]["KabID"].string
            self.dataArrayKab.append(kabName!)
            self.idArrayKab.append(Int(kabID!) ?? 0)
            }
                
                self.kabOrigin.optionArray = self.dataArrayKab as! [String]
                self.kabOrigin.optionIds = self.idArrayKab
                self.kabOrigin.checkMarkEnabled = false
                self.kabOrigin.didSelect{(selectedText , index , id) in
                    self.id = String(id)
                //             self.valueLabel.text = "Selected String: \(selectedText) \n index: \(index) \n Id: \(id)"
                    }
        }
        
    }
    
    private func loadDataProvConsigne() -> Void {
        AF.request(self.server.URL_NCSDEAL + self.server.GetProvinsi, method: .get)
            .responseJSON {(response) in
     
        switch response.result{
            
        case .success(let value):
            let json = JSON(response.result.value!)
            for i in 0 ..< json["result"].count{
            
                let proName = json["result"][i]["ProName"].string
                let proID = json["result"][i]["ProID"].string
                self.dataArrayProv2.append(proName!)
                self.idArrayProv2.append(Int(proID!) ?? 0)
            }
            self.provinsiCons.optionArray = self.dataArrayProv2 as! [String]
            self.provinsiCons.optionIds = self.idArrayProv2
            self.provinsiCons.checkMarkEnabled = false
            
            self.provinsiCons.didSelect{(selectedText , index , id) in
                self.loadDataKabCons(data: String(id))
                    
                //self.valueLabel.text = "Selected String: \(selectedText) \n index: \(index) \n Id: \(id)"
            }
            break
        case.failure(let error):
            self.alertType(title:"",message: "\(error.localizedDescription)")
            break
        }
        
        }
        
    }
    
    private func loadDataKabCons(data: String) -> Void {
        let param: Parameters = ["ProID": data ]
        AF.request(self.server.URL_NCSDEAL + self.server.GetKabupaten, method: .get,parameters: param)
            .responseJSON {(response) in
        
        self.dataArrayKab2.removeAll()
        self.idArrayKab2.removeAll()
                
        let json = JSON(response.result.value!)

        for i in 0 ..< json["result"].count{
            
            let kabName = json["result"][i]["KabName"].string
            let kabID = json["result"][i]["KabID"].string
            self.dataArrayKab2.append(kabName!)
            self.idArrayKab2.append(Int(kabID!) ?? 0)
            }
                
                self.kabCons.optionArray = self.dataArrayKab2 as! [String]
                self.kabCons.optionIds = self.idArrayKab2
                self.kabCons.checkMarkEnabled = false
                self.kabCons.didSelect{(selectedText , index , id) in
                    self.id2 = String(id)
                //             self.valueLabel.text = "Selected String: \(selectedText) \n index: \(index) \n Id: \(id)"
                    }
        }
        
    }
    
    private func getChargeWeight() {
        let dVolume:Double
        let dActualWeight:Double

        var sPanjang = self.txtPanjang?.text;
        var sLebar = self.txtLebar?.text;
        var sTinggi = self.txtTinggi?.text;
        let sActualWeight = self.txtBerat.text;

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

            dVolume = (dPanjang * dLebar * dTinggi);

            if (dVolume > dActualWeight) {
                getPrice(sWeight: dVolume.rounded(),status: "volume")
            } else if (dActualWeight > dVolume) {
                getPrice(sWeight: dActualWeight,status: "weight")
            } else if (dVolume == dActualWeight) {
                getPrice(sWeight: dActualWeight,status: "weight")
            }
        }
    }
    
    private func getPrice(sWeight : Double,status : String){
        var totalpriamount:Double?
        var total:Int?
        var totalWeight:Double!
        let parameters: Parameters = ["KabIDOri": id,"KabIDDes": id2 ]
        AF.request(self.server.URL_NCSDEAL + self.server.GetPrice, method: .get, parameters: parameters)
            .responseJSON {(response) in
        
        
        let json = JSON(response.result.value!)
        switch response.result{
            case .success(let _):
                for i in 0 ..< json["result"].count{
                    
                var remarks:String?
                let servicename = json["result"][i]["ServiceName"].string ?? ""
                let priamount = json["result"][i]["PriAmount"].string ?? ""
                let service = json["result"][i]["Service"].string ?? ""
                let leadtimestart = json["result"][i]["LeadTimeStart"].string ?? ""
                let leadtimeend = json["result"][i]["LeadTimeEnd"].string ?? ""
                let minimum = json["result"][i]["Minimum"].string ?? ""
                    remarks = json["result"][i]["Remarks"].string ?? ""
                    
                    if service == "NRS" || service == "ONS" || service == "SDS"{
                        if (priamount != "") {
                            if(status == "volume"){
                                totalWeight = sWeight / 6000
                                totalpriamount = Double(priamount)! * (totalWeight.rounded(.up))
                                total = Int(totalpriamount!)
                            }else{
                                totalpriamount = Double(priamount)! * sWeight
                                total = Int(totalpriamount!)
                            }
                            
                        }
                    }else{
                        if (priamount != "") {
                            if status == "volume"{
                                totalWeight = sWeight / 4000
                                totalpriamount = Double(priamount)! * (totalWeight.rounded(.up))
                                total = Int(totalpriamount!)
                            }else{
                                totalpriamount = Double(priamount)! * sWeight
                                total = Int(totalpriamount!)
                            }
                            
                        }
                    }
                    
//                    print(totalWeight.rounded() ?? 0 )
                self.cekPrice.append(Tablelist(servicename,String(format: "%ld %@", locale: Locale.current, total!,""),service,remarks ?? "", leadtimestart,leadtimeend,minimum))

                }
                self.removeSpinner()
                break
            case .failure(let error):
                self.alertType(title:"",message: "\(error.localizedDescription)")
                self.removeSpinner()
                break
        }
        
        self.TableCekPrice.reloadData()
        }

    }
    
    //table datasource and delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cekPrice.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let data = cekPrice[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        
        cell.setData(data)
        
        return cell
        
    }
    
    func alertType(title:String,message:String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title:"OK", style: .default)
        alertController.addAction(okAction)
        self.present(alertController,animated: true,completion: nil)
    }
    
}

extension CekPriceController {
    
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
