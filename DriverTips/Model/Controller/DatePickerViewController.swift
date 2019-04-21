//
//  DatePicker.swift
//  DriverTips
//
//  Created by Kevin Jackson on 4/19/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import UIKit

class DatePickerViewController: UIViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var initialDate: Date?
    var selectedDate: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let initialDate = initialDate {
            datePicker.setDate(initialDate, animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        selectedDate = datePicker.date
    }
    

}

