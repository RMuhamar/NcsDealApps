//
//  LoginController.swift
//  NcsDealApps
//
//  Created by RMuhamar on 24/03/20.
//
//  Copyright © 2020 Nusantara Card Semesta. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import PasswordTextField

class LoginController: UIViewController {

    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: PasswordTextField!
    @IBOutlet weak var content: UIView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    var type:String!
    var server = Server()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        content.roundCornersSucces(corners: [.topLeft, .topRight], radius: 30)
        
        let paddingViewUsername: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 20))
        txtUsername.leftView = paddingViewUsername
        txtUsername.leftViewMode = .always
        
        let paddingViewPassword: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 20))
        txtPassword.leftView = paddingViewPassword
        txtPassword.leftViewMode = .always
        
        typeSegment()
    }
    @IBAction func btnClose(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnSegment(_ sender: Any) {
        typeSegment()
    }
    
    @IBAction func btnLogin(_ sender: Any) {
        login()
        let validationRule = RegexRule(regex:"^[A-Z ]+$", errorMessage: "Password must contain only uppercase letters")

        txtPassword.validationRule = validationRule

        if txtPassword.isInvalid(){
          print(txtPassword.errorMessage)
        }
    }
    
    private func getData(){
        let parameters: Parameters = ["User": self.txtUsername.text ?? "","Type": self.type ?? "" ]
            AF.request(self.server.URL_NCSDEAL + self.server.GetData, method: .get, parameters: parameters)
                .responseJSON {(response) in
    //                let json = JSON(response.result.value!)
                    
                    switch response.result{
                        
                    case .success(let value):
                        
                        let json = JSON(value)
                        
                        if json["result"][0]["Username"].string != nil {
                            let username = json["result"][0]["Username"].string!
                            let address = json["result"][0]["Address"].string!
                            let provinsi = json["result"][0]["Provinsi"].string!
                            let kabupaten = json["result"][0]["Kabupaten"].string!
                            let kecamatan = json["result"][0]["Kecamatan"].string!
                            let kecamatanid = json["result"][0]["KecamatanID"].string ?? ""
                            let postcode = json["result"][0]["PostCode"].string ?? ""
                            let email = json["result"][0]["Email"].string!
                            let phone = json["result"][0]["Phone"].string!
                            let type = json["result"][0]["Type"].string!
                            let cus_name = json["result"][0]["Cus_Name"].string!
                            let acctno = json["result"][0]["AcctNo"].string!
                            
                            UserDefaults.standard.set(username, forKey: "Username")
                            UserDefaults.standard.set(address, forKey: "Address")
                            UserDefaults.standard.set(provinsi, forKey: "Provinsi")
                            UserDefaults.standard.set(kabupaten, forKey: "Kabupaten")
                            UserDefaults.standard.set(kecamatan, forKey: "Kecamatan")
                            UserDefaults.standard.set(kecamatanid, forKey: "KecamatanID")
                            UserDefaults.standard.set(postcode, forKey: "PostCode")
                            UserDefaults.standard.set(email, forKey: "Email")
                            UserDefaults.standard.set(phone, forKey: "Phone")
                            UserDefaults.standard.set(type, forKey: "Type")
                            UserDefaults.standard.set(cus_name, forKey: "Cus_Name")
                            UserDefaults.standard.set(acctno, forKey: "AcctNo")
                                
                            
                        }else{
                            
                            self.alertType(title:"Alert",message:"Data Not Found")
                            
                        }
                        
                        
                        break
                    case .failure(let error):
                        self.alertType(title:"",message:"\(error.localizedDescription)")
                        break
                    }
                    
            }
        }
    
    private func login(){
        let parameters: [String: String] = [
            "User": self.txtUsername.text!,
            "Password": self.txtPassword.text!,
            "Type": type
        ]
        
        AF.request(self.server.URL_NCSDEAL + self.server.Login, method: .post, parameters: parameters)
                .responseString{(response) in
//                    let json = String(response.result.value!)
                    switch response.result{
//
                    case .success(let value):

                        if value == self.server.LOGIN_SUCCESS {
                            self.getData()
                            DispatchQueue.main.async {() -> Void in
                                let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! UITabBarController
                                self.present(viewController, animated: true, completion: nil)}
                            
                        }else {
                            self.showToast(message: value)
                        }

                        break
                    case .failure(let error):
                        self.alertType(title:"",message: "\(error.localizedDescription)")
                        break
                    }
                    
            }
        }
    
    func alertType(title:String,message:String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title:"OK", style: .default)
        alertController.addAction(okAction)
        self.present(alertController,animated: true,completion: nil)
    }
    
    func typeSegment(){
        switch segmentControl.selectedSegmentIndex
        {
        case 0:
            type = "retail"
        case 1:
            type = "corporate"
        default:
            break
        }
    }

}

extension LoginController {
    func showToast(message: String){
        let width = textWidth(text: message, font: UIFont.systemFont(ofSize: 20))
        let toastLabel = UILabel(frame:CGRect(x: self.view.frame.width/2-width/2, y: self.view.frame.height - 150 , width: width, height: 20))
        toastLabel.textAlignment = .center
        toastLabel.backgroundColor = UIColor.red.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds = true
        toastLabel.text = message
        self.view.addSubview(toastLabel)
        
        UIView.animate(withDuration: 4.0, delay: 1.0, options: .curveEaseInOut, animations: {
            toastLabel.alpha = 0.0
        }) { (isCompleted) in
            toastLabel.removeFromSuperview()
        }
    }
    
    func textWidth(text: String, font: UIFont?) -> CGFloat {
        let attributes = font != nil ? [NSAttributedString.Key.font: font] : [:]
        return text.size(withAttributes: attributes as [NSAttributedString.Key : Any]).width
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
