//
//  TextFieldDelegate.swift
//  DriverTips
//
//  Created by Kevin Jackson on 5/14/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import UIKit

class TextFieldDelegate: NSObject, UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
