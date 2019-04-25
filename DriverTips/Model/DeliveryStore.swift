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

    let url: URL = {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return path.appendingPathComponent("deliveryStore.archive")
    }()

    // MARK: - In Memory Functions
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

    // MARK: - Archive Functions
    @discardableResult public func archive() -> Bool {
        do {
            // Swift -> Data
            let data = try PropertyListEncoder().encode(all)

            // Data -> File
            try data.write(to: url)

            print("Archive OK.")
            return true
            
        } catch {
            print("Archive failed.")
            return false
        }
    }

    init() {
        do {
            // File -> Data
            let data = try Data(contentsOf: url)
            
            // Data -> Swift
            all = try PropertyListDecoder().decode([Delivery].self, from: data )
            
            print("Unarchive OK.")
            
        } catch  {
            print("Unarchive failed.")
        }
    }

}

