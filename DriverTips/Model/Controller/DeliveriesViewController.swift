//
//  ViewController.swift
//  DriverTips
//
//  Created by Kevin Jackson on 4/13/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import UIKit

class DeliveriesViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var hudDeliveriesLabel: UILabel!
    @IBOutlet weak var hudTotalLabel: UILabel!
    @IBOutlet weak var hudPayoutLabel: UILabel!
    
    var deliveryStore: DeliveryStore!
    var deliveries: [Delivery]! {
        didSet {
            updateHUD()
        }
    }

    //MARK: - View Life Cycle`
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        deliveries = deliveryStore.deliveries
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        deliveries = deliveryStore.deliveries
        tableView.reloadData()
    }
    
    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "gotoNewDelivery":
            let editVC = segue.destination as! EditDeliveryViewController
            editVC.isNewDelivery = true
        case "gotoEditDelivery":
            let editVC = segue.destination as! EditDeliveryViewController
            editVC.isNewDelivery = false
            guard let row = tableView.indexPathForSelectedRow?.row else {
                return
            }
            editVC.delivery = deliveries[row]
        default:
            preconditionFailure("Unknown segue identifier.")
        }
    }
    

    @IBAction func saveDelivery(_ segue: UIStoryboardSegue) {
        let editVC = segue.source as! EditDeliveryViewController
        if let delivery = editVC.delivery {
            if editVC.isNewDelivery {
                deliveryStore.add(delivery)
            }
            else {
                deliveryStore.update(delivery)
            }
        }
    }
    
    // MARK: - Helper Functions
    private func updateHUD() {
        hudDeliveriesLabel.text = "\(deliveries.count)"
        hudTotalLabel.text = "\(deliveries.reduce(0) { $0 + $1.totalExPayout })"
        hudPayoutLabel.text = "\(deliveries.reduce(0) { $0 + $1.payout })"
    }
    

}

// MARK: - Table View DataSource
extension DeliveriesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deliveryStore.deliveries.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "deliveryCell", for: indexPath) as! DeliveryCell
        let delivery = deliveries[indexPath.row]
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "h:mm a"
        
        cell.orderLabel.text = "#\(delivery.order)"
        cell.addressLabel.text = delivery.address
        cell.dateLabel.text = dateFormatterPrint.string(from: delivery.date)
        
        if delivery.cash != 0 {
            cell.cashLabel.text = String(format: "Cash $%.2f", delivery.cash)
            cell.cashLabel.isHidden = false
        }
        else {
            cell.cashLabel.isHidden = true
        }
        
        if delivery.credit != 0 {
            cell.creditLabel.text = String(format: "Credit $%.2f", delivery.credit)
            cell.creditLabel.isHidden = false
        }
        else {
            cell.creditLabel.isHidden = true
        }
        
        if delivery.tripComp != 0 {
            cell.tripCompLabel.text = String(format: "Trip Comp $%.2f", delivery.tripComp)
            cell.tripCompLabel.isHidden = false
        }
        else {
            cell.tripCompLabel.isHidden = true
        }
        
        if delivery.payout != 0 {
            cell.payoutLabel.text = String(format: "Payout $%.2f", delivery.payout)
            cell.payoutLabel.isHidden = false
        }
        else {
            cell.payoutLabel.isHidden = true
        }
        
        cell.notesLabel.text = delivery.notes
        cell.totalExPayoutLabel.text = String(format: "$%.2f", delivery.totalExPayout)

        return cell
    }
    
    // Deletion
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let delivery = deliveries[indexPath.row]
            deliveries.remove(at: indexPath.row)
            deliveryStore.remove(delivery)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {}
    
    // MARK: - Footer
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        if deliveryStore.deliveries.isEmpty {
            let footerView = UITableViewHeaderFooterView()
            footerView.backgroundView = UIView(frame: footerView.bounds)
            footerView.backgroundView?.backgroundColor = UIColor.white
            footerView.textLabel?.text = "No deliveries."
            
            return footerView
        }
        else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return deliveryStore.deliveries.isEmpty ? 60 : 0
    }
}

// MARK: - Table View Delegate
extension DeliveriesViewController: UITableViewDelegate {}

