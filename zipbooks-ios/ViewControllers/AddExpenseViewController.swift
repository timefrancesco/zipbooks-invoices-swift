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

protocol GenericTableSelectionDelegate{
    func selectedRow(indexpathRow:Int, value:String)
}

class AddExpenseViewController: UIViewController, GenericTableSelectionDelegate {

    @IBOutlet weak var selectCustomerBtn: UIButton!
    @IBOutlet weak var noteTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    
    var customers = [Customer]()
    var selectedCustomer:Customer?
    
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
    
    func selectedRow(indexpathRow:Int, value:String){
        selectedCustomer = customers[indexpathRow]
        selectCustomerBtn.setTitle(selectedCustomer!.name, forState: .Normal)
    }
    
}