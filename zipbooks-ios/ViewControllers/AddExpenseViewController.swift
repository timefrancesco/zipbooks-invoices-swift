//
//  AddExpenseViewController.swift
//  zipbooks-ios
//
//  Created by Francesco Pretelli on 20/01/16.
//  Copyright © 2016 Francesco Pretelli. All rights reserved.
//

import Foundation
import Foundation
import UIKit

protocol GenericTableSelectionDelegate{
    func selectedRow(indexpathRow:Int, value:String)
}

enum ExpenseTableRows:Int{
    case CUSTOMER = 0
    case DATE = 1
    case AMOUNT = 2
    case NAME = 3
    case CATEGORY = 4
    case NOTES = 5
}

class AddExpenseViewController: UIViewController, GenericTableSelectionDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableview: UITableView!/*
    @IBOutlet weak var selectCustomerBtn: UIButton!
    @IBOutlet weak var noteTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!*/
    
    var customers = [Customer]()
    var selectedCustomer:Customer?
    var currentExpense = ExpensePost()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        tableview.tableFooterView = UIView()
        tableview.registerNib(UINib(nibName: "AddTableCell", bundle: nil), forCellReuseIdentifier: "TextFieldCell")
    }
    
    override func viewWillAppear(animated: Bool) {
        customers = DBservice.sharedInstance.getCustomersAll()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "DisplayCustomersSegue" {
            if let destination = segue.destinationViewController as? GenericListViewController {
                let customersStr = customers.map {$0.name! as String}
                destination.populateSource(customersStr)
                destination.listSelectedDelegate = self
            }
        }
    }
    
    func selectedRow(indexpathRow:Int, value:String){
        selectedCustomer = customers[indexpathRow]
        tableview.reloadData()
    }
    
    
    //MARK: TableView Delegate Functions
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{

        let cell = tableView.dequeueReusableCellWithIdentifier("TextFieldCell", forIndexPath: indexPath) as! AddTableCell
       
        
        switch(indexPath.row){
        case ExpenseTableRows.CUSTOMER.rawValue :
             cell.accessoryType = .DisclosureIndicator
             if selectedCustomer == nil{
                cell.updateData(.CUSTOMER, data: "")
             }
             else{
                cell.updateData(.CUSTOMER, data: selectedCustomer?.name)
             }
            break;
        case ExpenseTableRows.DATE.rawValue:
            cell.accessoryType = .None
            cell.updateData(.DATE, data: currentExpense.date)
            break;
        default:
            cell.accessoryType = .None
            cell.updateData(ExpenseTableRows(rawValue: indexPath.row)!, data: currentExpense.date)
            break
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        switch(indexPath.row){
        case ExpenseTableRows.CUSTOMER.rawValue:
            performSegueWithIdentifier("DisplayCustomersSegue", sender: nil)
            break;
        case ExpenseTableRows.DATE.rawValue:
            break;
        default:
            break;
        }
    }
    
   
}