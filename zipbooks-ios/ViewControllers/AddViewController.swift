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
    
    @IBOutlet weak var errorLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeNavBar()
        addTypeSelector.selectedSegmentIndex = 0
        title = "Add"
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        errorLbl.hidden = true
        
    }
    
    func customizeNavBar(){
        //1A708F
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName : UIFont(name: "HelveticaNeue-Light", size: 20)!, NSForegroundColorAttributeName : UIColor.whiteColor()]
        navigationController?.navigationBar.barTintColor = UIColor (hex: 0x3D3D3D)
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
        self.errorLbl.hidden = true
        
        if addTypeSelector.selectedSegmentIndex == 1 {
            let expVC = childViewControllers[0] as! AddExpenseViewController //I don't really like this way to access it, looking for a better solution
            expVC.dismissKeyboard()
            let expense = expVC.generateApiData()
            if checkData(expense) {
                APIservice.sharedInstance.setExpense(expense){ (data:Expense?) in
                    if data == nil {
                        self.errorLbl.text = "Error saving expense, please check your internet"
                        self.errorLbl.hidden = false
                    }
                    else {
                        self.dismissViewControllerAnimated(true, completion: nil)
                    }
                }
            }
            else {
                self.errorLbl.text = "Wrong input"
                self.errorLbl.hidden = false
            }
        }
    }
    
    @IBAction func onCancelBtnTouchUpInside(sender: AnyObject) {
        navigationController?.dismissViewControllerAnimated(true, completion:nil)
    }


    
    func checkData(data:ExpensePost) -> Bool {
        if data.customer_id == 0 || data.date == "" || data.amount == 0 || data.date == nil{
            return false
        }
        return true
    }
    
}