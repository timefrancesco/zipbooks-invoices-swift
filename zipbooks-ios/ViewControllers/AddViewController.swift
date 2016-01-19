//
//  AddViewController.swift
//  zipbooks-ios
//
//  Created by Francesco Pretelli on 20/01/16.
//  Copyright © 2016 Francesco Pretelli. All rights reserved.
//

import Foundation
import UIKit

class AddViewController: UIViewController {
    
    @IBOutlet weak var addTypeSelector: UISegmentedControl!
    
    @IBOutlet weak var timeEntryContainer: UIView!
    @IBOutlet weak var expenseContainer: UIView!
    
    @IBAction func typeSelectorChanged(sender: AnyObject) {
    }
}