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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeNavBar()
        addTypeSelector.selectedSegmentIndex = 0
        title = "Add"
    }
    
    func customizeNavBar(){
        //1A708F
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName : UIFont(name: "HelveticaNeue-Light", size: 20)!, NSForegroundColorAttributeName : UIColor.whiteColor()]
        navigationController?.navigationBar.barTintColor = UIColor (hex: 0x1A708F)
        navigationController?.navigationBar.translucent = false
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    @IBAction func typeSelectorChanged(sender: AnyObject) {
        timeEntryContainer.hidden = addTypeSelector.selectedSegmentIndex == 1
        expenseContainer.hidden = addTypeSelector.selectedSegmentIndex == 0
    }
    
    @IBAction func onSaveBtnTouchUpInside(sender: AnyObject) {
        /*if addTypeSelector.selectedSegmentIndex == 1 {
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
        }*/
    }
    
    @IBAction func onCancelBtnTouchUpInside(sender: AnyObject) {
        navigationController?.dismissViewControllerAnimated(true, completion:nil)
    }

}