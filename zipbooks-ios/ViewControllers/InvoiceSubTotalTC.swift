//
//  InvoiceSubTotalTC.swift
//  zipbooks-ios
//
//  Created by Francesco Pretelli on 17/01/16.
//  Copyright © 2016 Francesco Pretelli. All rights reserved.
//

import Foundation
import UIKit

class InvoiceSubTotalTC: UITableViewCell {
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var subtotalLbl: UILabel!
    
    func updateData( value:String, description:String){
        descriptionLbl.text = description
        subtotalLbl.text = "$" + value //TODO: currency
    }
}