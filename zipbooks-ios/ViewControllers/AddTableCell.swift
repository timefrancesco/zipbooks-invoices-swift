//
//  AddTableCell.swift
//  zipbooks-ios
//
//  Created by Francesco Pretelli on 22/01/16.
//  Copyright © 2016 Francesco Pretelli. All rights reserved.
//

import Foundation
import UIKit

enum EntryType:Int{
    case EXPENSE = 0
    case TIME = 1
    case CUSTOMER
    case PROJECT
}

class AddTableCell: UITableViewCell, UITextFieldDelegate {
    @IBOutlet weak var descriptionImg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var valueTextField: UITextField!
    @IBOutlet weak var valueLbl: UILabel!
    
    func updateData(type: Int, entryType:EntryType, data:String?="" ){
        if entryType == .EXPENSE{
            updateExpenseData(ExpenseTableRows(rawValue: type)!, data:data)
        }
        else if entryType == .TIME{
            updateTimeEntryData(TimeEntryTableRows(rawValue: type)!, data:data)
        }
        else if entryType == .CUSTOMER{
            updateCustomerData(CustomerTableRows(rawValue: type)!, data:data)
        }
        else if entryType == .PROJECT{
            updateProjectData(ProjectTableRows(rawValue: type)!, data:data)
        }
    }
    
    func updateProjectData(type: ProjectTableRows, data:String?=""){
        switch(type){
        case .CUSTOMER:
            valueTextField.hidden = true
            valueLbl.hidden = false
            valueLbl.text = data
            descriptionLbl.text = "Customer:"
            descriptionImg.image = (UIImage(named: "CustomerIcon"))
            break
        case .NAME:
            valueTextField.hidden = false
            valueLbl.hidden = true
            descriptionLbl.text = data
            descriptionLbl.text = "Name:"
            valueTextField.placeholder = "Mandatory"
            descriptionImg.image = (UIImage(named: "ProjectIcon"))
            break
        case .DESCRIPTION:
            valueTextField.hidden = false
            valueLbl.hidden = true
            descriptionLbl.text = "Description:"
            valueTextField.keyboardType = .Default
            valueTextField.placeholder = "Optional"
            valueTextField.returnKeyType = .Done
            descriptionImg.image = (UIImage(named: "NotesIcon"))
            break
        case .HOURLY_RATE:
            valueTextField.hidden = false
            valueLbl.hidden = true
            descriptionLbl.text = "Hourly Rate:"
            valueTextField.keyboardType = .DecimalPad
            valueTextField.placeholder = "Mandatory"
            valueTextField.returnKeyType = .Done
            descriptionImg.image = (UIImage(named: "AmountIcon"))
            break
        default:
            break
        }
    }
    
    func updateCustomerData(type: CustomerTableRows, data:String?=""){
        if data != ""{
            valueTextField.text = data
        }
        valueLbl.hidden = true
        valueTextField.hidden = false
        valueTextField.returnKeyType = .Done
        valueTextField.keyboardType = .Default
        
        switch(type){
        case CustomerTableRows.NAME :
            descriptionLbl.text = "Name:"
            valueTextField.placeholder = "Mandatory"
            descriptionImg.image = (UIImage(named: "CustomerIcon"))
            break
        case CustomerTableRows.EMAIL :
            descriptionLbl.text = "Email:"
            valueTextField.placeholder = "Mandatory"
            descriptionImg.image = (UIImage(named: "EmailIcon"))
            break
        case CustomerTableRows.PHONE :
            descriptionLbl.text = "Phone:"
            valueTextField.placeholder = "Optional"
            descriptionImg.image = (UIImage(named: "PhoneIcon"))
            break
        case CustomerTableRows.ADDRESS_1 :
            descriptionLbl.text = "Address 1:"
            valueTextField.placeholder = "Optional"
            descriptionImg.image = (UIImage(named: "AddressIcon"))
            break
        case CustomerTableRows.ADDRESS_2 :
            descriptionLbl.text = "Address 2:"
            valueTextField.placeholder = "Optional"
            descriptionImg.image = (UIImage(named: "AddressIcon"))
            break
        case CustomerTableRows.CITY :
            descriptionLbl.text = "City:"
            valueTextField.placeholder = "Optional"
            descriptionImg.image = (UIImage(named: "AddressIcon"))
            break
        case CustomerTableRows.STATE :
            descriptionLbl.text = "State:"
            valueTextField.placeholder = "Optional"
            descriptionImg.image = (UIImage(named: "AddressIcon"))
            break
        case CustomerTableRows.POSTAL_CODE :
            descriptionLbl.text = "Postal C:"
            valueTextField.placeholder = "Optional"
            descriptionImg.image = (UIImage(named: "AddressIcon"))
            break
        case CustomerTableRows.COUNTRY :
            descriptionLbl.text = "Country:"
            valueTextField.placeholder = "Optional"
            descriptionImg.image = (UIImage(named: "CountryIcon"))
            break
        default:
            break
        }
        
        
    }
    
