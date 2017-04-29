//
//  SingleInvoiceViewController.swift
//  zipbooks-ios
//
//  Created by Francesco Pretelli on 15/01/16.
//  Copyright © 2016 Francesco Pretelli. All rights reserved.
//

import Foundation
import UIKit

enum InvoiceSection:Int{
    case details = 0 //customer name, date
    case items = 1 //tasks
    case expenses = 2
    case terms = 3
    case notes = 4
    case subtotal = 5
    case total = 6
}

class SingleInvoiceViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {

    @IBOutlet weak var invoiceTableView: UITableView!
    var currentInvoice = Invoice()
    var expenses = [Item]()
    var items = [Item]()
    
    override func viewDidLoad() {
        invoiceTableView.delegate = self
        invoiceTableView.dataSource = self
        invoiceTableView.tableFooterView = UIView()
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName : UIFont(name: "HelveticaNeue", size: 18)!, NSForegroundColorAttributeName : UIColor.white]
        navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        expenses = currentInvoice.items.filter( {$0.type == "item"}) //Apparently Expenses are marked at item?
        items = currentInvoice.items.filter( {$0.type != "item"})
        title = currentInvoice.number
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    
    //MARK: TableView Delegate Functions
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title = ""
        
        switch(section){
         case InvoiceSection.details.rawValue:
            title = "Details" //TODO: localization
            break
        case InvoiceSection.items.rawValue:
            title = "Items" //TODO: localization
            break
            
        case InvoiceSection.expenses.rawValue:
            title = "Expenses" //TODO: localization
            break
            
        case InvoiceSection.terms.rawValue:
            title = "Terms" //TODO: localization
            break
            
        case InvoiceSection.notes.rawValue:
            title = "Notes" //TODO: localization
            break
            
        case InvoiceSection.subtotal.rawValue:
            title = "Subtotal" //TODO: localization
            break
            
        case InvoiceSection.total.rawValue:
            title = "Total" //TODO: localization
            break
            
        default:
            break
        }
        
        return title
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        var cell: AnyObject?
        
        switch(indexPath.section){
        case InvoiceSection.details.rawValue:
            let currentCell = tableView.dequeueReusableCell(withIdentifier: "CustomerCellSB", for: indexPath) as! InvoiceTableCellOneLineTC
             currentCell.updateData(DBservice.sharedInstance.getCustomerNameFromId(currentInvoice.customer_id))
            cell = currentCell
            break
            
        case InvoiceSection.items.rawValue:
            let currentCell = tableView.dequeueReusableCell(withIdentifier: "ItemCellSB", for: indexPath) as! InvoiceItemTC
            currentCell.updateData(items[indexPath.row])
            cell = currentCell
            break
            
        case InvoiceSection.expenses.rawValue:
            let currentCell = tableView.dequeueReusableCell(withIdentifier: "ItemCellSB", for: indexPath) as! InvoiceItemTC
            currentCell.updateData(expenses[indexPath.row])
            cell = currentCell
            break
            
        case InvoiceSection.terms.rawValue:
           // cell = UITableViewCell()
            let currentCell = tableView.dequeueReusableCell(withIdentifier: "TextCellSB", for: indexPath) as! InvoiceTextViewTC
            currentCell.updateData(currentInvoice.terms!)
            cell = currentCell
            break
            
        case InvoiceSection.notes.rawValue:
            let currentCell = tableView.dequeueReusableCell(withIdentifier: "TextCellSB", for: indexPath) as! InvoiceTextViewTC
            currentCell.updateData(currentInvoice.notes!)
            cell = currentCell
            break
            
        case InvoiceSection.subtotal.rawValue:
            let currentCell = tableView.dequeueReusableCell(withIdentifier: "SubTotalCellSB", for: indexPath) as! InvoiceSubTotalTC
            currentCell.updateData(currentInvoice.total!, description: "Subtotal") //TODO: check taxes here
            cell = currentCell
            break
            
        case InvoiceSection.total.rawValue:
            let currentCell = tableView.dequeueReusableCell(withIdentifier: "TotalCellSB", for: indexPath) as! InvoiceTotalTC
            currentCell.updateData(currentInvoice.total!) 
            cell = currentCell

            break
            
        default:
            break
        }
        return cell as! UITableViewCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var num = 1
        
        switch(section){
        case InvoiceSection.details.rawValue:
            num = 1
            break
        case InvoiceSection.items.rawValue:
            num = items.count
            break
            
        case InvoiceSection.expenses.rawValue:
            num = expenses.count
            break
            
        case InvoiceSection.terms.rawValue:
            num = 1
            break
            
        case InvoiceSection.notes.rawValue:
            num = 1
            break
            
        case InvoiceSection.subtotal.rawValue:
            num = 1
            break
            
        case InvoiceSection.total.rawValue:
            num = 1
            break
            
        default:
            break
        }
        
        return num
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var num:CGFloat = 1
        
        switch(indexPath.section){
        case InvoiceSection.details.rawValue:
            num = 50
            break
        case InvoiceSection.items.rawValue:
            num = 50
            break
            
        case InvoiceSection.expenses.rawValue:
            num = 50
            break
            
        case InvoiceSection.terms.rawValue:
            num = 120
            break
            
        case InvoiceSection.notes.rawValue:
            num = 120
            break
            
        case InvoiceSection.subtotal.rawValue:
            num = 44
            break
            
        case InvoiceSection.total.rawValue:
            num = 44
            break
            
        default:
            break
        }
        
        return num
    }
    
    
}
