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
import ReachabilitySwift

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
        invoicesTableView.register(UINib(nibName: "InvoiceTableCell", bundle: nil), forCellReuseIdentifier: "InvoiceCell")
        setupPullToRefresh()
        if Connectivity.sharedInstance.isConnected(){
            startupUpdate()
            updateAdditionalData()
        }
        else {
            loadFromDB()
        }
        customizeNavBar()
    }
   
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        title = ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Invoices" //TODO: Localization
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    func customizeNavBar(){
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName : UIFont(name: "HelveticaNeue", size: 18)!, NSForegroundColorAttributeName : UIColor.white]
        navigationController?.navigationBar.barTintColor = Utility.getDefaultGrayColor()
        navigationController?.navigationBar.isTranslucent = false
    }
    
    func setupPullToRefresh(){
        pullToRefresh.attributedTitle = NSAttributedString(string: NSLocalizedString("Updating invoices", comment: ""))
        pullToRefresh.addTarget(self, action: #selector(InvoicesViewController.updateInvoices(_:)), for: UIControlEvents.valueChanged)
        invoicesTableView.addSubview(pullToRefresh)
    }
    
    func updateInvoices(_ sender:AnyObject?){
        
        if !Connectivity.sharedInstance.isConnected(){
            pullToRefresh.endRefreshing()
            return
        }
        
        APIservice.sharedInstance.getInvoices(){ (resultInvoices:[Invoice]?) in
            APIservice.sharedInstance.getCustomers(){ (resultCustomer:[Customer]?) in //nested since I need the customer name (invoice only has customerID)
                
                DBservice.sharedInstance.clearDB() //to clear deleted invoices from the website, there is no way to only get new invoices
                DBservice.sharedInstance.saveArray(resultInvoices!)
                self.invoices = DBservice.sharedInstance.getInvoicesAll()
                self.invoicesTableView.reloadData()
                
                DBservice.sharedInstance.saveArray(resultCustomer!)
                self.pullToRefresh.endRefreshing()
            }
        }
    }
    
    func loadFromDB(){
        invoices = DBservice.sharedInstance.getInvoicesAll()
    }
    
    func startupUpdate(){
        pullToRefresh.beginRefreshing()
        invoicesTableView.setContentOffset(CGPoint(x: 0, y: -pullToRefresh.frame.size.height), animated: true)
        updateInvoices(nil)
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "InvoiceCell", for: indexPath) as! InvoiceTableCell
        let invoice = invoices[indexPath.row]
        cell.updateData(invoice)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return invoices.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        self.performSegue(withIdentifier: "showInvoice", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showInvoice" {
            if let destination = segue.destination as? SingleInvoiceViewController {
                if let indx = invoicesTableView.indexPathForSelectedRow?.row {
                    destination.currentInvoice = invoices[indx]
                }

            }
        }
    }

}
