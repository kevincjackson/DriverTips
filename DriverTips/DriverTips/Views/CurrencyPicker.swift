//
//  CurrencyPicker.swift
//  CurrencyPicker
//
//  Created by Kevin Jackson on 5/13/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import UIKit

class CurrencyPicker: UIControl {
    
    // MARK: - Public API
    // Output
    var selectedAmount: Double = 0 {
        didSet { sendActions(for: .valueChanged) }
    }
    
    // Input
    var maximumAmount: Int = 300 {
        didSet {
            dataDelegate.setDollarOptions(min: minimumAmount, max: maximumAmount)
            pickerView.reloadAllComponents()
        }
    }

    func set(amount: Double, animated: Bool) {
        
        if amount > Double(maximumAmount) {
            assertionFailure("CurrencyPicker amount out of range.")
            return
        }
        
        // Update Picker
        let dollarRow = Int(amount)
        let centRow = Int(amount * 100) % 100
        pickerView.selectRow(dollarRow, inComponent: 1, animated: animated)
        pickerView.selectRow(centRow, inComponent: 3, animated: animated)
        
        // Update Property
        selectedAmount = amount
    }
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: CGRectForStandardPicker)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    // MARK: - Private
    private let CGRectForStandardPicker = CGRect(x: 0, y: 0, width: 320, height: 216)
    @objc private var dataDelegate: CurrencyPickerDataDelegate!
    private let minimumAmount: Int = 0
    private var observation: NSKeyValueObservation?
    private let pickerView = UIPickerView()

    private func commonInit() {
        
        // Setup View
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(pickerView)
        
        // Setup Constraints
        NSLayoutConstraint.activate([
            pickerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            pickerView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            pickerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])
        
        // Setup Datasource
        dataDelegate = CurrencyPickerDataDelegate()
        pickerView.dataSource = dataDelegate
        dataDelegate.setDollarOptions(min: minimumAmount, max: maximumAmount)
        
        // Setup Delegate
        pickerView.delegate = dataDelegate
        observation = dataDelegate.observe(
            \CurrencyPickerDataDelegate.selectedAmount,
            options: .new,
            changeHandler: { [weak self] (_, change) in
                self?.selectedAmount = change.newValue!
            }
        )
    }
}
