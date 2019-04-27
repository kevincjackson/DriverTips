//
//  DeliveryList.swift
//  DriverTips
//
//  Created by Kevin Jackson on 4/27/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import Foundation

struct DeliveryList {
    
    //MARK: - Stored Properties
    private(set) var deliveries: [Delivery]
    
    init(_ deliveries: [Delivery]) {
        self.deliveries = deliveries
    }

    //MARK: - Computed Properties
    var addresses: [String] {
        return deliveries
            .map { $0.address.trimmingCharacters(in: .whitespaces) }
            .filter { !$0.isEmpty }
            .removedDuplicates()
            .sorted()
    }

    var count: Int {
        return deliveries.count
    }

    var dates: [Date] {
         return deliveries
            .map { Calendar.current.startOfDay(for: $0.date) }
            .removedDuplicates()
            .sorted()
            .reversed()
    }

    var filteredForToday: DeliveryList {
        return DeliveryList(deliveries
            .filter { Calendar.current.isDateInToday($0.date) }
            .sorted(by: { $0.order < $1.order }))
    }

    var total: Double {
        return deliveries.reduce(0) { $0 + $1.total }
    }

    var totalCash: Double {
        return deliveries.reduce(0) { $0 + $1.cash }
    }

    var totalCredit: Double {
        return deliveries.reduce(0) { $0 + $1.credit }
    }

    var totalTripComp: Double {
        return deliveries.reduce(0) { $0 + $1.tripComp }
    }

    var totalPayout: Double {
        return deliveries.reduce(0) { $0 + $1.payout }
    }

    var totalExcludingPayout: Double {
        return deliveries.reduce(0) { $0 + $1.totalExcludingPayout }
    }
}
