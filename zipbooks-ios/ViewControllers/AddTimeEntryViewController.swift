//
//  AddTimeEntryViewController.swift
//  zipbooks-ios
//
//  Created by Francesco Pretelli on 20/01/16.
//  Copyright © 2016 Francesco Pretelli. All rights reserved.
//

import Foundation
import Foundation
import UIKit

enum TimeEntryTableRows:Int{
    case PROJECT = 0
    case TASK = 1
    case HOURS = 2
    case NOTES = 3
    case DATE = 4
}

enum TableKind{
    case PROJECT
    case TASK
}

class AddTimeEntryViewController: UIViewController, GenericTableSelectionDelegate, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableview: UITableView!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dateToolbar: UIToolbar!
    @IBOutlet weak var taskBtn: UIButton!
    @IBOutlet weak var projectBtn: UIButton!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var notesTextField: UITextField!
    @IBOutlet weak var hoursTextField: UITextField!
    
    var projects = [Project]()
    var selectedProject:Project?
    var tasks = [Task]()
    var selectedTask:Task?
    var currentEntry = TimeEntryPost()
    var tableKind:TableKind = .PROJECT
    
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
        projects = DBservice.sharedInstance.getProjectsAll()
        if (selectedProject == nil){
            tasks = DBservice.sharedInstance.getTasksAll()
        }
        currentEntry.date = NSDate().toString()
    }
    
    
    @IBAction func onSelectProjectTouchUpInside(sender: AnyObject) {
    }
    
    
    @IBAction func onSelectTaskTouchUpInside(sender: AnyObject) {
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SelectProjectSegue" {
            if let destination = segue.destinationViewController as? GenericListViewController {
                let projectStr = projects.map {$0.name! as String}
                destination.populateSource(projectStr)
                destination.listSelectedDelegate = self
                destination.setViewTitle("Projects")
            }
        }
        else if segue.identifier == "SelectTaskSegue" {
            if let destination = segue.destinationViewController as? GenericListViewController {
                let taskStr = tasks.map {$0.name! as String}
                destination.populateSource(taskStr)
                destination.listSelectedDelegate = self
                destination.setViewTitle("Tasks")
            }
        }
    }
    
    func selectedRow(indexpathRow:Int, value:String){
        if tableKind == .PROJECT && projects[indexpathRow].name == value{
            selectedProject = projects[indexpathRow]
            selectedTask = nil
            tasks = DBservice.sharedInstance.getTasksForProject((selectedProject?.id)!)
            tableview.reloadData()
        }
        
        if tableKind == .TASK && tasks.count > indexpathRow && tasks[indexpathRow].name == value{
            selectedTask = tasks[indexpathRow]
            selectedProject = selectedTask?.project
            currentEntry.taskId = (selectedTask?.id)!
            tableview.reloadData()
        }
    }
    
    func generateApiData() -> TimeEntryPost{
        let nameCell = tableview.cellForRowAtIndexPath(NSIndexPath(forRow: TimeEntryTableRows.NOTES.rawValue, inSection: 0)) as! AddTableCell
        currentEntry.note = nameCell.valueTextField.text
        
        let amountCell = tableview.cellForRowAtIndexPath(NSIndexPath(forRow: TimeEntryTableRows.HOURS.rawValue, inSection: 0)) as! AddTableCell
        let amount = amountCell.valueTextField.text
        if let myNumber = NSNumberFormatter().numberFromString(amount!) {
            currentEntry.duration = Int (myNumber.doubleValue * 3600)
        } else {
            currentEntry.duration = 0
        }
        return currentEntry
    }
    
    func dismissKeyboard(){
        UIApplication.sharedApplication().sendAction("resignFirstResponder", to:nil, from:nil, forEvent:nil)
    }
    
    @IBAction func onDoneDateSelected(sender: AnyObject) {
        datePicker.hidden = true
        dateToolbar.hidden = true
    }
    
    @IBAction func onDateChanged(sender: AnyObject) {
        currentEntry.date = datePicker.date.toString()
        tableview.reloadData()
    }
    
    //MARK: TableView Delegate Functions
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("TextFieldCell", forIndexPath: indexPath) as! AddTableCell
        
        switch(indexPath.row){
        case TimeEntryTableRows.PROJECT.rawValue :
            cell.accessoryType = .DisclosureIndicator
            if selectedProject == nil{
                cell.updateData(TimeEntryTableRows.PROJECT.rawValue, entryType: .TIME, data: "")
            }
            else{
                cell.updateData(TimeEntryTableRows.PROJECT.rawValue, entryType: .TIME, data: selectedProject?.name)
            }
            break;
        case TimeEntryTableRows.TASK.rawValue :
            cell.accessoryType = .DisclosureIndicator
            if selectedTask == nil{
                cell.updateData(TimeEntryTableRows.TASK.rawValue, entryType: .TIME, data: "")
            }
            else{
                cell.updateData(TimeEntryTableRows.TASK.rawValue, entryType: .TIME, data: selectedTask?.name)
            }
            break;
        case TimeEntryTableRows.DATE.rawValue:
            cell.accessoryType = .None
            cell.updateData(TimeEntryTableRows.DATE.rawValue, entryType: .TIME, data: currentEntry.date)
            break;
        default:
            cell.accessoryType = .None
            cell.updateData(indexPath.row, entryType: .TIME)
            break
        }
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        switch(indexPath.row){
        case TimeEntryTableRows.PROJECT.rawValue:
            dismissKeyboard()
            datePicker.hidden = true
            dateToolbar.hidden = true
            performSegueWithIdentifier("SelectProjectSegue", sender: nil)
            tableKind = .PROJECT
            break;
        case TimeEntryTableRows.TASK.rawValue:
            dismissKeyboard()
            datePicker.hidden = true
            dateToolbar.hidden = true
            performSegueWithIdentifier("SelectTaskSegue", sender: nil)
            tableKind = .TASK
            break;
        case TimeEntryTableRows.DATE.rawValue:
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