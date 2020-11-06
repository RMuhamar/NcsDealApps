//
//  RetailController.swift
//  NcsDealApps
//
//  Created by Nusantara Card Semesta on 27/05/20.
//  Copyright © 2020 Nusantara Card Semesta. All rights reserved.
//

import UIKit
import SearchTextField
import Alamofire
import SwiftyJSON

class RetailController: UIViewController {
    @IBOutlet weak var searchTextField: SearchTextField!
    @IBOutlet weak var theScrollView: UIScrollView!
    @IBOutlet weak var txtFullName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtNumberPhone: UITextField!
    @IBOutlet weak var txtStreet: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPass: UITextField!
    
    var server = Server()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        configureCustomSearchTextField()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonSignUp(_ sender: Any) {
        signup()
    }
    
    private func signup(){
        
        if txtPassword.text != txtConfirmPass.text || txtPassword.text == "" || txtConfirmPass.text == "" {
            self.alertType(title:"",message: "Password Tidak Sesuai")
            return
        }
        if searchTextField.text == "" {
            self.alertType(title:"",message: "Kecamatan Harus di Isi")
        }
        
        let origin    = searchTextField.text
        let fullOri = origin!.components(separatedBy: ", ")

        let kecamatan:String?    = fullOri[0]
        let kabkot:String? = fullOri[1]
        let prov:String? = fullOri[2]
        
        let parameters: [String: String] = [
            "Username": self.txtFullName.text!,
            "Address": self.txtStreet.text!,
            "Kecamatan": kecamatan ?? "",
            "Kabupaten": kabkot ?? "",
            "Provinsi": prov ?? "",
            "Phone": self.txtNumberPhone.text!,
            "Email": self.txtEmail.text!,
            "Type": "Retail",
            "Cus_Name": "Cash Account",
            "AcctNo": "4231731000101656",
            "Password": self.txtPassword.text!
            ]
                    
            AF.request(self.server.URL_NCSDEAL + self.server.URL_SIGNUP, method: .post, parameters: parameters)
                            .responseJSON{(response) in
                                
//              let json = JSON(response.result.value!)
                                
                switch response.result{
                    case .success(let value):
                        
                        let json = JSON(value)
                                        
                        let kode = json["success"].int
//                        print(kode)
                                    
                        if kode == 0 {
                            self.alertType(title:"",message: "\(json["message"].string)")
                        }else if kode == 1 {
                            DispatchQueue.main.async {() -> Void in
                            let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginController") as! UIViewController
                                self.present(viewController, animated: true, completion: nil)
                            }
                        }else{
                            self.alertType(title:"",message: "\(json["message"].string)")
                        }
                        break
                        case .failure(let error):
                            print(error)
                                    self.alertType(title:"",message: "\(error.localizedDescription)")
                        break
                    }
                                
            }
    }
    
    fileprivate func configureCustomSearchTextField() {
        
        searchTextField.theme = SearchTextFieldTheme.lightTheme()
        
        // Define a header - Default: nothing
        let header = UILabel(frame: CGRect(x: 0, y: 0, width: searchTextField.frame.width, height: 30))
        header.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        header.textAlignment = .center
        header.font = UIFont.systemFont(ofSize: 14)
        header.text = "Pick your option"
        searchTextField.resultsListHeader = header

        
        // Modify current theme properties
        searchTextField.theme.font = UIFont.systemFont(ofSize: 12)
        searchTextField.theme.bgColor = UIColor.lightGray.withAlphaComponent(0.2)
        searchTextField.theme.borderColor = UIColor.lightGray.withAlphaComponent(0.5)
        searchTextField.theme.separatorColor = UIColor.lightGray.withAlphaComponent(0.5)
        searchTextField.theme.cellHeight = 50
        searchTextField.theme.placeholderColor = UIColor.lightGray
        
        
        // Max results list height - Default: No limit
        searchTextField.maxResultsListHeight = 200
        
        // Set specific comparision options - Default: .caseInsensitive
        searchTextField.comparisonOptions = [.caseInsensitive]

        // You can force the results list to support RTL languages - Default: false
        searchTextField.forceRightToLeft = false

        // Customize highlight attributes - Default: Bold
        searchTextField.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12)]
        
        searchTextField.itemSelectionHandler = { filteredResults, itemPosition in
            // Just in case you need the item position
            let item = filteredResults[itemPosition]
            print("Item at position \(itemPosition): \(item.title)")
            
            // Do whatever you want with the picked item
            self.searchTextField.text = item.title
        }
        
        searchTextField.userStoppedTypingHandler = {
            if let criteria = self.searchTextField.text {
                if criteria.count > 2 {
                    
                    // Show loading indicator
                    self.searchTextField.showLoadingIndicator()
                    
                    self.filterAcronymInBackground(criteria) { results in
                        // Set new items to filter
                        self.searchTextField.filterItems(results)
                        
                        // Stop loading indicator
                        self.searchTextField.stopLoadingIndicator()
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
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // KEyboard
    
    @objc func keyboardWillShow(notification:NSNotification){
        //give room at the bottom of the scroll view, so it doesn't cover up anything the user needs to tap
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)

        var contentInset:UIEdgeInsets = self.theScrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height
        theScrollView.contentInset = contentInset
    }

    @objc func keyboardWillHide(notification:NSNotification){
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        theScrollView.contentInset = contentInset
    }
    
    func alertType(title:String,message:String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title:"OK", style: .default)
        alertController.addAction(okAction)
        self.present(alertController,animated: true,completion: nil)
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

extension RetailController {
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(RetailController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
