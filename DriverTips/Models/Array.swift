//
//  Array.swift
//  DriverTips
//
//  Created by Kevin Jackson on 4/27/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import Foundation

extension Array where Element: Hashable {
    func removedDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()
        
        return filter { addedDict.updateValue(true, forKey: $0) == nil }
    }
}
