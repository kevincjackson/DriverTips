//
//  EditTableViewController.swift
//  DriverTips
//
//  Created by Kevin Jackson on 4/18/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import UIKit

class EditDeliveryViewController: UITableViewController {
  
    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet weak var orderField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var cashField: UITextField!
    @IBOutlet weak var creditField: UITextField!
    @IBOutlet weak var tripCompField: UITextField!
    @IBOutlet weak var payoutField: UITextField!
    @IBOutlet weak var notesField: UITextView!

    var delivery: Delivery!
    var isNewDelivery = false
    var dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateStyle = .short
        df.timeStyle = .short
        return df
    }()
    var datePicker: UIDatePicker!
    var toolbarWithDoneButton: UIToolbar = {
        let toolbar = UIToolbar()
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissKeyboard))
        toolbar.setItems([space, done], animated: false)
        toolbar.isUserInteractionEnabled = true
        toolbar.sizeToFit()
        return toolbar
    }()

    let currencyPickerOptions = (
        dollars: Array(0...300).map { String($0) },
        cents: Array(0...99).map { String(format: "%02i", $0) }
    )

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Delivery and Titles
        if isNewDelivery {
            delivery = Delivery()
            navItem.title = "New Delivery"
        }
        else {
            navItem.title = "Edit Delivery"
        }
        
        // Setup Currency Pickers
        [cashField, creditField, payoutField]
            .enumerated()
            .forEach {
                let currencyPicker = UIPickerView()
                currencyPicker.tag = $0
                currencyPicker.delegate = self
                currencyPicker.dataSource = self
                $1?.inputView = currencyPicker
            }

        // Setup Date Picker
        datePicker = UIDatePicker()
        datePicker.setDate(delivery.date, animated: false)
        datePicker.addTarget(self, action: #selector(dateSelected), for: .valueChanged)
        dateField.inputView = datePicker

        // Set Input Accessory Views
        [orderField, addressField, dateField, cashField, creditField, tripCompField, payoutField]
            .forEach { $0?.inputAccessoryView = toolbarWithDoneButton }
        notesField.inputAccessoryView = toolbarWithDoneButton
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func dateSelected() {
        delivery.date = datePicker.date
        dateField.text = dateFormatter.string(from: delivery.date)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        
        orderField.text = delivery.order != 0 ? "\(delivery.order)" : ""
        addressField.text = delivery.address
        dateField.text = dateFormatter.string(from: delivery.date)
        cashField.text = delivery.cash != 0 ? "\(delivery.cash)" : ""
        creditField.text = delivery.credit != 0 ? "\(delivery.credit)" : ""
        tripCompField.text = delivery.tripComp != 0 ? "\(delivery.tripComp)" : ""
        payoutField.text = delivery.payout != 0 ? "\(delivery.payout)" : ""
        notesField.text = delivery.notes
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if delivery.order == 0 {
            orderField.becomeFirstResponder()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        view.endEditing(true)
    }

    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "cancelDelivery":
            break
        case "saveDelivery":
            saveDelivery()
        default:
           preconditionFailure("Unknown segue identifier.")
        }
    }
    
    // MARK: - Helper Methods
    private func saveDelivery() {
        delivery.order = Int(orderField.text!) ?? 0
        delivery.address = addressField.text!
        delivery.date = delivery.date
        delivery.cash = Double(cashField.text!) ?? 0
        delivery.credit = Double(creditField.text!) ?? 0
        delivery.tripComp = Double(tripCompField.text!) ?? 0
        delivery.payout = Double(payoutField.text!) ?? 0
        delivery.notes = notesField.text!
    }
}

// MARK: - UITextFieldDelegate
extension EditDeliveryViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension EditDeliveryViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 4
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return 1
        case 1:
            return currencyPickerOptions.dollars.count
        case 2:
            return 1
        case 3:
            return currencyPickerOptions.cents.count
        default:
            preconditionFailure()
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return "$"
        case 1:
            return currencyPickerOptions.dollars[row]
        case 2:
            return "."
        case 3:
            return currencyPickerOptions.cents[row]
        default:
            preconditionFailure()
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let dollars = currencyPickerOptions.dollars[pickerView.selectedRow(inComponent: 1)]
        let cents = currencyPickerOptions.cents[pickerView.selectedRow(inComponent: 3)]
        let text = "\(dollars).\(cents)"

        switch pickerView.tag {
        case 0:
            cashField.text = text
        case 1:
            creditField.text = text
        case 2:
            payoutField.text = text
        default:
            preconditionFailure()
        }
    }
}
