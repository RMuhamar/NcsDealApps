//
//  ListRequestController.swift
//  NcsDealApps
//
//  Created by Nusantara Card Semesta on 17/07/20.
//  Copyright © 2020 Nusantara Card Semesta. All rights reserved.
//

import Foundation
import UIKit

class ListRequestController: UIViewController, WormTabStripDelegate {

    var tabs:[UIViewController] = []
    let numberOfTabs = 3
    
    @IBOutlet weak var tabView: WormTabStrip!
    @IBOutlet weak var onProcessView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabs()
        setUpViewPager()
    }
    
    func setUpTabs(){
        for i in 1...numberOfTabs {
            if i == 2 {
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "onProcess") as! UIViewController
                tabs.append(vc)
            }else if i == 3 {
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "onSuccess") as! UIViewController
                tabs.append(vc)
            }else {
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "waiting") as! UIViewController
                tabs.append(vc)
            }
            
        }
    }
    
    func setUpViewPager(){
        let frame =  CGRect(x: 0, y: 40, width: self.view.frame.size.width, height: self.view.frame.size.height - 40)
        let viewPager:WormTabStrip = WormTabStrip(frame: frame)
        self.view.addSubview(viewPager)
        viewPager.delegate = self
        viewPager.eyStyle.wormStyel = .BUBBLE
        viewPager.eyStyle.isWormEnable = true
        viewPager.eyStyle.spacingBetweenTabs = 15
        viewPager.eyStyle.dividerBackgroundColor = UIColor(netHex: 0x0C7784)
        viewPager.eyStyle.tabItemSelectedColor = UIColor(netHex: 0x0C7784)
        viewPager.currentTabIndex = 1
        viewPager.buildUI()
    }
    
    func WTSNumberOfTabs() -> Int {
        return numberOfTabs
    }
    
    func WTSTitleForTab(index: Int) -> String {
        var title:String
        if index == 0 {
             title = "Waiting"
        }else if index == 1 {
             title = "On Process"
        }else{
             title = "Success"
        }
        
        return title
    }
    
    func WTSViewOfTab(index: Int) -> UIView {
        let view = tabs[index]
        return view.view
    }
    
    func WTSReachedLeftEdge(panParam: UIPanGestureRecognizer) {
        
    }
    
    func WTSReachedRightEdge(panParam: UIPanGestureRecognizer) {
        
    }
}
