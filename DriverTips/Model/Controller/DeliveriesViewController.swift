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
    }
    
}

// MARK: - Table View DataSource
extension DeliveriesViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deliveryStore.all.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "deliveryCell", for: indexPath)
        let delivery = deliveryStore.all[indexPath.row]
        
        cell.textLabel?.text = delivery.address
        cell.detailTextLabel?.text = String(delivery.cash)

        return cell
    }
    
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
    
}

// MARK: - Table View Delegate
extension DeliveriesViewController: UITableViewDelegate {

}

