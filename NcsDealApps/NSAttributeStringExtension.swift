//
//  NSAttributeStringExtension.swift
//  NcsDealApps
//
//  Created by RMuhamaron 07/03/20.
//  Copyright © 2020 RMuhamar. All rights reserved.
//

import Foundation

extension NSAttributedString {
    
    static func makeHyperLink(for path:String,in string: String, as subtring:String) -> NSAttributedString {
        let nsString = NSString(string: string)
        let subStringRange = nsString.range(of: subtring)
        let attributedString = NSMutableAttributedString(string: string)
        attributedString.addAttribute(.link, value: path, range: subStringRange)
        return attributedString
    }
}
