//
//  CorporateController.swift
//  NcsDealApps
//
//  Created by Nusantara Card Semesta on 08/05/20.
//  Copyright © 2020 Nusantara Card Semesta. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CorporateController: UIViewController {

    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var hidenView: UIView!
    @IBOutlet weak var viewDetail: UIView!
    @IBOutlet weak var txtNoAkun: UITextField!
    @IBOutlet weak var sbCusName: UILabel!
    @IBOutlet weak var sbEmail: UILabel!
    @IBOutlet weak var sbProvinsi: UILabel!
    @IBOutlet weak var sbKota: UILabel!
    @IBOutlet weak var sbKecamatan: UILabel!
    @IBOutlet weak var sbStreet: UILabel!
    
    var server = Server()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnSearch.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.35).cgColor
        btnSearch.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        btnSearch.layer.shadowOpacity = 0.3
        btnSearch.layer.shadowRadius = 0.0
        btnSearch.layer.masksToBounds = false
        btnSearch.layer.cornerRadius = 15.0
        
        viewDetail.layer.cornerRadius = 10.0
        viewDetail.layer.borderColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        viewDetail.layer.borderWidth = 1.50
        
        hidenView.isHidden = true

        // Do any additional setup after loading the view.
    }
    
    @IBAction func searchButton(_ sender: Any) {
        if txtNoAkun.text == ""{
            self.alertType(title:"Alert",message:"No Akun Not Found")
        }else{
            loadNoAkun()
            hidenView.isHidden = false
        }
        
    }
    
    private func loadNoAkun(){
        let parameters: Parameters = ["AcctNo": txtNoAkun.text ?? ""]
        self.showSpinner(onView: self.view)
        AF.request(self.server.URL_NCSDEAL + self.server.GET_SEARCH_DATA_CORPORATE, method: .get, parameters: parameters)
                    .responseJSON {(response) in
        //                let json = JSON(response.result.value!)
                        
                        switch response.result{
                            
                        case .success(let value):
                            
                            let json = JSON(value)
                            
                                let AcctNo = json["result"][0]["AcctNo"].string!
                                let Cus_Name = json["result"][0]["Cus_Name"].string!
                                let Email = json["result"][0]["Email"].string!
                                let Provinsi = json["result"][0]["Provinsi"].string!
                                let Kabupaten = json["result"][0]["Kabupaten"].string!
                                let Kecamatan = json["result"][0]["Kecamatan"].string!
                                let Address = json["result"][0]["Address"].string!
                                
                                self.sbCusName.text = Cus_Name
                                self.sbEmail.text = Email
                                self.sbProvinsi.text = Provinsi
                                self.sbKota.text = Kabupaten
                                self.sbKecamatan.text = Kecamatan
                                self.sbStreet.text = Address
                            
                            self.removeSpinner()
                            break
                        case .failure:
                            self.alertType(title:"",message:"Connection Error")
                            self.removeSpinner()
                            break
                        }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CorporateController {
    
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
    
    func alertType(title:String,message:String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title:"OK", style: .default)
        alertController.addAction(okAction)
        self.present(alertController,animated: true,completion: nil)
    }
}
