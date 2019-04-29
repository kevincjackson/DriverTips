//
//  File.swift
//  DriverTips
//
//  Created by Kevin Jackson on 4/29/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

struct CurrencyPicker {
    struct Options {
        static let dollars: [String] = Array(0...300).map { String($0) }
        static let cents: [String] = Array(0...99).map { String(format: "%02i", $0) }
    }
}
