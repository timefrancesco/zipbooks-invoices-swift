//
//  InsertViewController.swift
//  zipbooks-ios
//
//  Created by Francesco Pretelli on 27/01/16.
//  Copyright © 2016 Francesco Pretelli. All rights reserved.
//

import Foundation
import UIKit

enum InsertType{
    case CUSTOMER
    case PROJECT
    case TASK
}

class InsertViewController: UIViewController {

    @IBOutlet weak var addCustomerContainer: UIView!
    @IBOutlet weak var addProjectContainer: UIView!
    var insertType:InsertType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeNavBar()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if insertType == InsertType.CUSTOMER{
            addCustomerContainer.hidden = false
            addProjectContainer.hidden = true
            title = "New Customer"
        }
        
        if insertType == InsertType.PROJECT{
            addCustomerContainer.hidden = true
            addProjectContainer.hidden = false
            title = "New Project"
        }
        
        if Utility.getScreenWidth() < IPHONE_6_SCREEN_WIDTH {
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "OnKeyboardAppear:", name: UIKeyboardWillShowNotification, object: nil)
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "OnKeyboardDisappear:", name: UIKeyboardWillHideNotification, object: nil)
        }
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        title = ""
        if Utility.getScreenWidth() < IPHONE_6_SCREEN_WIDTH {
            NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
            NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
        }
    }
    
    func customizeNavBar(){
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName : UIFont(name: "HelveticaNeue", size: 18)!, NSForegroundColorAttributeName : UIColor.whiteColor()]
        navigationController?.navigationBar.barTintColor = Utility.getDefaultGrayColor()
        navigationController?.navigationBar.translucent = false
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
   
    func OnKeyboardAppear(notify:NSNotification) {
        if let dicUserInfo = notify.userInfo {
            let recKeyboardFrame:CGRect = ((dicUserInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.CGRectValue())!
            adjustKeyboard(true, frame:recKeyboardFrame)
        }
    }
    
    func OnKeyboardDisappear(notify:NSNotification) {
       adjustKeyboard(false)
    }
    
    func adjustKeyboard(show:Bool, frame:CGRect?=nil){
        if insertType == InsertType.CUSTOMER{
           let vc = childViewControllers[0] as! InsertNewCustomer
            show == true ? vc.adjustInsetForKeyboard(frame!) : vc.restoreInsetForKeyboard()
        }
    }
    
    @IBAction func OnCancelBtnTouchUpInside(sender: AnyObject) {
        navigationController?.dismissViewControllerAnimated(true, completion:nil)
    }
    
    @IBAction func onSaveButtonTouchUpInside(sender: AnyObject) {
        if insertType == InsertType.CUSTOMER{
            let addCustomerVC = childViewControllers[0] as! InsertNewCustomer
            let data = addCustomerVC.generateApiData()
            saveNewCustomer(data)
        }
        else if insertType == InsertType.PROJECT{
            let addProjectVC = childViewControllers[1] as! InsertNewProjectVC
            let data = addProjectVC.generateApiData()
            saveNewProject(data)
        }
    }
    
    func saveNewCustomer(data:CustomerPost){
        APIservice.sharedInstance.saveNewCustomer(data){ (data:Customer?) in
            if data == nil {
                //self.errorLbl.text = "Error saving customer, please check your internet"
                //self.errorLbl.hidden = false
            }
            else {
                self.dismissViewControllerAnimated(true, completion: nil)
            }
            //self.saveBtn.enabled = true
            //self.activityIndicator.hidden = true
            //self.activityIndicator.stopAnimating()
        }
    }
    
    func saveNewProject(data:ProjectPost){
        APIservice.sharedInstance.saveNewProject(data){ (data:Project?) in
            if data == nil {
                //self.errorLbl.text = "Error saving customer, please check your internet"
                //self.errorLbl.hidden = false
            }
            else {
                self.dismissViewControllerAnimated(true, completion: nil)
            }
            //self.saveBtn.enabled = true
            //self.activityIndicator.hidden = true
            //self.activityIndicator.stopAnimating()
        }
    }
}