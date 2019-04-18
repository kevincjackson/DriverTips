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
    
    var deliveryStore: DeliveryStore!
    
    //MARK: - View Life Cycle`
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
    }

    // MARK: - Target-Actions
    @IBAction func editButtonPressed(_ sender: UIButton) {
        if tableView.isEditing {
            sender.setTitle("Edit", for: .normal)
            tableView.setEditing(false, animated: true)
        }
        else {
            sender.setTitle("Done", for: .normal)
            tableView.setEditing(true, animated: true)
        }
    }
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        let newDelivery = deliveryStore.createDelivery()
        guard let row = deliveryStore.all.firstIndex(of: newDelivery) else {
           return
        }
        let indexPath = IndexPath(row: row, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        tableView.footerView(forSection: 0)?.textLabel!.text = ""
    }
    
}

// MARK: - Table View DataSource
extension DeliveriesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deliveryStore.all.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "deliveryCell", for: indexPath) as! DeliveryCell
        let delivery = deliveryStore.all[indexPath.row]
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "h:mm a"
        
        cell.orderLabel.text = "#\(delivery.order)"
        cell.addressLabel.text = delivery.address
        cell.dateLabel.text = dateFormatterPrint.string(from: delivery.date)
        cell.cashLabel.text = String(format: "Cash $%.2f", delivery.cash)
        cell.creditLabel.text = String(format: "Credit $%.2f", delivery.credit)
        cell.tripCompLabel.text = String(format: "Trip Comp $%.2f", delivery.tripComp)
        cell.payoutLabel.text = delivery.payout != 0 ? String(format: "Payout $%.2f", delivery.payout) : ""
        cell.notesLabel.text = delivery.notes

        return cell
    }
    
    // Deletion
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let delivery = deliveryStore.all[indexPath.row]
            deliveryStore.deleteDelivery(delivery)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        deliveryStore.moveDelivery(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
    // MARK: - Footer
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        if deliveryStore.all.isEmpty {
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
        print("heightForFooterInSection")
        return deliveryStore.all.isEmpty ? 60 : 0
    }
}

// MARK: - Table View Delegate
extension DeliveriesViewController: UITableViewDelegate {

}

