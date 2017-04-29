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
    case project = 0
    case task = 1
    case hours = 2
    case notes = 3
    case date = 4
}

enum TableKind{
    case project
    case task
}

class AddTimeEntryViewController: UIViewController, GenericTableSelectionDelegate, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableview: UITableView!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dateToolbar: UIToolbar!
    
    
    var projects = [Project]()
    var selectedProject:Project?
    var tasks = [Task]()
    var selectedTask:Task?
    var currentEntry = TimeEntryPost()
    var tableKind:TableKind = .project
    
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
        projects = DBservice.sharedInstance.getProjectsAll()
        if (selectedProject == nil){
            tasks = DBservice.sharedInstance.getTasksAll()
        }
        currentEntry.date = Date().toString()
    }
    
    
    @IBAction func onSelectProjectTouchUpInside(_ sender: AnyObject) {
    }
    
    
    @IBAction func onSelectTaskTouchUpInside(_ sender: AnyObject) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SelectProjectSegue" {
            if let destination = segue.destination as? GenericListViewController {
                let projectStr = projects.map {$0.name! as String}
                destination.populateSource(projectStr)
                destination.listSelectedDelegate = self
                destination.setViewTitle("Projects")
                destination.insertType = InsertType.project
            }
        }
        else if segue.identifier == "SelectTaskSegue" {
            if let destination = segue.destination as? GenericListViewController {
                let taskStr = tasks.map {$0.name! as String}
                destination.populateSource(taskStr)
                destination.listSelectedDelegate = self
                destination.setViewTitle("Tasks")
                destination.insertType = InsertType.task
            }
        }
    }
    
    func selectedRow(_ indexpathRow:Int, value:String){
        if tableKind == .project && projects[indexpathRow].name == value{
            selectedProject = projects[indexpathRow]
            selectedTask = nil
            tasks = DBservice.sharedInstance.getTasksForProject((selectedProject?.id)!)
            tableview.reloadData()
        }
        
        if tableKind == .task && tasks.count > indexpathRow && tasks[indexpathRow].name == value{
            selectedTask = tasks[indexpathRow]
            selectedProject = selectedTask?.project
            currentEntry.taskId = (selectedTask?.id)!
            tableview.reloadData()
        }
    }
    
    func adjustInsetForKeyboard(_ frame: CGRect){
        //let categoryCell = tableview.cellForRowAtIndexPath(NSIndexPath(forRow: ExpenseTableRows.CATEGORY.rawValue, inSection: 0)) as! AddTableCell
        let notesCell = tableview.cellForRow(at: IndexPath(row: TimeEntryTableRows.notes.rawValue, section: 0)) as! AddTableCell
        if /*categoryCell.valueTextField.isFirstResponder() ||*/ notesCell.valueTextField.isFirstResponder{
            tableview.setContentOffset(CGPoint(x: 0, y: 100), animated: true)
            
        }
    }
    
    func restoreInsetForKeyboard(){
        if tableview.contentOffset.y != 0{
            tableview.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        }
    }
    
    func generateApiData() -> TimeEntryPost{
        let nameCell = tableview.cellForRow(at: IndexPath(row: TimeEntryTableRows.notes.rawValue, section: 0)) as! AddTableCell
        currentEntry.note = nameCell.valueTextField.text
        
        let amountCell = tableview.cellForRow(at: IndexPath(row: TimeEntryTableRows.hours.rawValue, section: 0)) as! AddTableCell
        let amount = amountCell.valueTextField.text
        if let myNumber = NumberFormatter().number(from: amount!) {
            currentEntry.duration = Int (myNumber.doubleValue * 3600)
        } else {
            currentEntry.duration = 0
        }
        return currentEntry
    }
    
    func dismissKeyboard(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
    }
    
    @IBAction func onDoneDateSelected(_ sender: AnyObject) {
        datePicker.isHidden = true
        dateToolbar.isHidden = true
    }
    
    @IBAction func onDateChanged(_ sender: AnyObject) {
        currentEntry.date = datePicker.date.toString()
        tableview.reloadData()
    }
    
    //MARK: TableView Delegate Functions
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldCell", for: indexPath) as! AddTableCell
        
        switch(indexPath.row){
        case TimeEntryTableRows.project.rawValue :
            cell.accessoryType = .disclosureIndicator
            if selectedProject == nil{
                cell.updateData(TimeEntryTableRows.project.rawValue, entryType: .time, data: "")
            }
            else{
                cell.updateData(TimeEntryTableRows.project.rawValue, entryType: .time, data: selectedProject?.name)
            }
            break;
        case TimeEntryTableRows.task.rawValue :
            cell.accessoryType = .disclosureIndicator
            if selectedTask == nil{
                cell.updateData(TimeEntryTableRows.task.rawValue, entryType: .time, data: "")
            }
            else{
                cell.updateData(TimeEntryTableRows.task.rawValue, entryType: .time, data: selectedTask?.name)
            }
            break;
        case TimeEntryTableRows.date.rawValue:
            cell.accessoryType = .none
            cell.updateData(TimeEntryTableRows.date.rawValue, entryType: .time, data: currentEntry.date)
            break;
        default:
            cell.accessoryType = .none
            cell.updateData(indexPath.row, entryType: .time)
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
        switch(indexPath.row){
        case TimeEntryTableRows.project.rawValue:
            dismissKeyboard()
            datePicker.isHidden = true
            dateToolbar.isHidden = true
            performSegue(withIdentifier: "SelectProjectSegue", sender: nil)
            tableKind = .project
            break;
        case TimeEntryTableRows.task.rawValue:
            dismissKeyboard()
            datePicker.isHidden = true
            dateToolbar.isHidden = true
            performSegue(withIdentifier: "SelectTaskSegue", sender: nil)
            tableKind = .task
            break;
        case TimeEntryTableRows.date.rawValue:
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
