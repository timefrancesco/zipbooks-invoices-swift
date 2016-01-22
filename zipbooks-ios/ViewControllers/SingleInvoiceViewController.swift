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
    case DETAILS = 0 //customer name, date
    case ITEMS = 1 //tasks
    case EXPENSES = 2
    case TERMS = 3
    case NOTES = 4
    case SUBTOTAL = 5
    case TOTAL = 6
}

class SingleInvoiceViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {

    @IBOutlet weak var invoiceTableView: UITableView!
    var currentInvoice = Invoice()
    var expenses = [Item]()
    var items = [Item]()
    
    override func viewDidLoad() {
        invoiceTableView.delegate = self
        invoiceTableView.dataSource = self
        invoiceTableView.registerNib(UINib(nibName: "InvoiceOneLineTC", bundle: nil), forCellReuseIdentifier: "OneLineCell")
        invoiceTableView.registerNib(UINib(nibName: "InvoiceItemTC", bundle: nil), forCellReuseIdentifier: "ItemCell")
        invoiceTableView.registerNib(UINib(nibName: "InvoiceTextViewTC", bundle: nil), forCellReuseIdentifier: "TextCell")
        invoiceTableView.registerNib(UINib(nibName: "InvoiceSubTotalTC", bundle: nil), forCellReuseIdentifier: "SubTotalCell")
        invoiceTableView.registerNib(UINib(nibName: "InvoiceTotalTC", bundle: nil), forCellReuseIdentifier: "TotalCell")
        
    }
    
    override func viewWillAppear(animated: Bool) {
        expenses = currentInvoice.items.filter( {$0.type == "item"}) //Apparently Expenses are marked at item?
        items = currentInvoice.items.filter( {$0.type != "item"})
        title = currentInvoice.number
    }
    
    
    
    //MARK: TableView Delegate Functions
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 7
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title = ""
        
        switch(section){
         case InvoiceSection.DETAILS.rawValue:
            title = "Details" //TODO: localization
            break
        case InvoiceSection.ITEMS.rawValue:
            title = "Items" //TODO: localization
            break
            
        case InvoiceSection.EXPENSES.rawValue:
            title = "Expenses" //TODO: localization
            break
            
        case InvoiceSection.TERMS.rawValue:
            title = "Terms" //TODO: localization
            break
            
        case InvoiceSection.NOTES.rawValue:
            title = "Notes" //TODO: localization
            break
            
        case InvoiceSection.SUBTOTAL.rawValue:
            title = "Subtotal" //TODO: localization
            break
            
        case InvoiceSection.TOTAL.rawValue:
            title = "Total" //TODO: localization
            break
            
        default:
            break
        }
        
        return title
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        var cell: AnyObject?
        
        switch(indexPath.section){
        case InvoiceSection.DETAILS.rawValue:
            let currentCell = tableView.dequeueReusableCellWithIdentifier("OneLineCell", forIndexPath: indexPath) as! InvoiceTableCellOneLineTC
             currentCell.updateData(DBservice.sharedInstance.getCustomerNameFromId(currentInvoice.customer_id))
            cell = currentCell
            break
            
        case InvoiceSection.ITEMS.rawValue:
            let currentCell = tableView.dequeueReusableCellWithIdentifier("ItemCell", forIndexPath: indexPath) as! InvoiceItemTC
            currentCell.updateData(items[indexPath.row])
            cell = currentCell
            break
            
        case InvoiceSection.EXPENSES.rawValue:
            let currentCell = tableView.dequeueReusableCellWithIdentifier("ItemCell", forIndexPath: indexPath) as! InvoiceItemTC
            currentCell.updateData(expenses[indexPath.row])
            cell = currentCell
            break
            
        case InvoiceSection.TERMS.rawValue:
           // cell = UITableViewCell()
            let currentCell = tableView.dequeueReusableCellWithIdentifier("TextCell", forIndexPath: indexPath) as! InvoiceTextViewTC
            currentCell.updateData(currentInvoice.terms!)
            cell = currentCell
            break
            
        case InvoiceSection.NOTES.rawValue:
            let currentCell = tableView.dequeueReusableCellWithIdentifier("TextCell", forIndexPath: indexPath) as! InvoiceTextViewTC
            currentCell.updateData(currentInvoice.notes!)
            cell = currentCell
            break
            
        case InvoiceSection.SUBTOTAL.rawValue:
            let currentCell = tableView.dequeueReusableCellWithIdentifier("SubTotalCell", forIndexPath: indexPath) as! InvoiceSubTotalTC
            currentCell.updateData(currentInvoice.total!, description: "Subtotal") //TODO: check taxes here
            cell = currentCell
            break
            
        case InvoiceSection.TOTAL.rawValue:
            let currentCell = tableView.dequeueReusableCellWithIdentifier("TotalCell", forIndexPath: indexPath) as! InvoiceTotalTC
            currentCell.updateData(currentInvoice.total!) 
            cell = currentCell

            break
            
        default:
            break
        }
        return cell as! UITableViewCell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var num = 1
        
        switch(section){
        case InvoiceSection.DETAILS.rawValue:
            num = 1
            break
        case InvoiceSection.ITEMS.rawValue:
            num = items.count
            break
            
        case InvoiceSection.EXPENSES.rawValue:
            num = expenses.count
            break
            
        case InvoiceSection.TERMS.rawValue:
            num = 1
            break
            
        case InvoiceSection.NOTES.rawValue:
            num = 1
            break
            
        case InvoiceSection.SUBTOTAL.rawValue:
            num = 1
            break
            
        case InvoiceSection.TOTAL.rawValue:
            num = 1
            break
            
        default:
            break
        }
        
        return num
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var num:CGFloat = 1
        
        switch(indexPath.section){
        case InvoiceSection.DETAILS.rawValue:
            num = 60
            break
        case InvoiceSection.ITEMS.rawValue:
            num = 50
            break
            
        case InvoiceSection.EXPENSES.rawValue:
            num = 50
            break
            
        case InvoiceSection.TERMS.rawValue:
            num = 120
            break
            
        case InvoiceSection.NOTES.rawValue:
            num = 120
            break
            
        case InvoiceSection.SUBTOTAL.rawValue:
            num = 44
            break
            
        case InvoiceSection.TOTAL.rawValue:
            num = 44
            break
            
        default:
            break
        }
        
        return num
    }
    
    
}