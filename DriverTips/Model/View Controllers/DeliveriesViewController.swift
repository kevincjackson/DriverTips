//
//  ViewController.swift
//  DriverTips
//
//  Created by Kevin Jackson on 4/13/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import UIKit

class DeliveriesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var stateController: StateController!
    var deliveries = [Delivery]() {
        didSet {
            hudVC!.deliveries = deliveries
            hudVC!.updateHUD()
        }
    }
    var deliveriesFilter: ([Delivery]) -> [Delivery] = {
        return DeliveryList($0).filteredForToday.deliveries
    }
    var hudVC: HUDViewController?
    
    //MARK: - View Life Cycle`
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        deliveries = deliveriesFilter(stateController.worldState.deliveries)
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
            let row = tableView.indexPathForSelectedRow!.row
            editVC.isNewDelivery = false
            editVC.delivery = deliveries[row]
        case "gotoHUD":
            let localHudVC = segue.destination as! HUDViewController
            hudVC = localHudVC
            hudVC!.deliveries = deliveries
        default:
            preconditionFailure("Unknown segue identifier.")
        }
    }
    
    @IBAction func cancelDelivery(_ segue: UIStoryboardSegue) {}

    @IBAction func saveDelivery(_ segue: UIStoryboardSegue) {
        let editVC = segue.source as! EditDeliveryViewController
        if let delivery = editVC.delivery {
            if editVC.isNewDelivery {
                stateController.add(delivery)
            }
            else {
                stateController.update(delivery)
            }
        }
    }
}

// MARK: - Table View DataSource
extension DeliveriesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deliveries.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "deliveryCell", for: indexPath) as! DeliveryCell
        let delivery = deliveries[indexPath.row]
        
        cell.orderLabel.text = "#\(delivery.order)"
        cell.addressLabel.text = delivery.address
        cell.dateLabel.text = delivery.date.DTformattedDateAndTime
        
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


        return cell
    }
    
    // Deletion
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let delivery = deliveries[indexPath.row]
            deliveries.remove(at: indexPath.row)
            stateController.remove(delivery)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {}
    
    // MARK: - Footer
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        if deliveries.isEmpty {
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
        return deliveries.isEmpty ? 60 : 0
    }
}
