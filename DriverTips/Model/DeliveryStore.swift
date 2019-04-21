//
//  DeliveryStore.swift
//  DriverTips
//
//  Created by Kevin Jackson on 4/13/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import Foundation

class DeliveryStore {
    
    private var all = [Delivery]()
    var deliveries: [Delivery] {
        return all
    }
    
    public func add(_ delivery: Delivery) {
        all.append(delivery)
    }
    
    public func remove(_ delivery: Delivery) {
        if let index = all.firstIndex(where: { $0.identifier == delivery.identifier }) {
            all.remove(at: index)
        }
    }
    
    public func update(_ delivery: Delivery) {
        if let index = all.firstIndex(where: { $0.identifier == delivery.identifier }) {
            all[index] = delivery
        }
    }
}
