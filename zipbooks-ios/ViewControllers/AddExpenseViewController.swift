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

    @IBOutlet weak var tableview: UITableView!
    //let datePicker:UIDatePicker = UIDatePicker()
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dateToolbar: UIToolbar!
    
    var customers = [Customer]()
    var selectedCustomer:Customer?
    var currentExpense = ExpensePost()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        tableview.tableFooterView = UIView()
        datePicker.hidden = true
        dateToolbar.hidden = true
        
        tableview.registerNib(UINib(nibName: "AddTableCell", bundle: nil), forCellReuseIdentifier: "TextFieldCell")
    }
    
    override func viewWillAppear(animated: Bool) {
        customers = DBservice.sharedInstance.getCustomersAll()
        currentExpense.date = NSDate().toString()
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
    
    @IBAction func onDateChanged(sender: AnyObject) {
        currentExpense.date = datePicker.date.toString()
        tableview.reloadData()
    }
    func selectedRow(indexpathRow:Int, value:String){
        selectedCustomer = customers[indexpathRow]
        currentExpense.customer_id = (selectedCustomer?.id)!
        tableview.reloadData()
    }
    
    @IBAction func onDoneDateSelected(sender: AnyObject) {
        datePicker.hidden = true
        dateToolbar.hidden = true
    }
    
    func dismissKeyboard(){
        UIApplication.sharedApplication().sendAction("resignFirstResponder", to:nil, from:nil, forEvent:nil)
    }
    
    func generateApiData() -> ExpensePost{
        let nameCell = tableview.cellForRowAtIndexPath(NSIndexPath(forRow: ExpenseTableRows.NAME.rawValue, inSection: 0)) as! AddTableCell
        currentExpense.name = nameCell.valueTextField.text
        
        let categoryCell = tableview.cellForRowAtIndexPath(NSIndexPath(forRow: ExpenseTableRows.CATEGORY.rawValue, inSection: 0)) as! AddTableCell
        currentExpense.category = categoryCell.valueTextField.text
        
        let notesCell = tableview.cellForRowAtIndexPath(NSIndexPath(forRow: ExpenseTableRows.NOTES.rawValue, inSection: 0)) as! AddTableCell
        currentExpense.note = notesCell.valueTextField.text
     
        let amountCell = tableview.cellForRowAtIndexPath(NSIndexPath(forRow: ExpenseTableRows.AMOUNT.rawValue, inSection: 0)) as! AddTableCell
        let amount = amountCell.valueTextField.text
        if let myNumber = NSNumberFormatter().numberFromString(amount!) {
            currentExpense.amount = myNumber.doubleValue
        } else {
            currentExpense.amount = 0
        }
        return currentExpense
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
            dismissKeyboard()
            datePicker.hidden = true
            dateToolbar.hidden = true
            performSegueWithIdentifier("DisplayCustomersSegue", sender: nil)
            break;
        case ExpenseTableRows.DATE.rawValue:
            dismissKeyboard()
            datePicker.hidden = false
            dateToolbar.hidden = false
            break;
        default:
            datePicker.hidden = true
            dateToolbar.hidden = true
            break;
        }
    }
    
   
}