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
    case expense = 0
    case time = 1
    case customer
    case project
}

class AddTableCell: UITableViewCell, UITextFieldDelegate {
    @IBOutlet weak var descriptionImg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var valueTextField: UITextField!
    @IBOutlet weak var valueLbl: UILabel!
    
    func updateData(_ type: Int, entryType:EntryType, data:String?="" ){
        if entryType == .expense{
            updateExpenseData(ExpenseTableRows(rawValue: type)!, data:data)
        }
        else if entryType == .time{
            updateTimeEntryData(TimeEntryTableRows(rawValue: type)!, data:data)
        }
        else if entryType == .customer{
            updateCustomerData(CustomerTableRows(rawValue: type)!, data:data)
        }
        else if entryType == .project{
            updateProjectData(ProjectTableRows(rawValue: type)!, data:data)
        }
    }
    
    func updateProjectData(_ type: ProjectTableRows, data:String?=""){
        switch(type){
        case .customer:
            valueTextField.isHidden = true
            valueLbl.isHidden = false
            valueLbl.text = data
            descriptionLbl.text = "Customer:"
            descriptionImg.image = (UIImage(named: "CustomerIcon"))
            break
        case .name:
            valueTextField.isHidden = false
            valueLbl.isHidden = true
            descriptionLbl.text = data
            descriptionLbl.text = "Name:"
            valueTextField.placeholder = "Mandatory"
            descriptionImg.image = (UIImage(named: "ProjectIcon"))
            break
        case .description:
            valueTextField.isHidden = false
            valueLbl.isHidden = true
            descriptionLbl.text = "Description:"
            valueTextField.keyboardType = .default
            valueTextField.placeholder = "Optional"
            valueTextField.returnKeyType = .done
            descriptionImg.image = (UIImage(named: "NotesIcon"))
            break
        case .hourly_RATE:
            valueTextField.isHidden = false
            valueLbl.isHidden = true
            descriptionLbl.text = "Hourly Rate:"
            valueTextField.keyboardType = .decimalPad
            valueTextField.placeholder = "Mandatory"
            valueTextField.returnKeyType = .done
            descriptionImg.image = (UIImage(named: "AmountIcon"))
            break
        default:
            break
        }
    }
    
    func updateCustomerData(_ type: CustomerTableRows, data:String?=""){
        if data != ""{
            valueTextField.text = data
        }
        valueLbl.isHidden = true
        valueTextField.isHidden = false
        valueTextField.returnKeyType = .done
        valueTextField.keyboardType = .default
        
        switch(type){
        case CustomerTableRows.name :
            descriptionLbl.text = "Name:"
            valueTextField.placeholder = "Mandatory"
            descriptionImg.image = (UIImage(named: "CustomerIcon"))
            break
        case CustomerTableRows.email :
            descriptionLbl.text = "Email:"
            valueTextField.placeholder = "Mandatory"
            descriptionImg.image = (UIImage(named: "EmailIcon"))
            break
        case CustomerTableRows.phone :
            descriptionLbl.text = "Phone:"
            valueTextField.placeholder = "Optional"
            descriptionImg.image = (UIImage(named: "PhoneIcon"))
            break
        case CustomerTableRows.address_1 :
            descriptionLbl.text = "Address 1:"
            valueTextField.placeholder = "Optional"
            descriptionImg.image = (UIImage(named: "AddressIcon"))
            break
        case CustomerTableRows.address_2 :
            descriptionLbl.text = "Address 2:"
            valueTextField.placeholder = "Optional"
            descriptionImg.image = (UIImage(named: "AddressIcon"))
            break
        case CustomerTableRows.city :
            descriptionLbl.text = "City:"
            valueTextField.placeholder = "Optional"
            descriptionImg.image = (UIImage(named: "AddressIcon"))
            break
        case CustomerTableRows.state :
            descriptionLbl.text = "State:"
            valueTextField.placeholder = "Optional"
            descriptionImg.image = (UIImage(named: "AddressIcon"))
            break
        case CustomerTableRows.postal_CODE :
            descriptionLbl.text = "Postal C:"
            valueTextField.placeholder = "Optional"
            descriptionImg.image = (UIImage(named: "AddressIcon"))
            break
        case CustomerTableRows.country :
            descriptionLbl.text = "Country:"
            valueTextField.placeholder = "Optional"
            descriptionImg.image = (UIImage(named: "CountryIcon"))
            break
        default:
            break
        }
        
        
    }
    
