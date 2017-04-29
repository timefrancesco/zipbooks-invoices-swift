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
    case customer = 0
    case name
    case hourly_RATE
    case description
    case end
}

class InsertNewProjectVC: UIViewController,UITableViewDelegate, UITableViewDataSource, GenericTableSelectionDelegate {
    @IBOutlet weak var tableview: UITableView!
    var project = ProjectPost()
    var customers = [Customer]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        tableview.dataSource = self
        tableview.tableFooterView = UIView()
        
        tableview.register(UINib(nibName: "AddTableCell", bundle: nil), forCellReuseIdentifier: "TextFieldCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableview.reloadData()
    }
    
    func dismissKeyboard(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
    }
    
    func generateApiData() -> ProjectPost{
        for i in 0 ..< ProjectTableRows.end.rawValue {
            let cell = tableview.cellForRow(at: IndexPath(row: i, section: 0)) as! AddTableCell
            switch (i) {
            case ProjectTableRows.customer.rawValue:
                break
            case ProjectTableRows.name.rawValue:
                project.name = cell.valueTextField.text
                break
            case ProjectTableRows.hourly_RATE.rawValue:
                project.hourly_rate = (cell.valueTextField.text?.toDouble())!
                break
            case ProjectTableRows.description.rawValue:
                project.project_description = cell.valueTextField.text
                break
            default:
                break
            }
        }
        return project
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowCustomerFromModalSegue" {
            if let destination = segue.destination as? GenericListViewController {
                customers = DBservice.sharedInstance.getCustomersAll()
                let customersStr = customers.map {$0.name! as String}
                destination.populateSource(customersStr)
                destination.listSelectedDelegate = self
                destination.setViewTitle("Customers")
                destination.insertType = InsertType.customer
            }
        }
    }
    
    func selectedRow(_ indexpathRow:Int, value:String){
        project.customer_id = customers[indexpathRow].id
        tableview.reloadData()
    }
    
    
    //MARK: TableView Delegate Functions
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldCell", for: indexPath) as! AddTableCell
        cell.accessoryType = .none
        
        switch(indexPath.row){
        case ProjectTableRows.customer.rawValue :
            cell.updateData(indexPath.row, entryType: .project, data: project.customer_id == 0 ? "" : DBservice.sharedInstance.getCustomerNameFromId(project.customer_id))
            break
        case ProjectTableRows.name.rawValue :
            cell.updateData(indexPath.row, entryType: .project, data: project.name)
            break
        case ProjectTableRows.hourly_RATE.rawValue :
            cell.updateData(indexPath.row, entryType: .project, data: String(project.hourly_rate))
            break
        case ProjectTableRows.description.rawValue :
            cell.updateData(indexPath.row, entryType: .project, data: project.project_description)
            break
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProjectTableRows.end.rawValue
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == ProjectTableRows.customer.rawValue {
            performSegue(withIdentifier: "ShowCustomerFromModalSegue", sender: nil)
        }
        
    }
}
