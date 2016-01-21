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

class AddTimeEntryViewController: UIViewController, GenericTableSelectionDelegate {
    
    @IBOutlet weak var taskBtn: UIButton!
    @IBOutlet weak var projectBtn: UIButton!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var notesTextField: UITextField!
    @IBOutlet weak var hoursTextField: UITextField!
    
    var projects = [Project]()
    var selectedProject:Project?
    var tasks = [Task]()
    var selectedTask:Task?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        projects = DBservice.sharedInstance.getProjectsAll()
        if (selectedProject == nil){
            tasks = DBservice.sharedInstance.getTasksAll()
        }
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
            }
        }
        else if segue.identifier == "SelectTaskSegue" {
            if let destination = segue.destinationViewController as? GenericListViewController {
                let taskStr = tasks.map {$0.name! as String}
                destination.populateSource(taskStr)
                destination.listSelectedDelegate = self
            }
        }
    }
    
    func selectedRow(indexpathRow:Int, value:String){
        if projects[indexpathRow].name == value{
            selectedProject = projects[indexpathRow]
            projectBtn.setTitle(selectedProject!.name, forState: .Normal)
            tasks = DBservice.sharedInstance.getTasksForProject((selectedProject?.id)!)
        }
        
        if tasks.count > indexpathRow && tasks[indexpathRow].name == value{
            selectedTask = tasks[indexpathRow]
            taskBtn.setTitle(selectedTask!.name, forState: .Normal)
        }
        
    }
    
}