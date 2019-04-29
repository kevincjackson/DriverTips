//
//  HistoryViewController.swift
//  DriverTips
//
//  Created by Kevin Jackson on 4/26/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import UIKit

class HistoryViewController: UITableViewController {
    
    var stateController: StateController!
    var dates: [Date]!

    // MARK: - View Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        dates = DeliveryList(stateController.worldState.deliveries).dates
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "historyToDeliveries":
            let deliveriesVC = segue.destination as! DeliveriesViewController
            let selectedDate = dates[tableView.indexPathForSelectedRow!.row]
            deliveriesVC.stateController = stateController
            deliveriesVC.deliveriesFilter = {
                $0.filter { Calendar.current.isDate($0.date, inSameDayAs: selectedDate) }
            }
            deliveriesVC.title = selectedDate.DTformattedDate
        default:
            preconditionFailure("Unkown segue identifier.")
        }
    }
    
    // MARK: - Table
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dates.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath)
        let date = dates[indexPath.row]
        cell.textLabel?.text = date.DTformattedDate
        
        return cell
    }
}
