//
//  ProfileController.swift
//  NcsDealApps
//
//  Created by RMuhamar on 24/03/20.
//  Copyright © 2020 RMuhamar. All rights reserved.
//

import UIKit

class ProfileController: UIViewController {

    @IBOutlet weak var UserName: UILabel!
    @IBOutlet weak var UserPhone: UILabel!
    @IBOutlet weak var UserAddress: UILabel!
    @IBOutlet weak var UserEmail: UILabel!
    @IBOutlet weak var UserCusAcc: UILabel!
    @IBOutlet weak var btnLogout: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserName.text = UserDefaults.standard.string(forKey: "Username") ?? "-"
        UserPhone.text = UserDefaults.standard.string(forKey: "Phone") ?? "-"
        UserAddress.text = UserDefaults.standard.string(forKey: "Address") ?? "-"
        UserEmail.text = UserDefaults.standard.string(forKey: "Email") ?? "-"
        UserCusAcc.text = UserDefaults.standard.string(forKey: "Cus_Name") ?? "-"
        
        if UserName.text != "-"{
            btnLogout.isHidden = false
        }else{
            btnLogout.isHidden = true
        }
        
    }
    
    @IBAction func btnLogOut(_ sender: Any) {
        
        let refreshAlert = UIAlertController(title: "Logout", message: "Are You Sure Logout", preferredStyle: UIAlertController.Style.alert)

        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            
                UserDefaults.standard.removeObject(forKey: "Username")
                UserDefaults.standard.removeObject(forKey: "Address")
                UserDefaults.standard.removeObject(forKey: "Provinsi")
                UserDefaults.standard.removeObject(forKey: "Kabupaten")
                UserDefaults.standard.removeObject(forKey: "Kecamatan")
                UserDefaults.standard.removeObject(forKey: "KecamatanID")
                UserDefaults.standard.removeObject(forKey: "PostCode")
                UserDefaults.standard.removeObject(forKey: "Email")
                UserDefaults.standard.removeObject(forKey: "Phone")
                UserDefaults.standard.removeObject(forKey: "Type")
                UserDefaults.standard.removeObject(forKey: "Cus_Name")
                UserDefaults.standard.removeObject(forKey: "AcctNo")
            
            self.showToast(message: "Logout Succsess")
            
            DispatchQueue.main.async {() -> Void in
            let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! UITabBarController
            self.present(viewController, animated: true, completion: nil)}
            
        }))

        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
              print("Handle Cancel Logic here")
        }))

        present(refreshAlert, animated: true, completion: nil)
    }
    
}

extension ProfileController {
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
}
