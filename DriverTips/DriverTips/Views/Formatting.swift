//
//  Formatting.swift
//  DriverTips
//
//  Created by Kevin Jackson on 4/29/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import Foundation

extension Date {
    var DTformattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: self)
    }
}

extension Double {
    var DTformattedCurrency: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        return numberFormatter.string(from: NSNumber(value: self))!
    }
}
