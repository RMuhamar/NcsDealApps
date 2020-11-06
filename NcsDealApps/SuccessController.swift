//
//  SuccessController.swift
//  NcsDealApps
//
//  Created by Nusantara Card Semesta on 21/07/20.
//  Copyright © 2020 Nusantara Card Semesta. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SuccessController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableSuccess: UITableView!
    var server = Server()
    var cekSuccess = [CekTableSuccess]()
    @IBOutlet weak var roundedView: UIView!
    @IBOutlet weak var imageEmpty: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableSuccess.dataSource = self
        self.tableSuccess.delegate = self
        getListOnProcess()
        roundedView.roundCornersSuccess(corners: [.topLeft, .topRight], radius: 30)
    }
    
    private func getListOnProcess(){
        var phone:String? = UserDefaults.standard.string(forKey: "Phone") ?? ""
        var acctno:String? = UserDefaults.standard.string(forKey: "AcctNo") ?? ""
        let parameters: Parameters = ["pichp": phone ?? "","acctno": acctno ?? "" ]
        AF.request(self.server.URL_NCSDEAL + self.server.ListOnSuccess, method: .get, parameters: parameters)
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
                    
                    
                    self.cekSuccess.append(CekTableSuccess(AWB,PuBookNo, DatePickup,"\(TimeFrom) - \(TimeTo)",ServiceName, PuTransportName,PickupStatus,remarks ?? ""))
                    
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
        
        self.tableSuccess.reloadData()
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //table datasource and delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cekSuccess.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let data = cekSuccess[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableSuccess") as! TableSuccess
        
        cell.setData(data)
        
        return cell
        
    }
    
    override func updateViewConstraints() {

        super.updateViewConstraints()
    }

}

extension UIView {
   func roundCornersSuccess(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
