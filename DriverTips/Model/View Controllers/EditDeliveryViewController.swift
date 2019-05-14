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
    @IBOutlet weak var notesView: UITextView!

    var delivery: Delivery!
    var isNewDelivery = false
    var datePicker: UIDatePicker!

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
                let currencyPicker = CurrencyPicker()
                currencyPicker.tag = $0

                currencyPicker.addTarget(self, action: #selector(currencyPickerValueChanged(_:)), for: .valueChanged)
                $1?.inputView = currencyPicker
            }

        // Setup Date Picker
        datePicker = UIDatePicker()
        datePicker.setDate(delivery.date, animated: false)
        datePicker.addTarget(self, action: #selector(datePickerSelectedDate), for: .valueChanged)
        dateField.inputView = datePicker

        // Set Input Accessory Views
        let dismissalToolbar = DismissalToolbar()
        dismissalToolbar.addTarget(self, action: #selector(dismissKeyboard), for: .touchUpInside)
        [orderField, addressField, dateField, cashField, creditField, tripCompField, payoutField]
            .forEach { $0?.inputAccessoryView = dismissalToolbar }
        notesView.inputAccessoryView = dismissalToolbar
    }

    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        
        if delivery.order == 0 {
            orderField.becomeFirstResponder()
        }
        
        orderField.text = delivery.order.DTformattedEditingStyle
        addressField.text = delivery.address
        dateField.text = delivery.date.DTformattedDateAndTime
        cashField.text = delivery.cash.DTformattedEditingStyle
        creditField.text = delivery.credit.DTformattedEditingStyle
        tripCompField.text = delivery.tripComp.DTformattedEditingStyle
        payoutField.text = delivery.payout.DTformattedEditingStyle
        notesView.text = delivery.notes
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
        delivery.notes = notesView.text!
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    @objc func datePickerSelectedDate() {
        delivery.date = datePicker.date
        dateField.text = delivery.date.DTformattedDateAndTime
    }
    
    @objc func currencyPickerValueChanged(_ sender: CurrencyPicker) {
        switch sender.tag {
        case 0:
            cashField.text = String(sender.selectedAmount)
        case 1:
            creditField.text = String(sender.selectedAmount)
        case 2:
            payoutField.text = String(sender.selectedAmount)
        default:
            preconditionFailure("Unknown currency picker")
        }
    }
}

// MARK: - UITextFieldDelegate
extension EditDeliveryViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
