//
//  StateController.swift
//  DriverTips
//
//  Created by Kevin Jackson on 4/27/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import Foundation

class StateController {
    
    private let storageController: StorageController
    public private(set) var worldState: WorldState
    
    // MARK: - Save & Init
    init(storageController: StorageController) {
        self.storageController = storageController
        self.worldState = storageController.load() ?? WorldState()
    }
    
    public func save() {
        storageController.save(worldState: worldState)
    }

    // MARK: - Mutators
    public func add(_ delivery: Delivery) {
        worldState.deliveries.append(delivery)
    }
    
    public func remove(_ delivery: Delivery) {
        if let index = worldState.deliveries.firstIndex(where: { $0.identifier == delivery.identifier }) {
            worldState.deliveries.remove(at: index)
        }
    }
    
    public func update(_ delivery: Delivery) {
        if let index = worldState.deliveries.firstIndex(where: { $0.identifier == delivery.identifier }) {
            worldState.deliveries[index] = delivery
        }
    }
}
