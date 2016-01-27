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
    var insertType:InsertType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeNavBar()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if insertType == InsertType.CUSTOMER{
            addCustomerContainer.hidden = false
            title = "New Customer"
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
   
    @IBAction func OnCancelBtnTouchUpInside(sender: AnyObject) {
        navigationController?.dismissViewControllerAnimated(true, completion:nil)
    }
    
    @IBAction func onSaveButtonTouchUpInside(sender: AnyObject) {
        if insertType == InsertType.CUSTOMER{
            let addCustomerVC = childViewControllers[0] as! InsertNewCustomer
            let data = addCustomerVC.generateApiData()
            saveNewCustomer(data)
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
}