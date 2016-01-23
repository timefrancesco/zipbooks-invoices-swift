//
//  InvoicesViewController.swift
//  zipbooks-ios
//
//  Created by Francesco Pretelli on 12/01/16.
//  Copyright © 2016 Francesco Pretelli. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class InvoicesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {

    @IBOutlet weak var invoicesTableView: UITableView!
    var pullToRefresh = UIRefreshControl()
    var invoices:[Invoice] = [Invoice]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //print(  Realm.Configuration.defaultConfiguration.path)
        invoicesTableView.delegate = self
        invoicesTableView.dataSource = self
        invoicesTableView.tableFooterView = UIView()
        invoicesTableView.registerNib(UINib(nibName: "InvoiceTableCell", bundle: nil), forCellReuseIdentifier: "InvoiceCell")
        setupPullToRefresh()
        updateInvoices(nil)
        updateAdditionalData()
        customizeNavBar()
    }
   
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        title = ""
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        title = "Invoices" //TODO: Localization
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    func customizeNavBar(){
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName : UIFont(name: "HelveticaNeue", size: 18)!, NSForegroundColorAttributeName : UIColor.whiteColor()]
        navigationController?.navigationBar.barTintColor = Utility.getDefaultGrayColor()
        navigationController?.navigationBar.translucent = false
    }
    
    func setupPullToRefresh(){
        pullToRefresh.attributedTitle = NSAttributedString(string: NSLocalizedString("Updating invoices", comment: ""))
        pullToRefresh.addTarget(self, action: "updateInvoices:", forControlEvents: UIControlEvents.ValueChanged)
        invoicesTableView.addSubview(pullToRefresh)
    }
    
    func updateInvoices(sender:AnyObject?){
        APIservice.sharedInstance.getInvoices(){ (resultInvoices:[Invoice]?) in
            APIservice.sharedInstance.getCustomers(){ (resultCustomer:[Customer]?) in //nested since I need the customer name (invoice only has customerID)
                
                DBservice.sharedInstance.saveArray(resultInvoices!)
                self.invoices = DBservice.sharedInstance.getArray(returnType: Invoice.self)
                self.invoicesTableView.reloadData()
                
                DBservice.sharedInstance.saveArray(resultCustomer!)
            }
        }
    }
    
    func updateAdditionalData(){
        APIservice.sharedInstance.getProjects(){ (result:[Project]?) in
            DBservice.sharedInstance.saveArray(result!)
        }
        
        APIservice.sharedInstance.getExpenses(){ (result:[Expense]?) in
            DBservice.sharedInstance.saveArray(result!)
        }
        
        APIservice.sharedInstance.getTasks(){ (result:[Task]?) in
            DBservice.sharedInstance.saveArray(result!)
        }
        
        APIservice.sharedInstance.getTimeEntries(){ (result:[TimeEntry]?) in
            DBservice.sharedInstance.saveArray(result!)
        }
    }
    
    
    //MARK: TableView Delegate Functions
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("InvoiceCell", forIndexPath: indexPath) as! InvoiceTableCell
        let invoice = invoices[indexPath.row]
        cell.updateData(invoice)
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return invoices.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        self.performSegueWithIdentifier("showInvoice", sender: self)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showInvoice" {
            if let destination = segue.destinationViewController as? SingleInvoiceViewController {
                if let indx = invoicesTableView.indexPathForSelectedRow?.row {
                    destination.currentInvoice = invoices[indx]
                }

            }
        }
    }

}