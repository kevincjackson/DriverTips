
//
//  File.swift
//  DriverTips
//
//  Created by Kevin Jackson on 4/13/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import Foundation

class Delivery: NSObject {
    
    var address: String
    var cash: Double
    var credit: Double
    var date: Date
    var order: Int
    var notes: String
    var payout: Double
    var tripComp: Double
    
    init(address: String = "", cash: Double = 0, credit: Double = 0, date: Date = Date(), order: Int = 0, notes: String = "", payout: Double = 0, tripComp: Double = 0) {
        self.address = address
        self.cash = cash
        self.credit = credit
        self.date = date
        self.order = order
        self.notes = notes
        self.payout = payout
        self.tripComp = tripComp
    }
    
    convenience init(random: Bool = true) {
        if random {
            self.init(address: ["1908 Morgan", "200 S Catalina", "19430 Entradero"][Int.random(in: 0...2)],
                      cash: Double.random(in: 0...10),
                      credit: Double.random(in: 0...10),
                      date: Date(),
                      order: Int.random(in: 0...300),
                      notes: ["", "Left pizza on porch. Lots of boxes on porch. Doesn't look like they've been home in awhile.", "Scary dogs."][Int.random(in: 0...2)],
                      payout: [0, 3.0, 5.0][Int.random(in: 0...2)],
                      tripComp: 1.75
                      )
        }
        else {
            self.init()
        }
    }

}
