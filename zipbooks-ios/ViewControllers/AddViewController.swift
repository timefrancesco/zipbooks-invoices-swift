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
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var saveBtn: UIBarButtonItem!
    @IBOutlet weak var errorLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeNavBar()
        addTypeSelector.selectedSegmentIndex = 0
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        errorLbl.hidden = true
        saveBtn.enabled = true
        activityIndicator.hidden = true
        title = "Add"
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        title = ""
    }
    
    func customizeNavBar(){
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName : UIFont(name: "HelveticaNeue-Light", size: 20)!, NSForegroundColorAttributeName : UIColor.whiteColor()]
        navigationController?.navigationBar.barTintColor = Utility.getDefaultGrayColor() 
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
        if !Reachability.isConnectedToNetwork(){
            handleNoConnection()
            return
        }
        
        errorLbl.hidden = true
        saveBtn.enabled = false
        activityIndicator.hidden = false
        activityIndicator.startAnimating()
        
        if addTypeSelector.selectedSegmentIndex == 1 {
            saveExpense()
        }
        else{
            saveTimeEntry()
        }
    }
    
    func handleNoConnection(){
        errorLbl.hidden = false
        errorLbl.text = "Not Connected"
    }
    
    @IBAction func onCancelBtnTouchUpInside(sender: AnyObject) {
        navigationController?.dismissViewControllerAnimated(true, completion:nil)
    }

    func saveExpense(){
        let expVC = childViewControllers[0] as! AddExpenseViewController //I don't really like this way to access it, looking for a better solution
        expVC.dismissKeyboard()
        let expense = expVC.generateApiData()
        if checkExpense(expense) {
            APIservice.sharedInstance.setExpense(expense){ (data:Expense?) in
                if data == nil {
                    self.errorLbl.text = "Error saving expense, please check your internet"
                    self.errorLbl.hidden = false
                }
                else {
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
                self.saveBtn.enabled = true
                self.activityIndicator.hidden = true
                self.activityIndicator.stopAnimating()
            }
        }
        else {
            errorLbl.text = "Wrong input"
            errorLbl.hidden = false
            saveBtn.enabled = true
            activityIndicator.hidden = true
        }
    }
    
    func saveTimeEntry(){
        let timeEntryVC = childViewControllers[1] as! AddTimeEntryViewController //I don't really like this way to access it, looking for a better solution
        timeEntryVC.dismissKeyboard()
        let timeEntry = timeEntryVC.generateApiData()
        if checkTimeEntry(timeEntry) {
            APIservice.sharedInstance.setTimeEntry(timeEntry){ (data:TimeEntry?) in
                if data == nil {
                    self.errorLbl.text = "Error saving timeEntry, please check your internet"
                    self.errorLbl.hidden = false
                }
                else {
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
                self.saveBtn.enabled = true
                self.activityIndicator.hidden = true
                self.activityIndicator.stopAnimating()
            }
        }
        else {
            errorLbl.text = "Wrong input"
            errorLbl.hidden = false
            saveBtn.enabled = true
            activityIndicator.hidden = true
        }
    }
    
    func checkTimeEntry(data:TimeEntryPost) -> Bool {
        if data.taskId == 0 || data.date == "" || data.duration == 0 || data.date == nil{
            return false
        }
        return true
    }
    
    func checkExpense(data:ExpensePost) -> Bool {
        if data.customer_id == 0 || data.date == "" || data.amount == 0 || data.date == nil{
            return false
        }
        return true
    }
    
}