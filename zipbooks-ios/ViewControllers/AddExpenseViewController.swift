//
//  AddExpenseViewController.swift
//  zipbooks-ios
//
//  Created by Francesco Pretelli on 20/01/16.
//  Copyright © 2016 Francesco Pretelli. All rights reserved.
//

import Foundation
import Foundation
import UIKit

protocol CustomerSelectionDelegate{
    func selectedCustomer(indexpathRow:Int)
}

class AddExpenseViewController: UIViewController, CustomerSelectionDelegate {

    @IBOutlet weak var selectCustomerBtn: UIButton!
    @IBOutlet weak var noteTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    
    var customers = [Customer]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        customers = DBservice.sharedInstance.getCustomersAll()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "displayCustomersSegue" {
            if let destination = segue.destinationViewController as? GenericListViewController {
               //let customers = DBservice.sharedInstance.getCustomersAll()
                let customersStr = customers.map {$0.name! as String}
                destination.populateSource(customersStr)
                destination.listSelectedDelegate = self
            }
        }
    }
    
    func selectedCustomer(indexpathRow:Int){
        selectCustomerBtn.setTitle(customers[indexpathRow].name, forState: .Normal)
    }
    
}