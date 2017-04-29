//
//  InvoiceTextViewTC.swift
//  zipbooks-ios
//
//  Created by Francesco Pretelli on 17/01/16.
//  Copyright © 2016 Francesco Pretelli. All rights reserved.
//

import Foundation
import UIKit

class InvoiceTextViewTC: UITableViewCell {
    
    @IBOutlet weak var textTview: UITextView!
    func updateData( _ text:String){
        textTview.text = text
    }
}
