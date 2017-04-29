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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        errorLbl.isHidden = true
        saveBtn.isEnabled = true
        activityIndicator.isHidden = true
        title = "Add"
        
        if Utility.getScreenWidth() < IPHONE_6_SCREEN_WIDTH {
            NotificationCenter.default.addObserver(self, selector: #selector(AddViewController.OnKeyboardAppear(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(AddViewController.OnKeyboardDisappear(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        title = ""
        if Utility.getScreenWidth() < IPHONE_6_SCREEN_WIDTH {
            NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
            NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        }
    }
    
    func customizeNavBar(){
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName : UIFont(name: "HelveticaNeue", size: 18)!, NSForegroundColorAttributeName : UIColor.white]
        navigationController?.navigationBar.barTintColor = Utility.getDefaultGrayColor() 
        navigationController?.navigationBar.isTranslucent = false
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func typeSelectorChanged(_ sender: AnyObject) {
        timeEntryContainer.isHidden = addTypeSelector.selectedSegmentIndex == 1
        expenseContainer.isHidden = addTypeSelector.selectedSegmentIndex == 0
    }
    
    @IBAction func onSaveBtnTouchUpInside(_ sender: AnyObject) {
        if !Connectivity.sharedInstance.isConnected(){
            handleNoConnection()
            return
        }
        
        errorLbl.isHidden = true
        saveBtn.isEnabled = false
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        if addTypeSelector.selectedSegmentIndex == 1 {
            saveExpense()
        }
        else{
            saveTimeEntry()
        }
    }
    
    func handleNoConnection(){
        errorLbl.isHidden = false
        errorLbl.text = "Not Connected"
    }
    
    
    func OnKeyboardAppear(_ notify:Notification) {
        if let dicUserInfo = notify.userInfo {
            let recKeyboardFrame:CGRect = ((dicUserInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue)!
            print(recKeyboardFrame)
            if addTypeSelector.selectedSegmentIndex == 1 {
                 let expVC = childViewControllers[0] as! AddExpenseViewController
                expVC.adjustInsetForKeyboard(recKeyboardFrame)
            }
            else{
                let timeEntryVC = childViewControllers[1] as! AddTimeEntryViewController
                timeEntryVC.adjustInsetForKeyboard(recKeyboardFrame)
            }
        }
    }
    
    func OnKeyboardDisappear(_ notify:Notification) {
        if addTypeSelector.selectedSegmentIndex == 1 {
            let expVC = childViewControllers[0] as! AddExpenseViewController
            expVC.restoreInsetForKeyboard()
        }
        else{
            let timeEntryVC = childViewControllers[1] as! AddTimeEntryViewController
            timeEntryVC.restoreInsetForKeyboard()
        }
    }
    
    @IBAction func onCancelBtnTouchUpInside(_ sender: AnyObject) {
        navigationController?.dismiss(animated: true, completion:nil)
    }

    func saveExpense(){
        let expVC = childViewControllers[0] as! AddExpenseViewController //I don't really like this way to access it, looking for a better solution
        expVC.dismissKeyboard()
        let expense = expVC.generateApiData()
        if checkExpense(expense) {
            APIservice.sharedInstance.setExpense(expense){ (data:Expense?) in
                if data == nil {
                    self.errorLbl.text = "Error saving expense, please check your internet"
                    self.errorLbl.isHidden = false
                }
                else {
                    self.dismiss(animated: true, completion: nil)
                }
                self.saveBtn.isEnabled = true
                self.activityIndicator.isHidden = true
                self.activityIndicator.stopAnimating()
            }
        }
        else {
            errorLbl.text = "Wrong input"
            errorLbl.isHidden = false
            saveBtn.isEnabled = true
            activityIndicator.isHidden = true
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
                    self.errorLbl.isHidden = false
                }
                else {
                    self.dismiss(animated: true, completion: nil)
                }
                self.saveBtn.isEnabled = true
                self.activityIndicator.isHidden = true
                self.activityIndicator.stopAnimating()
            }
        }
        else {
            errorLbl.text = "Wrong input"
            errorLbl.isHidden = false
            saveBtn.isEnabled = true
            activityIndicator.isHidden = true
        }
    }
    
    func checkTimeEntry(_ data:TimeEntryPost) -> Bool {
        if data.taskId == 0 || data.date == "" || data.duration == 0 || data.date == nil{
            return false
        }
        return true
    }
    
    func checkExpense(_ data:ExpensePost) -> Bool {
        if data.customer_id == 0 || data.date == "" || data.amount == 0 || data.date == nil{
            return false
        }
        return true
    }
    
}
