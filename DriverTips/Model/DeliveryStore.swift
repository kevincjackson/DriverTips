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

    let archiveURL: URL = {
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
            // Swift -> Plist
            let propertyListData = try PropertyListEncoder().encode(all)

            // Plist -> Archive Data
            let archivedData = try NSKeyedArchiver.archivedData(withRootObject: propertyListData, requiringSecureCoding: false)

            // Archive Data -> File
            try archivedData.write(to: archiveURL)

            print("Archive OK.")
            return true
        } catch {
            print("Archive failed.")
            return false
        }
    }

    public func unarchive() -> [Delivery]? {
        do {
            // File -> Archive Data
            let archivedData = try Data(contentsOf: archiveURL)

            // Archive Data -> Property List Data
            let propertyListData = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(archivedData)

            // Property List Data -> Swift
            let deliveries = try PropertyListDecoder().decode([Delivery].self, from: propertyListData as! Data)

            return deliveries
        } catch  {

            print("Unarchive failed.")
            return nil
        }
    }

    init() {
        let deliveries = unarchive()
        all = deliveries ?? []
    }

}

