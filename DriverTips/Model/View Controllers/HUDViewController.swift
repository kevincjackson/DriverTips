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
    
    var deliveries = [Delivery]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateHUD()
    }

    func updateHUD() {
        let list = DeliveryList(deliveries)
        deliveriesLabel.text = "\(list.count)"
        totalExPayoutLabel.text = list.totalExcludingPayout.DTformattedCurrency
        totalPayoutLabel.text = list.totalPayout.DTformattedCurrency
        totalCashLabel.text = list.totalCash.DTformattedCurrency
        totalCreditLabel.text = list.totalCredit.DTformattedCurrency
        totalTripCompLabel.text = list.totalTripComp.DTformattedCurrency
    }
}
