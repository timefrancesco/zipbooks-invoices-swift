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

    
    override func viewDidLoad() {
        invoiceTableView.delegate = self
        invoiceTableView.dataSource = self
        invoiceTableView.registerNib(UINib(nibName: "InvoiceOneLineTC", bundle: nil), forCellReuseIdentifier: "OneLineCell")
        invoiceTableView.registerNib(UINib(nibName: "InvoiceItemTC", bundle: nil), forCellReuseIdentifier: "ItemCell")
        
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
            break
            
        case InvoiceSection.EXPENSES.rawValue:
            break
            
        case InvoiceSection.TERMS.rawValue:
            break
            
        case InvoiceSection.NOTES.rawValue:
            break
            
        case InvoiceSection.SUBTOTAL.rawValue:
            break
            
        case InvoiceSection.TOTAL.rawValue:
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
            currentCell.updateData(currentInvoice.items[indexPath.row])
            cell = currentCell
            break
            
        case InvoiceSection.EXPENSES.rawValue:
            cell = UITableViewCell() //temp
            break
            
        case InvoiceSection.TERMS.rawValue:
            cell = UITableViewCell() //temp
            break
            
        case InvoiceSection.NOTES.rawValue:
            cell = UITableViewCell() //temp
            break
            
        case InvoiceSection.SUBTOTAL.rawValue:
            cell = UITableViewCell() //temp
            break
            
        case InvoiceSection.TOTAL.rawValue:
            cell = UITableViewCell() //temp
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
            num = currentInvoice.items.count
            break
            
        case InvoiceSection.EXPENSES.rawValue:
            //TODO: arent expenses different than items?
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
        
    }
    
}