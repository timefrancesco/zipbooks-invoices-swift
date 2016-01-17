//
//  InvoiceTotalTC.swift
//  zipbooks-ios
//
//  Created by Francesco Pretelli on 17/01/16.
//  Copyright © 2016 Francesco Pretelli. All rights reserved.
//

import Foundation

import Foundation
import UIKit

class InvoiceTotalTC: UITableViewCell {
    @IBOutlet weak var totalLbl: UILabel!
    
    func updateData( value:String){
        totalLbl.text = "$" + value //TODO: currency
    }
}