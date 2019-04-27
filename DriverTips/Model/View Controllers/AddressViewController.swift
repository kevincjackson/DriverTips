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
        addresses = getAddresses()
        tableView.reloadData()
    }

    // MARK: - Helper Methods
    private func getAddresses() -> [String] {
        return stateController.worldState.deliveries
            .map { $0.address.trimmingCharacters(in: .whitespaces) }
            .filter { !$0.isEmpty }
            .removedDuplicates()
            .sorted()
    }
    
    // MARK: - Table Methods
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return addresses.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "addressCell", for: indexPath)
        cell.textLabel?.text = addresses[indexPath.row]
        
        return cell
    }
}
