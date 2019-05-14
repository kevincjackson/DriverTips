//
//  CurrencyPickerDataDelegate.swift
//  CurrencyPicker
//
//  Created by Kevin Jackson on 5/14/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import UIKit

class CurrencyPickerDataDelegate: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @objc dynamic var selectedAmount: Double = 0
    private var dollarOptions: [String]!
    private var centOptions = Array(0...99).map { String(format: "%02i", $0) }

    func setDollarOptions(min: Int, max: Int) {
        dollarOptions = Array(min...max).map { String($0) }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 4
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return 1
        case 1:
            return dollarOptions.count
        case 2:
            return 1
        case 3:
            return centOptions.count
        default:
            preconditionFailure("Unknown pickerView component.")
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return "$"
        case 1:
            return dollarOptions[row]
        case 2:
            return "."
        case 3:
            return centOptions[row]
        default:
            preconditionFailure("Unknown pickerView component.")
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let dollars = dollarOptions[pickerView.selectedRow(inComponent: 1)]
        let cents = centOptions[pickerView.selectedRow(inComponent: 3)]
        let amountString = "\(dollars).\(cents)"
        selectedAmount = Double(amountString)!
    }
}
