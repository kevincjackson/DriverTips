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

}
