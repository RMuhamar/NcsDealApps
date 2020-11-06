//
//  CardViewController.swift
//  NcsDealApps
//
//  Created by Nusantara Card Semesta on 22/06/20.
//  Copyright © 2020 Nusantara Card Semesta. All rights reserved.
//

import UIKit
import SearchTextField
import Alamofire
import SwiftyJSON

class CardViewController: UIViewController {

    @IBOutlet weak var handleArea: UIView!
    @IBOutlet weak var ShipperName: UITextField!
    @IBOutlet weak var Phone: UITextField!
    @IBOutlet weak var Kecamatan: SearchTextField!
    @IBOutlet weak var Street: UITextView!
    
    var server = Server()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
        ShipperName.text = UserDefaults.standard.string(forKey: "Username") ?? "-"
        Phone.text = UserDefaults.standard.string(forKey: "Phone") ?? "-"
        Street.text = UserDefaults.standard.string(forKey: "Address") ?? "-"
        Kecamatan.text = "\(UserDefaults.standard.string(forKey: "Kecamatan") ?? ""), \(UserDefaults.standard.string(forKey: "Kabupaten") ?? "" ), \(UserDefaults.standard.string(forKey: "Provinsi") ?? "" ) "
        
        configureCustomSearchTextField()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func Clear(_ sender: Any) {
        
        ShipperName.text = ""
        Phone.text = ""
        Street.text = ""
        Kecamatan.text = ""
    }
    
    @IBAction func btnApply(_ sender: Any) {
        if ShipperName.text == "" || Phone.text == "" || Kecamatan.text == "" || Street.text == ""{
            self.alertType(title:"Alert",message:"Lengkapi Data Terlebih Dahulu")
        }else{
            getData()
            navigationController?.popViewController(animated: true)
            dismiss(animated: true, completion: nil)
        }
        
    }
    
    func getData() {
        
        getKecID()
        UserDefaults.standard.set(ShipperName.text, forKey: "ShipperName")
        UserDefaults.standard.set(Phone.text, forKey: "ShipperPhone")
        UserDefaults.standard.set(Kecamatan.text, forKey: "ShipperKecamatan")
        UserDefaults.standard.set(Street.text, forKey: "ShipperStreet")
    }
    
    private func getKecID(){
        let origin    = Kecamatan.text
        let fullOri = origin!.components(separatedBy: ", ")

        let kecamatan:String    = fullOri[0]
        let kabkot:String = fullOri[1]
        let prov:String = fullOri[2]
        
        if kecamatan == "" || kabkot == "" || prov == "" {
            self.alertType(title:"Alert",message:"Format Kecamatan Salah")
        }else{
            let param: Parameters = ["kabname": kabkot ?? "","kecname": kecamatan ?? ""]
            AF.request(self.server.URL_NCSDEAL + self.server.GetKecID, method: .get,parameters: param)
                .responseJSON {(response) in
                
                switch response.result{
                    
                case .success(let value):
                    
                    let json = JSON(value)
                        let kecID = json["result"][0]["KecID"].string!
                    UserDefaults.standard.set(kecID, forKey: "kecIDShipper")
                    UserDefaults.standard.set(kecamatan, forKey: "KecShipper")
                    UserDefaults.standard.set(kabkot, forKey: "KabShipper")
                    UserDefaults.standard.set(prov, forKey: "ProvShipper")
                    break
                case .failure:
                    
                    break
                }
            }
        }
        
    }
    
    fileprivate func configureCustomSearchTextField() {
        
        Kecamatan.theme = SearchTextFieldTheme.lightTheme()
        
        // Define a header - Default: nothing
        let header = UILabel(frame: CGRect(x: 0, y: 0, width: Kecamatan.frame.width, height: 30))
        header.backgroundColor = UIColor.white
        header.textAlignment = .center
        header.font = UIFont.systemFont(ofSize: 14)
        header.text = "Pick your option"
        Kecamatan.resultsListHeader = header

        
        // Modify current theme properties
        Kecamatan.theme.font = UIFont.systemFont(ofSize: 12)
        Kecamatan.theme.bgColor = UIColor.white
        Kecamatan.theme.borderColor = UIColor.lightGray.withAlphaComponent(0.5)
        Kecamatan.theme.separatorColor = UIColor.lightGray.withAlphaComponent(0.5)
        Kecamatan.theme.cellHeight = 50
        Kecamatan.theme.placeholderColor = UIColor.lightGray
        
        
        // Max results list height - Default: No limit
        Kecamatan.maxResultsListHeight = 200
        
        // Set specific comparision options - Default: .caseInsensitive
        Kecamatan.comparisonOptions = [.caseInsensitive]

        // You can force the results list to support RTL languages - Default: false
        Kecamatan.forceRightToLeft = false

        // Customize highlight attributes - Default: Bold
        Kecamatan.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12)]
        
        Kecamatan.itemSelectionHandler = { filteredResults, itemPosition in
            // Just in case you need the item position
            let item = filteredResults[itemPosition]
            print("Item at position \(itemPosition): \(item.title)")
            
            // Do whatever you want with the picked item
            self.Kecamatan.text = item.title
        }
        
        Kecamatan.userStoppedTypingHandler = {
            if let criteria = self.Kecamatan.text {
                if criteria.count > 2 {
                    
                    // Show loading indicator
                    self.Kecamatan.showLoadingIndicator()
                    
                    self.filterAcronymInBackground(criteria) { results in
                        // Set new items to filter
                        self.Kecamatan.filterItems(results)
                        
                        // Stop loading indicator
                        self.Kecamatan.stopLoadingIndicator()
                    }
                }
            }
        } as (() -> Void)
    }
    
    
    fileprivate func filterAcronymInBackground(_ criteria: String, callback: @escaping ((_ results: [SearchTextFieldItem]) -> Void)) {
        let parameters: Parameters = ["KecName": criteria]
        var results = [SearchTextFieldItem]()
        AF.request("https://api.ptncs.com/idss/android/php/ncs_deal/searchKecamatanOri.php?", method: .get , parameters: parameters)
            .responseJSON {(response) in
        
        
        let json = JSON(response.result.value!)
                
        switch response.result{
            case .success(let _):
                for i in 0 ..< json["results"].count{
                    
                let servicename = json["results"][i]["KecName"].string ?? ""
                    
                    
                    results.append(SearchTextFieldItem(title: servicename, subtitle: criteria.uppercased(), image: UIImage(named: "")))
                    
                    DispatchQueue.main.async {
                        callback(results)
                    }

                }
                
                break
            case .failure(let error):
                DispatchQueue.main.async {
                    callback([])
                }
                break
                
                }
                
        }
    }

}

extension CardViewController {
    
    func alertType(title:String,message:String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title:"OK", style: .default)
        alertController.addAction(okAction)
        self.present(alertController,animated: true,completion: nil)
    }
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
