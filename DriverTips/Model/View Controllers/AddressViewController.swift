//
//  AddressViewController.swift
//  DriverTips
//
//  Created by Kevin Jackson on 4/26/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import UIKit

class AddressViewController: UITableViewController {
    
    var stateController: StateController!
    var addresses: [String]!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        addresses = DeliveryList(stateController.worldState.deliveries).addresses
        tableView.reloadData()
    }
     
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "addressesToDeliveries":
            let addressesVC = segue.destination as! DeliveriesViewController
            let selectedAddress = addresses[tableView.indexPathForSelectedRow!.row]
            addressesVC.stateController = stateController
            addressesVC.deliveriesFilter = { $0.filter { $0.address == selectedAddress } }
        default:
            preconditionFailure("Unknown segue identifier.")
        }
    }

    // MARK: - Table Methods
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addresses.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "addressCell", for: indexPath)
        cell.textLabel?.text = addresses[indexPath.row]
        
        return cell
    }
}
