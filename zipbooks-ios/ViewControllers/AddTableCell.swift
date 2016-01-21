//
//  AddTableCell.swift
//  zipbooks-ios
//
//  Created by Francesco Pretelli on 22/01/16.
//  Copyright © 2016 Francesco Pretelli. All rights reserved.
//

import Foundation
import UIKit

class AddTableCell: UITableViewCell {
    @IBOutlet weak var descriptionImg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var valueTextField: UITextField!
    @IBOutlet weak var valueLbl: UILabel!
    
    func updateData(type: ExpenseTableRows, data:String?="" ){
        switch(type){
        case .CUSTOMER:
            valueTextField.hidden = true
            valueLbl.hidden = false
            valueLbl.text = data
            descriptionLbl.text = "Customer:"
        break
        case .DATE:
            valueTextField.hidden = true
            valueLbl.hidden = false
            valueLbl.text = data
            descriptionLbl.text = "Date:"
            break
        case .NOTES:
            valueTextField.hidden = false
            valueLbl.hidden = true
            descriptionLbl.text = "Notes:"
            valueTextField.keyboardType = .Default
            break
        case .AMOUNT:
            valueTextField.hidden = false
            valueLbl.hidden = true
            descriptionLbl.text = "Amount:"
            valueTextField.keyboardType = .NumberPad
            break
        case .CATEGORY:
            valueTextField.hidden = false
            valueLbl.hidden = true
            descriptionLbl.text = "Category:"
            valueTextField.keyboardType = .Default
            break
        case .NAME:
            valueTextField.hidden = false
            valueLbl.hidden = true
            descriptionLbl.text = "Name:"
            valueTextField.keyboardType = .Default
            break
            
        }
    }
}