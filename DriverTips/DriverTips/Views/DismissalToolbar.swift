//
//  DismissalToolbar.swift
//  DriverTips
//
//  Created by Kevin Jackson on 5/14/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import UIKit

class DismissalToolbar: UIControl {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        if frame == CGRect.zero {
            super.init(frame: CGRect(x: 0, y: 0, width: 316, height: 44))
        }
        else {
            super.init(frame: frame)
        }
        commonInit()
    }
    
    private func commonInit() {
        
        // Setup Toolbar
        let toolbar = UIToolbar()
        
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(doneButtonPressed(_:))
        )
        
        let space = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        
        toolbar.setItems([space, doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        toolbar.sizeToFit()
        
        // Add Toolbar
        addSubview(toolbar)
    }
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        sendActions(for: .touchUpInside)
    }
}
