//
//  OnProcessController.swift
//  NcsDealApps
//
//  Created by Nusantara Card Semesta on 21/07/20.
//  Copyright © 2020 Nusantara Card Semesta. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class OnProcessController: UIViewController,UITableViewDelegate, UITableViewDataSource{
    
var table:UITableView!
let fruits = ["Apple", "Apricot", "Banana", "Blueberry", "Cantaloupe", "Cherry",
              "Clementine", "Coconut", "Cranberry", "Fig", "Grape", "Grapefruit",
              "Kiwi fruit", "Lemon", "Lime", "Lychee", "Mandarine", "Mango",
              "Melon", "Nectarine", "Olive", "Orange", "Papaya", "Peach",
              "Pear", "Pineapple", "Raspberry", "Strawberry"]

    @IBOutlet weak var testView: UIView!
    
    @IBOutlet weak var imageEmpty: UIImageView!
    var server = Server()
    var cekOnProcess = [CekTableOnProcess]()
    @IBOutlet weak var tableOnProcess: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableOnProcess.dataSource = self
        self.tableOnProcess.delegate = self
        getListOnProcess()
        testView.roundCorners(corners: [.topLeft, .topRight], radius: 30)
    }
    
    private func getListOnProcess(){
        self.showSpinner(onView: self.view)
        var phone:String? = UserDefaults.standard.string(forKey: "Phone") ?? ""
        var acctno:String? = UserDefaults.standard.string(forKey: "AcctNo") ?? ""
        let parameters: Parameters = ["pichp": phone ?? "","acctno": acctno ?? "" ]
        
        AF.request(self.server.URL_NCSDEAL + self.server.ListOnProcess, method: .get, parameters: parameters)
            .responseJSON {(response) in
        
        
        
        switch response.result{
            case .success(let value):
                let json = JSON(value)
                for i in 0 ..< json.count{
                    
                var remarks:String?
                let AWB = json[i]["AWB"].string ?? ""
                let PuBookNo = json[i]["PuBookNo"].string ?? ""
                let DatePickup = json[i]["DatePickup"].string ?? ""
                let TimeFrom = json[i]["TimeFrom"].string ?? ""
                let TimeTo = json[i]["TimeTo"].string ?? ""
                let ServiceName = json[i]["ServiceName"].string ?? ""
                let PuTransportName = json[i]["PuTransportName"].string ?? ""
                let PickupStatus = json[i]["PickupStatus"].string ?? ""
                    remarks = json[i]["SpesialInstruction"].string ?? ""
                    
                    
                    self.cekOnProcess.append(CekTableOnProcess(AWB,PuBookNo, DatePickup,"\(TimeFrom) - \(TimeTo)",ServiceName, PuTransportName,PickupStatus,remarks ?? ""))
                    
                    if AWB == "" {
                        self.imageEmpty.isHidden = false
                    }else{
                        self.imageEmpty.isHidden = true
                    }

                }
                break
            case .failure(let error):
                print(error)
                break
        }
        
        self.tableOnProcess.reloadData()
                self.removeSpinner()
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //table datasource and delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cekOnProcess.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let data = cekOnProcess[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableOnProcess") as! TableOnProcess
        
        cell.setData(data)
        
        return cell
        
    }
    
    override func updateViewConstraints() {

        super.updateViewConstraints()
    }

}

extension OnProcessController{
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
}

extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