    func updateTimeEntryData(_ type: TimeEntryTableRows, data:String?=""){
        switch(type){
        case .project:
            valueTextField.isHidden = true
            valueLbl.isHidden = false
            valueLbl.text = data
            descriptionLbl.text = "Project:"
            descriptionImg.image = (UIImage(named: "ProjectIcon"))
            break
        case .date:
            valueTextField.isHidden = true
            valueLbl.isHidden = false
            if data != nil{
                valueLbl.text = data
            }
            else {
                valueLbl.text = Date().toString()
            }
            descriptionLbl.text = "Date:"
            descriptionImg.image = (UIImage(named: "DateIcon"))
            break
        case .notes:
            valueTextField.isHidden = false
            valueLbl.isHidden = true
            descriptionLbl.text = "Notes:"
            valueTextField.keyboardType = .default
            valueTextField.placeholder = "Optional"
            valueTextField.returnKeyType = .done
            descriptionImg.image = (UIImage(named: "NotesIcon"))
            break
        case .task:
            valueTextField.isHidden = true
            valueLbl.isHidden = false
            valueLbl.text = data
            descriptionLbl.text = "Task:"
            descriptionImg.image = (UIImage(named: "TaskIcon"))
            break
        case .hours:
            valueTextField.isHidden = false
            valueLbl.isHidden = true
            descriptionLbl.text = "Hours:"
            valueTextField.keyboardType = .decimalPad
            valueTextField.placeholder = "Mandatory"
            valueTextField.returnKeyType = .done
            descriptionImg.image = (UIImage(named: "HoursIcon"))
            break
        }
    }
    
    func updateExpenseData(_ type: ExpenseTableRows, data:String?=""){
        switch(type){
        case .customer:
            valueTextField.isHidden = true
            valueLbl.isHidden = false
            valueLbl.text = data
            descriptionLbl.text = "Customer:"
            descriptionImg.image = (UIImage(named: "CustomerIcon"))
            break
        case .date:
            valueTextField.isHidden = true
            valueLbl.isHidden = false
            if data != nil{
                valueLbl.text = data
            }
            else {
                valueLbl.text = Date().toString()
            }
            descriptionLbl.text = "Date:"
            descriptionImg.image = (UIImage(named: "DateIcon"))
            break
        case .notes:
            valueTextField.isHidden = false
            valueLbl.isHidden = true
            descriptionLbl.text = "Notes:"
            valueTextField.keyboardType = .default
            valueTextField.placeholder = "Optional"
            valueTextField.returnKeyType = .done
            descriptionImg.image = (UIImage(named: "NotesIcon"))
            break
        case .amount:
            valueTextField.isHidden = false
            valueLbl.isHidden = true
            descriptionLbl.text = "Amount:"
            valueTextField.placeholder = "Mandatory"
            valueTextField.keyboardType = .decimalPad
            valueTextField.returnKeyType = .done
            descriptionImg.image = (UIImage(named: "AmountIcon"))
            break
        case .category:
            valueTextField.isHidden = false
            valueLbl.isHidden = true
            descriptionLbl.text = "Category:"
            valueTextField.keyboardType = .default
            valueTextField.placeholder = "Optional"
            valueTextField.returnKeyType = .done
            descriptionImg.image = (UIImage(named: "CategoryIcon"))
            break
        case .name:
            valueTextField.isHidden = false
            valueLbl.isHidden = true
            descriptionLbl.text = "Name:"
            valueTextField.keyboardType = .default
            valueTextField.placeholder = "Optional"
            valueTextField.returnKeyType = .done
            descriptionImg.image = (UIImage(named: "NameIcon"))
            
            break
            
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        valueTextField.delegate = self
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        valueTextField.resignFirstResponder()
        return true
    }
}
