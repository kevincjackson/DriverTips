//
//  HUDViewController.swift
//  DriverTips
//
//  Created by Kevin Jackson on 5/1/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import UIKit

class HUDViewController: UIViewController {

    @IBOutlet weak var deliveriesLabel: UILabel!
    @IBOutlet weak var totalExPayoutLabel: UILabel!
    @IBOutlet weak var totalPayoutLabel: UILabel!
    @IBOutlet weak var totalCashLabel: UILabel!
    @IBOutlet weak var totalCreditLabel: UILabel!
    @IBOutlet weak var totalTripCompLabel: UILabel!
    @IBOutlet weak var payoutStack: UIStackView!
    @IBOutlet weak var cashStack: UIStackView!
    @IBOutlet weak var creditStack: UIStackView!
    @IBOutlet weak var tripCompStack: UIStackView!

    var deliveries = [Delivery]()
    
    // MARK: - Helper Functions
    func update() {
        let list = DeliveryList(deliveries)
        
        // Update labels
        deliveriesLabel.text = "\(list.count)"
        totalExPayoutLabel.text = list.totalExcludingPayout.DTformattedCurrency
        totalPayoutLabel.text = list.totalPayout.DTformattedCurrency
        totalCashLabel.text = list.totalCash.DTformattedCurrency
        totalCreditLabel.text = list.totalCredit.DTformattedCurrency
        totalTripCompLabel.text = list.totalTripComp.DTformattedCurrency
        
        // Hides category if its' total is zero.
        payoutStack.isHidden = list.totalPayout == 0
        cashStack.isHidden = list.totalCash == 0
        creditStack.isHidden = list.totalCredit == 0
        tripCompStack.isHidden = list.totalTripComp == 0
    }
}
