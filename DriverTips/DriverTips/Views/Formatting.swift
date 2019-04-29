//
//  Formatting.swift
//  DriverTips
//
//  Created by Kevin Jackson on 4/29/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import Foundation

// MARK: Driver Tip Formatters
// Formatters may be expensive operations, so keep them on the heap.
class DTFormatter {
    
    static let currencyFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        return numberFormatter
    }()
    
    static let dateAndTimeFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        return dateFormatter
    }()
    
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        return dateFormatter
    }()
}


// MARK: - Extensions
extension Date {
    var DTformattedDateAndTime: String {
        return DTFormatter.dateAndTimeFormatter.string(from: self)
    }
    
    var DTformattedDate: String {
        return DTFormatter.dateFormatter.string(from: self)
    }
}

extension Double {
    var DTformattedCurrency: String {
        return DTFormatter.currencyFormatter.string(from: NSNumber(value: self))!
    }
    
    var DTformattedEditingStyle: String {
        return self != 0 ? "\(self)" : ""
    }
}

extension Int {
    var DTformattedEditingStyle: String {
        return self != 0 ? "\(self)" : ""
    }
}
