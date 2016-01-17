//
//  InvoiceItemTC.swift
//  zipbooks-ios
//
//  Created by Francesco Pretelli on 17/01/16.
//  Copyright © 2016 Francesco Pretelli. All rights reserved.
//

import Foundation
import UIKit

class InvoiceItemTC: UITableViewCell {
    @IBOutlet weak var totalPriceLbl: UILabel!
    @IBOutlet weak var notesLbl: UILabel!
    @IBOutlet weak var taskLbl: UILabel!
    @IBOutlet weak var quantityLbl: UILabel!
    
    func updateData(value:Item){
        totalPriceLbl.text = "$" + Utility.calculateTotal(value.quantity!, rate: value.rate!)
        notesLbl.text = value.notes
        taskLbl.text = value.name
        quantityLbl.text = value.quantity
        
        print (value.type)
    }
}