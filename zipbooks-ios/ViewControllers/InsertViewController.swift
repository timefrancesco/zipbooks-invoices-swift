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
    case customer
    case project
    case task
}

class InsertViewController: UIViewController {

    @IBOutlet weak var addCustomerContainer: UIView!
    @IBOutlet weak var addProjectContainer: UIView!
    var insertType:InsertType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if insertType == InsertType.customer{
            addCustomerContainer.isHidden = false
            addProjectContainer.isHidden = true
            title = "New Customer"
        }
        
        if insertType == InsertType.project{
            addCustomerContainer.isHidden = true
            addProjectContainer.isHidden = false
            title = "New Project"
        }
        
        if Utility.getScreenWidth() < IPHONE_6_SCREEN_WIDTH {
            NotificationCenter.default.addObserver(self, selector: #selector(InsertViewController.OnKeyboardAppear(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(InsertViewController.OnKeyboardDisappear(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
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
   
    func OnKeyboardAppear(_ notify:Notification) {
        if let dicUserInfo = notify.userInfo {
            let recKeyboardFrame:CGRect = ((dicUserInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue)!
            adjustKeyboard(true, frame:recKeyboardFrame)
        }
    }
    
    func OnKeyboardDisappear(_ notify:Notification) {
       adjustKeyboard(false)
    }
    
    func adjustKeyboard(_ show:Bool, frame:CGRect?=nil){
        if insertType == InsertType.customer{
           let vc = childViewControllers[0] as! InsertNewCustomer
            show == true ? vc.adjustInsetForKeyboard(frame!) : vc.restoreInsetForKeyboard()
        }
    }
    
    @IBAction func OnCancelBtnTouchUpInside(_ sender: AnyObject) {
        navigationController?.dismiss(animated: true, completion:nil)
    }
    
    @IBAction func onSaveButtonTouchUpInside(_ sender: AnyObject) {
        if insertType == InsertType.customer{
            let addCustomerVC = childViewControllers[0] as! InsertNewCustomer
            let data = addCustomerVC.generateApiData()
            saveNewCustomer(data)
        }
        else if insertType == InsertType.project{
            let addProjectVC = childViewControllers[1] as! InsertNewProjectVC
            let data = addProjectVC.generateApiData()
            saveNewProject(data)
        }
    }
    
    func saveNewCustomer(_ data:CustomerPost){
        APIservice.sharedInstance.saveNewCustomer(data){ (data:Customer?) in
            if data == nil {
                //self.errorLbl.text = "Error saving customer, please check your internet"
                //self.errorLbl.hidden = false
            }
            else {
                self.dismiss(animated: true, completion: nil)
            }
            //self.saveBtn.enabled = true
            //self.activityIndicator.hidden = true
            //self.activityIndicator.stopAnimating()
        }
    }
    
    func saveNewProject(_ data:ProjectPost){
        APIservice.sharedInstance.saveNewProject(data){ (data:Project?) in
            if data == nil {
                //self.errorLbl.text = "Error saving customer, please check your internet"
                //self.errorLbl.hidden = false
            }
            else {
                self.dismiss(animated: true, completion: nil)
            }
            //self.saveBtn.enabled = true
            //self.activityIndicator.hidden = true
            //self.activityIndicator.stopAnimating()
        }
    }
}
