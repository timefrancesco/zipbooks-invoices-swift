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
       invoiceTableView.registerNib(UINib(nibName: "InvoiceOneLineTC", bundle: nil), forCellReuseIdentifier: "OneLine")
        
    }
    
    //MARK: TableView Delegate Functions
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 7
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("OneLine", forIndexPath: indexPath) as! InvoiceTableCellOneLineTC
       // cell.updateData(invoice)
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        
    }
    
}