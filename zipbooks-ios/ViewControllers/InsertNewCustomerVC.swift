//
//  InsertNewCustomerVC.swift
//  zipbooks-ios
//
//  Created by Francesco Pretelli on 27/01/16.
//  Copyright © 2016 Francesco Pretelli. All rights reserved.
//

import Foundation
import UIKit

enum CustomerTableRows:Int{
    case name = 0
    case email
    case phone
    case address_1
    case address_2
    case city
    case state
    case postal_CODE
    case country
    case end
}

class InsertNewCustomer: UIViewController,UITableViewDelegate, UITableViewDataSource {
        
    @IBOutlet weak var tableview: UITableView!
    var selectedCustomer = CustomerPost()
    
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
    
    func adjustInsetForKeyboard(_ frame: CGRect ){
        let stateCell = tableview.cellForRow(at: IndexPath(row: CustomerTableRows.state.rawValue, section: 0)) as! AddTableCell
        let pcodeCell = tableview.cellForRow(at: IndexPath(row: CustomerTableRows.postal_CODE.rawValue, section: 0)) as! AddTableCell
        let countryCell = tableview.cellForRow(at: IndexPath(row: CustomerTableRows.country.rawValue, section: 0)) as! AddTableCell
        if stateCell.valueTextField.isFirstResponder || pcodeCell.valueTextField.isFirstResponder || countryCell.valueTextField.isFirstResponder{
            tableview.setContentOffset(CGPoint(x: 0, y: 150), animated: true)
        }
    }
    
    func restoreInsetForKeyboard(){
        if tableview.contentOffset.y != 0{
            tableview.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        }
    }
    
    func generateApiData() -> CustomerPost{
        for i in 0 ..< CustomerTableRows.end.rawValue {
            let cell = tableview.cellForRow(at: IndexPath(row: i, section: 0)) as! AddTableCell
            switch (i) {
            case CustomerTableRows.name.rawValue:
                selectedCustomer.name = cell.valueTextField.text
                break
            case CustomerTableRows.email.rawValue:
                selectedCustomer.email = cell.valueTextField.text
                break
            case CustomerTableRows.phone.rawValue:
                selectedCustomer.phone = cell.valueTextField.text
                break
            case CustomerTableRows.address_1.rawValue:
                selectedCustomer.address_1 = cell.valueTextField.text
                break
            case CustomerTableRows.address_2.rawValue:
                selectedCustomer.address_2 = cell.valueTextField.text
                break
            case CustomerTableRows.city.rawValue:
                selectedCustomer.city = cell.valueTextField.text
                break
            case CustomerTableRows.state.rawValue:
                selectedCustomer.state = cell.valueTextField.text
                break
            case CustomerTableRows.postal_CODE.rawValue:
                selectedCustomer.postal_code = cell.valueTextField.text
                break
            case CustomerTableRows.country.rawValue:
                selectedCustomer.country = cell.valueTextField.text
                break
            default:
                break
            }
        }
        return selectedCustomer
    }
    
    
    //MARK: TableView Delegate Functions
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldCell", for: indexPath) as! AddTableCell
        cell.accessoryType = .none
        
        switch(indexPath.row){
        case CustomerTableRows.name.rawValue :
            cell.updateData(indexPath.row, entryType: .customer, data: selectedCustomer.name)
            break
        case CustomerTableRows.email.rawValue :
            cell.updateData(indexPath.row, entryType: .customer, data: selectedCustomer.email)
            break
        case CustomerTableRows.phone.rawValue :
            cell.updateData(indexPath.row, entryType: .customer, data: selectedCustomer.phone)
            break
        case CustomerTableRows.address_1.rawValue :
            cell.updateData(indexPath.row, entryType: .customer, data: selectedCustomer.address_1)
            break
        case CustomerTableRows.address_2.rawValue :
            cell.updateData(indexPath.row, entryType: .customer, data: selectedCustomer.address_2)
            break
        case CustomerTableRows.city.rawValue :
            cell.updateData(indexPath.row, entryType: .customer, data: selectedCustomer.city)
            break
        case CustomerTableRows.state.rawValue :
            cell.updateData(indexPath.row, entryType: .customer, data: selectedCustomer.state)
            break
        case CustomerTableRows.postal_CODE.rawValue :
            cell.updateData(indexPath.row, entryType: .customer, data: selectedCustomer.postal_code)
            break
        case CustomerTableRows.country.rawValue :
            cell.updateData(indexPath.row, entryType: .customer, data: selectedCustomer.country)
            break
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CustomerTableRows.end.rawValue
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
