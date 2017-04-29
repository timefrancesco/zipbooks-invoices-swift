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
    func selectedRow(_ indexpathRow:Int, value:String)
}

enum ExpenseTableRows:Int{
    case customer = 0
    case date = 1
    case amount = 2
    case name = 3
    case category = 4
    case notes = 5
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
        datePicker.isHidden = true
        dateToolbar.isHidden = true
        
        tableview.register(UINib(nibName: "AddTableCell", bundle: nil), forCellReuseIdentifier: "TextFieldCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customers = DBservice.sharedInstance.getCustomersAll()
        currentExpense.date = Date().toString()
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DisplayCustomersSegue" {
            if let destination = segue.destination as? GenericListViewController {
                let customersStr = customers.map {$0.name! as String}
                destination.populateSource(customersStr)
                destination.listSelectedDelegate = self
                destination.setViewTitle("Customers")
                destination.insertType = InsertType.customer
            }
        }
    }
    
    @IBAction func onDateChanged(_ sender: AnyObject) {
        currentExpense.date = datePicker.date.toString()
        tableview.reloadData()
    }
    
    func selectedRow(_ indexpathRow:Int, value:String){
        selectedCustomer = customers[indexpathRow]
        currentExpense.customer_id = (selectedCustomer?.id)!
        tableview.reloadData()
    }
    
    @IBAction func onDoneDateSelected(_ sender: AnyObject) {
        datePicker.isHidden = true
        dateToolbar.isHidden = true
    }
    
    func dismissKeyboard(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
    }
    
    func adjustInsetForKeyboard(_ frame: CGRect ){
        let categoryCell = tableview.cellForRow(at: IndexPath(row: ExpenseTableRows.category.rawValue, section: 0)) as! AddTableCell
        let notesCell = tableview.cellForRow(at: IndexPath(row: ExpenseTableRows.notes.rawValue, section: 0)) as! AddTableCell
        if categoryCell.valueTextField.isFirstResponder || notesCell.valueTextField.isFirstResponder{
             tableview.setContentOffset(CGPoint(x: 0, y: 100), animated: true)
        }
    }
    
    func restoreInsetForKeyboard(){
        if tableview.contentOffset.y != 0{
            tableview.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        }
    }
    
    func generateApiData() -> ExpensePost{
        let nameCell = tableview.cellForRow(at: IndexPath(row: ExpenseTableRows.name.rawValue, section: 0)) as! AddTableCell
        currentExpense.name = nameCell.valueTextField.text
        
        let categoryCell = tableview.cellForRow(at: IndexPath(row: ExpenseTableRows.category.rawValue, section: 0)) as! AddTableCell
        currentExpense.category = categoryCell.valueTextField.text
        
        let notesCell = tableview.cellForRow(at: IndexPath(row: ExpenseTableRows.notes.rawValue, section: 0)) as! AddTableCell
        currentExpense.note = notesCell.valueTextField.text
     
        let amountCell = tableview.cellForRow(at: IndexPath(row: ExpenseTableRows.amount.rawValue, section: 0)) as! AddTableCell
        currentExpense.amount = (amountCell.valueTextField.text?.toDouble())!
        
        return currentExpense
    }
    
    //MARK: TableView Delegate Functions
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldCell", for: indexPath) as! AddTableCell
        
        switch(indexPath.row){
        case ExpenseTableRows.customer.rawValue :
             cell.accessoryType = .disclosureIndicator
             if selectedCustomer == nil{
                cell.updateData(ExpenseTableRows.customer.rawValue, entryType: .expense, data: "")
             }
             else{
                cell.updateData(ExpenseTableRows.customer.rawValue, entryType: .expense, data: selectedCustomer?.name)
             }
            break;
        case ExpenseTableRows.date.rawValue:
            cell.accessoryType = .none
            cell.updateData(ExpenseTableRows.date.rawValue,  entryType: .expense, data: currentExpense.date)
            break;
        default:
            cell.accessoryType = .none
            cell.updateData(indexPath.row, entryType: .expense )
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
        switch(indexPath.row){
        case ExpenseTableRows.customer.rawValue:
            dismissKeyboard()
            datePicker.isHidden = true
            dateToolbar.isHidden = true
            performSegue(withIdentifier: "DisplayCustomersSegue", sender: nil)
            break;
        case ExpenseTableRows.date.rawValue:
            dismissKeyboard()
            datePicker.isHidden = false
            dateToolbar.isHidden = false
            break;
        default:
            datePicker.isHidden = true
            dateToolbar.isHidden = true
            break;
        }
    }
    
   
}
