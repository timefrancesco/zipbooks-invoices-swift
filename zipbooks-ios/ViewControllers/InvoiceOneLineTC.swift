//
//  InvoiceOneLineTC.swift
//  zipbooks-ios
//
//  Created by Francesco Pretelli on 17/01/16.
//  Copyright © 2016 Francesco Pretelli. All rights reserved.
//

import Foundation
import UIKit

class InvoiceTableCellOneLineTC: UITableViewCell {
    @IBOutlet weak var lineValue: UILabel!
    
    func updateData(_ value:String){
       lineValue.text = value
    }
}
