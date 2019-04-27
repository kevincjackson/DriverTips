//
//  DatePicker.swift
//  DriverTips
//
//  Created by Kevin Jackson on 4/19/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import UIKit

protocol DatePickerViewDelegate {
    func datePickerView(_ dateSelected: Date)
}

class DatePickerViewController: UIViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var initialDate: Date?
    var delegate: DatePickerViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let initialDate = initialDate {
            datePicker.setDate(initialDate, animated: true)
        }
    }

    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        delegate?.datePickerView(datePicker.date)
        dismiss(animated: true, completion: nil)
    }
}