    func updateTimeEntryData(type: TimeEntryTableRows, data:String?=""){
        switch(type){
        case .PROJECT:
            valueTextField.hidden = true
            valueLbl.hidden = false
            valueLbl.text = data
            descriptionLbl.text = "Project:"
            descriptionImg.image = (UIImage(named: "ProjectIcon"))
            break
        case .DATE:
            valueTextField.hidden = true
            valueLbl.hidden = false
            if data != nil{
                valueLbl.text = data
            }
            else {
                valueLbl.text = NSDate().toString()
            }
            descriptionLbl.text = "Date:"
            descriptionImg.image = (UIImage(named: "DateIcon"))
            break
        case .NOTES:
            valueTextField.hidden = false
            valueLbl.hidden = true
            descriptionLbl.text = "Notes:"
            valueTextField.keyboardType = .Default
            valueTextField.placeholder = "Optional"
            valueTextField.returnKeyType = .Done
            descriptionImg.image = (UIImage(named: "NotesIcon"))
            break
        case .TASK:
            valueTextField.hidden = true
            valueLbl.hidden = false
            valueLbl.text = data
            descriptionLbl.text = "Task:"
            descriptionImg.image = (UIImage(named: "TaskIcon"))
            break
        case .HOURS:
            valueTextField.hidden = false
            valueLbl.hidden = true
            descriptionLbl.text = "Hours:"
            valueTextField.keyboardType = .DecimalPad
            valueTextField.placeholder = "Mandatory"
            valueTextField.returnKeyType = .Done
            descriptionImg.image = (UIImage(named: "HoursIcon"))
            break
        }
    }
    
    func updateExpenseData(type: ExpenseTableRows, data:String?=""){
        switch(type){
        case .CUSTOMER:
            valueTextField.hidden = true
            valueLbl.hidden = false
            valueLbl.text = data
            descriptionLbl.text = "Customer:"
            descriptionImg.image = (UIImage(named: "CustomerIcon"))
            break
        case .DATE:
            valueTextField.hidden = true
            valueLbl.hidden = false
            if data != nil{
                valueLbl.text = data
            }
            else {
                valueLbl.text = NSDate().toString()
            }
            descriptionLbl.text = "Date:"
            descriptionImg.image = (UIImage(named: "DateIcon"))
            break
        case .NOTES:
            valueTextField.hidden = false
            valueLbl.hidden = true
            descriptionLbl.text = "Notes:"
            valueTextField.keyboardType = .Default
            valueTextField.placeholder = "Optional"
            valueTextField.returnKeyType = .Done
            descriptionImg.image = (UIImage(named: "NotesIcon"))
            break
        case .AMOUNT:
            valueTextField.hidden = false
            valueLbl.hidden = true
            descriptionLbl.text = "Amount:"
            valueTextField.placeholder = "Mandatory"
            valueTextField.keyboardType = .DecimalPad
            valueTextField.returnKeyType = .Done
            descriptionImg.image = (UIImage(named: "AmountIcon"))
            break
        case .CATEGORY:
            valueTextField.hidden = false
            valueLbl.hidden = true
            descriptionLbl.text = "Category:"
            valueTextField.keyboardType = .Default
            valueTextField.placeholder = "Optional"
            valueTextField.returnKeyType = .Done
            descriptionImg.image = (UIImage(named: "CategoryIcon"))
            break
        case .NAME:
            valueTextField.hidden = false
            valueLbl.hidden = true
            descriptionLbl.text = "Name:"
            valueTextField.keyboardType = .Default
            valueTextField.placeholder = "Optional"
            valueTextField.returnKeyType = .Done
            descriptionImg.image = (UIImage(named: "NameIcon"))
            
            break
            
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        valueTextField.delegate = self
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {   //delegate method
        valueTextField.resignFirstResponder()
        return true
    }
}