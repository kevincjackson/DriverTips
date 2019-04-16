//
//  DeliveryStore.swift
//  DriverTips
//
//  Created by Kevin Jackson on 4/13/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import Foundation

class DeliveryStore {
    
    var all = [Delivery]()
    
    @discardableResult public func createDelivery() -> Delivery {
        let delivery = Delivery(random: true)
        all.append(delivery)
        return delivery
    }
    
    public func deleteDelivery(_ delivery: Delivery) {
        guard let index = all.firstIndex(of: delivery) else {
            return
        }
        all.remove(at: index)
    }
    
    public func moveDelivery(from a: Int, to b: Int) {
        let delivery = all[a]
        all.remove(at: a)
        all.insert(delivery, at: b)
    }
    
}
