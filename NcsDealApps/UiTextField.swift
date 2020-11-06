//
//  UiTextField.swift
//  NcsDealApps
//
//  Created by Nusantara Card Semesta on 20/02/20.
//  Copyright © 2020 Nusantara Card Semesta. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    func loadDropdownData(data: [String]) {
        self.inputView = MyPickerView(pickerData: data, dropdownField: self)
    }
    func loadDropdownData(data: [String], onSelect selectionHandler : @escaping (_ selectedText: String) -> Void) {
        self.inputView = MyPickerView(pickerData: data, dropdownField: self, onSelect: selectionHandler)
    }
}
