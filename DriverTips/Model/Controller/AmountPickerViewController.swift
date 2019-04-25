//
//  DatePicker.swift
//  DriverTips
//
//  Created by Kevin Jackson on 4/19/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import UIKit

protocol AmountPickerViewDelegate {
    func amountPickerView(_ amountSelected: Double)
}

class AmountPickerViewController: UIViewController {
    
    @IBOutlet weak var amountPicker: UIPickerView!
    
    var initialAmount: Date?
    var delegate: AmountPickerViewDelegate?
    
    // Stored Properties
    let dollarOptions = Array(1...300).map { String($0) }
    let centOptions = Array(0...99).map { String(format: "%02i", $0) }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let initialAmount = initialAmount {
            // TODO
            print(initialAmount)
        }
    }

    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        delegate?.amountPickerView(10)
        dismiss(animated: true, completion: nil)
    }
}

extension AmountPickerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
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
            preconditionFailure()
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
            preconditionFailure()
        }
    }
    
}
