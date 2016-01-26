//
//  InsertViewController.swift
//  zipbooks-ios
//
//  Created by Francesco Pretelli on 27/01/16.
//  Copyright © 2016 Francesco Pretelli. All rights reserved.
//

import Foundation
import UIKit

class InsertViewController: UIViewController {

    @IBOutlet weak var addCustomerContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    @IBAction func onSaveButtonTouchUpInside(sender: AnyObject) {
         let addCustomerVC = childViewControllers[0] as! InsertNewCustomer
      
        
    }
}