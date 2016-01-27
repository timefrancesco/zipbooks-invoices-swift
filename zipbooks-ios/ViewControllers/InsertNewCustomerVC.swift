//
//  InsertNewCustomerVC.swift
//  zipbooks-ios
//
//  Created by Francesco Pretelli on 27/01/16.
//  Copyright © 2016 Francesco Pretelli. All rights reserved.
//

import Foundation
import UIKit

enum CustomerTableRows:Int{
    case NAME = 0
    case EMAIL
    case PHONE
    case ADDRESS_1
    case ADDRESS_2
    case CITY
    case STATE
    case POSTAL_CODE
    case COUNTRY
    case END
}

class InsertNewCustomer: UIViewController,UITableViewDelegate, UITableViewDataSource {
        
    @IBOutlet weak var tableview: UITableView!
    var selectedCustomer = CustomerPost()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        tableview.dataSource = self
        tableview.tableFooterView = UIView()
        
        tableview.registerNib(UINib(nibName: "AddTableCell", bundle: nil), forCellReuseIdentifier: "TextFieldCell")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableview.reloadData()
    }
    
    func dismissKeyboard(){
        UIApplication.sharedApplication().sendAction("resignFirstResponder", to:nil, from:nil, forEvent:nil)
    }
    
    func adjustInsetForKeyboard(frame: CGRect ){
        let stateCell = tableview.cellForRowAtIndexPath(NSIndexPath(forRow: CustomerTableRows.STATE.rawValue, inSection: 0)) as! AddTableCell
        let pcodeCell = tableview.cellForRowAtIndexPath(NSIndexPath(forRow: CustomerTableRows.POSTAL_CODE.rawValue, inSection: 0)) as! AddTableCell
        let countryCell = tableview.cellForRowAtIndexPath(NSIndexPath(forRow: CustomerTableRows.COUNTRY.rawValue, inSection: 0)) as! AddTableCell
        if stateCell.valueTextField.isFirstResponder() || pcodeCell.valueTextField.isFirstResponder() || countryCell.valueTextField.isFirstResponder(){
            tableview.setContentOffset(CGPoint(x: 0, y: 150), animated: true)
        }
    }
    
    func restoreInsetForKeyboard(){
        if tableview.contentOffset.y != 0{
            tableview.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        }
    }
    
    func generateApiData() -> CustomerPost{
        for var i = 0; i < CustomerTableRows.END.rawValue; i++ {
            let cell = tableview.cellForRowAtIndexPath(NSIndexPath(forRow: i, inSection: 0)) as! AddTableCell
            switch (i) {
            case CustomerTableRows.NAME.rawValue:
                selectedCustomer.name = cell.valueTextField.text
                break
            case CustomerTableRows.EMAIL.rawValue:
                selectedCustomer.email = cell.valueTextField.text
                break
            case CustomerTableRows.PHONE.rawValue:
                selectedCustomer.phone = cell.valueTextField.text
                break
            case CustomerTableRows.ADDRESS_1.rawValue:
                selectedCustomer.address_1 = cell.valueTextField.text
                break
            case CustomerTableRows.ADDRESS_2.rawValue:
                selectedCustomer.address_2 = cell.valueTextField.text
                break
            case CustomerTableRows.CITY.rawValue:
                selectedCustomer.city = cell.valueTextField.text
                break
            case CustomerTableRows.STATE.rawValue:
                selectedCustomer.state = cell.valueTextField.text
                break
            case CustomerTableRows.POSTAL_CODE.rawValue:
                selectedCustomer.postal_code = cell.valueTextField.text
                break
            case CustomerTableRows.COUNTRY.rawValue:
                selectedCustomer.country = cell.valueTextField.text
                break
            default:
                break
            }
        }
        return selectedCustomer
    }
    
    
    //MARK: TableView Delegate Functions
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("TextFieldCell", forIndexPath: indexPath) as! AddTableCell
        cell.accessoryType = .None
        
        switch(indexPath.row){
        case CustomerTableRows.NAME.rawValue :
            cell.updateData(indexPath.row, entryType: .CUSTOMER, data: selectedCustomer.name)
            break
        case CustomerTableRows.EMAIL.rawValue :
            cell.updateData(indexPath.row, entryType: .CUSTOMER, data: selectedCustomer.email)
            break
        case CustomerTableRows.PHONE.rawValue :
            cell.updateData(indexPath.row, entryType: .CUSTOMER, data: selectedCustomer.phone)
            break
        case CustomerTableRows.ADDRESS_1.rawValue :
            cell.updateData(indexPath.row, entryType: .CUSTOMER, data: selectedCustomer.address_1)
            break
        case CustomerTableRows.ADDRESS_2.rawValue :
            cell.updateData(indexPath.row, entryType: .CUSTOMER, data: selectedCustomer.address_2)
            break
        case CustomerTableRows.CITY.rawValue :
            cell.updateData(indexPath.row, entryType: .CUSTOMER, data: selectedCustomer.city)
            break
        case CustomerTableRows.STATE.rawValue :
            cell.updateData(indexPath.row, entryType: .CUSTOMER, data: selectedCustomer.state)
            break
        case CustomerTableRows.POSTAL_CODE.rawValue :
            cell.updateData(indexPath.row, entryType: .CUSTOMER, data: selectedCustomer.postal_code)
            break
        case CustomerTableRows.COUNTRY.rawValue :
            cell.updateData(indexPath.row, entryType: .CUSTOMER, data: selectedCustomer.country)
            break
        default:
            break
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CustomerTableRows.END.rawValue
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}