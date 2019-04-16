//
//  DeliveryCellTableViewCell.swift
//  DriverTips
//
//  Created by Kevin Jackson on 4/15/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import UIKit

class DeliveryCell: UITableViewCell {
    
    @IBOutlet weak var orderLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var cashLabel: UILabel!
    @IBOutlet weak var creditLabel: UILabel!
    @IBOutlet weak var tripCompLabel: UILabel!
    @IBOutlet weak var payoutLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
