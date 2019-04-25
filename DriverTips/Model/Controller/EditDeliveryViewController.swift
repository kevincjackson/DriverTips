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

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        if isNewDelivery {
            delivery = Delivery()
            navItem.title = "New Delivery"
        }
        else {
            navItem.title = "Edit Delivery"
        }
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
        case "gotoAmountPicker":
            break
        case "gotoDatePicker":
            saveDelivery()
            let datePickerVC = segue.destination as! DatePickerViewController
            datePickerVC.delegate = self
            datePickerVC.initialDate = delivery.date
        case "saveDelivery":
            saveDelivery()
        default:
           preconditionFailure("Unknown segue identifier.")
        }
    }
    
    // MARK: - Target-Actions
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Helper Methods
    private func saveDelivery() {
        delivery.order = Int(orderField.text!) ?? 0
        delivery.address = addressField.text!
        delivery.date = delivery.date
//        delivery.cash = Double(cashField.text!) ?? 0
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

// MARK: - DatePickerViewDelegate
extension EditDeliveryViewController: DatePickerViewDelegate {
    func datePickerView(_ dateSelected: Date) {
        delivery.date = dateSelected
    }
}
