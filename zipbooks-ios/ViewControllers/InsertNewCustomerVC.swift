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