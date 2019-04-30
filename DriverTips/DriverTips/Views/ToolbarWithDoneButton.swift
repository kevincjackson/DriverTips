//
//  ToolbarWithDoneButton.swift
//  DriverTips
//
//  Created by Kevin Jackson on 4/29/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import UIKit

class ToolbarWithDoneButton: UIToolbar {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init(target: Any, action: Selector) {
        self.init(frame: CGRect.zero)
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: target, action: action)
        setItems([space, done], animated: false)
        isUserInteractionEnabled = true
        sizeToFit()
    }
}
