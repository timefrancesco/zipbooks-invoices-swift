//
//  InsertNewProjectVC.swift
//  zipbooks-ios
//
//  Created by Francesco Pretelli on 29/01/16.
//  Copyright © 2016 Francesco Pretelli. All rights reserved.
//

import Foundation
import UIKit

enum ProjectTableRows:Int{
    case CUSTOMER = 0
    case NAME
    case HOURLY_RATE
    case DESCRIPTION
    case END
}

class InsertNewProjectVC: UIViewController,UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableview: UITableView!
    var project = ProjectPost()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        tableview.dataSource = self
        tableview.tableFooterView = UIView()
        
        tableview.registerNib(UINib(nibName: "AddTableCell", bundle: nil), forCellReuseIdentifier: "TextFieldCell")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableview.reloadData()
    }
    
    func dismissKeyboard(){
        UIApplication.sharedApplication().sendAction("resignFirstResponder", to:nil, from:nil, forEvent:nil)
    }
    
    func generateApiData() -> ProjectPost{
        for var i = 0; i < ProjectTableRows.END.rawValue; i++ {
            let cell = tableview.cellForRowAtIndexPath(NSIndexPath(forRow: i, inSection: 0)) as! AddTableCell
            switch (i) {
            case ProjectTableRows.CUSTOMER.rawValue:
                break
            case ProjectTableRows.NAME.rawValue:
                project.name = cell.valueTextField.text
                break
            case ProjectTableRows.HOURLY_RATE.rawValue:
                project.hourly_rate = (cell.valueTextField.text?.toDouble())!
                break
            case ProjectTableRows.DESCRIPTION.rawValue:
                project.project_description = cell.valueTextField.text
                break
            default:
                break
            }
        }
        return project
    }
    
    
    //MARK: TableView Delegate Functions
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("TextFieldCell", forIndexPath: indexPath) as! AddTableCell
        cell.accessoryType = .None
        
        switch(indexPath.row){
        case ProjectTableRows.CUSTOMER.rawValue :
            cell.updateData(indexPath.row, entryType: .PROJECT, data: project.customer_id == 0 ? "" : DBservice.sharedInstance.getCustomerNameFromId(project.customer_id))
            break
        case ProjectTableRows.NAME.rawValue :
            cell.updateData(indexPath.row, entryType: .PROJECT, data: project.name)
            break
        case ProjectTableRows.HOURLY_RATE.rawValue :
            cell.updateData(indexPath.row, entryType: .PROJECT, data: String(project.hourly_rate))
            break
        case ProjectTableRows.DESCRIPTION.rawValue :
            cell.updateData(indexPath.row, entryType: .PROJECT, data: project.project_description)
            break
        default:
            break
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProjectTableRows.END.rawValue
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}