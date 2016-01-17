//
//  InvoiceTableCell.swift
//  zipbooks-ios
//
//  Created by Francesco Pretelli on 12/01/16.
//  Copyright © 2016 Francesco Pretelli. All rights reserved.
//

import Foundation
import UIKit

class InvoiceTableCell: UITableViewCell {

    @IBOutlet weak var customerName: UILabel!
    @IBOutlet weak var invoiceNumber: UILabel!
    @IBOutlet weak var invoiceDate: UILabel!
    @IBOutlet weak var invoiceAmount: UILabel!
    
    func updateData(invoice:Invoice){
        customerName.text = DBservice.sharedInstance.getCustomerNameFromId(invoice.customer_id)
        invoiceAmount.text = "$" + invoice.total!
        invoiceDate.text = invoice.date
        invoiceNumber.text = invoice.number
    }
}