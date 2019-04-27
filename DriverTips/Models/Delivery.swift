
//
//  File.swift
//  DriverTips
//
//  Created by Kevin Jackson on 4/13/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import Foundation

struct Delivery: Codable {
    
    // Stored Properties
    var address: String = ""
    var cash: Double = 0
    var credit: Double = 0
    var date: Date = Date()
    var order: Int = 0
    var notes: String = ""
    var payout: Double = 0
    var tripComp: Double = 1.75
    var identifier: Int = Int.random(in: 0...Int.max)
    
    // Computed properties
    var totalExPayout: Double {
        return cash + credit + tripComp
    }
    
}
