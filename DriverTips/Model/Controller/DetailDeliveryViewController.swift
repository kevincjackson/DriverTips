//
//  ShowViewController.swift
//  DriverTips
//
//  Created by Kevin Jackson on 4/18/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import UIKit

class DetailDelivery: UITableViewController {

    @IBOutlet weak var orderLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var cashLabel: UILabel!
    @IBOutlet weak var creditLabel: UILabel!
    @IBOutlet weak var tripCompLabel: UILabel!
    @IBOutlet weak var totalExPayoutLabel: UILabel!
    @IBOutlet weak var payoutLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!

    var delivery: Delivery!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Navigation
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editButtonPressed))
        title = "Delivery"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Set Delivery Model
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "h:mm a"
        
        // Set Delivery View
        orderLabel.text = "\(delivery.order)"
        addressLabel.text = delivery.address
        dateLabel.text = dateFormatterPrint.string(from: delivery.date)
        cashLabel.text = String(format: "$%.2f", delivery.cash)
        creditLabel.text = String(format: "$%.2f", delivery.credit)
        tripCompLabel.text = String(format: "$%.2f", delivery.tripComp)
        totalExPayoutLabel.text = String(format: "$%.2f", delivery.totalExPayout)
        payoutLabel.text = delivery.payout != 0 ? String(format: "$%.2f", delivery.payout) : ""
        notesLabel.text = delivery.notes
    }

    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "gotoEditDelivery":
            let editVC = segue.destination as! EditDeliveryViewController
            editVC.delivery = delivery
        default:
            preconditionFailure("Unknown segue identifier.")
        }
    }
    
    // MARK: - Target-Actions
    @objc func editButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "gotoEditDelivery", sender: self)
    }
    
}
