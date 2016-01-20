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
        timeEntryContainer.hidden = true
        
    }
    @IBAction func onSaveBtnTouchUpInside(sender: AnyObject) {
       let expVC = childViewControllers[0] as! AddExpenseViewController //I don't really like this way to access it, looking for a better solution
        if expVC.amountTextField.text != "" && expVC.selectedCustomer != nil {
            let currentExpense = ExpensePost()
            currentExpense.amount = Int(expVC.amountTextField.text!)!
            currentExpense.name = expVC.nameTextField.text
            currentExpense.note = expVC.noteTextField.text
            currentExpense.date = expVC.dateTextField.text
            currentExpense.category = expVC.categoryTextField.text
            currentExpense.customer_id = (expVC.selectedCustomer?.id)!
            
            
            APIservice.sharedInstance.setExpense(currentExpense){ (data:Expense?) in
                if data == nil {
                    //error
                }
            }
        }
 
    }
    
    @IBAction func onCancelBtnTouchUpInside(sender: AnyObject) {
        navigationController?.dismissViewControllerAnimated(true, completion:nil)
    }

}