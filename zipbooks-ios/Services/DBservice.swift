//
//  DBservice.swift
//  zipbooks-ios
//
//  Created by Francesco Pretelli on 13/01/16.
//  Copyright © 2016 Francesco Pretelli. All rights reserved.
//

import Foundation
import RealmSwift


class DBservice{
    
    static let sharedInstance = DBservice() //singleton lazy initialization, apple supports it sice swift 1.2
    fileprivate init() {} //This prevents others from using the default '()' initializer for this class.
    
    //MARK: Save functions
    
    func saveObject(_ data: Object){
        let realm = try! Realm()
        try! realm.write({ () -> Void in
            realm.add(data, update: true)
        })
    }
    
    func saveArray(_ data: [Object]){
        let realm = try! Realm()
        try! realm.write({ () -> Void in
            for val in data{
                realm.add(val, update: true)
            }
        })
    }
    
    func clearDB(){
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    //MARK: Read functions
    
    func getInvoicesAll() -> [Invoice]{
        return getArray(returnType: Invoice.self)
    }
    
    func getInvoicesForCompany(_ companyName:String) -> [Invoice]{
        let customerId = getCustomerIdFromName(companyName)
        return getArray(filter: "customer_id = " + String(customerId), returnType: Invoice.self)
    }
    
    func getProjectsAll() -> [Project]{
        return getArray(returnType: Project.self)
    }
    
    func getTasksAll() -> [Task]{
        return getArray(returnType: Task.self)
    }
    
    func getTasksForProject(_ projectID:Int) -> [Task] {
        return getArray(filter: "project_id = " + String(projectID), returnType: Task.self )
    }
    
    func getCustomersAll() -> [Customer]{
        return getArray(returnType: Customer.self)
    }
    
    func getCustomerIdFromName(_ customerName:String) -> Int {
        return getArray(filter: "name = " + customerName, returnType: Customer.self)[0].id
    }
    
    func getCustomerNameFromId(_ customerID:Int) -> String {
        let name =  getArray(filter: "id = " + String(customerID), returnType: Customer.self)[0].name!
        print(name)
         return name
    }
    
    func getObject<T: Object>(_ primaryKey:Object, returnType: T.Type)-> T {
        let realm = try! Realm()
        return  realm.object(ofType: returnType, forPrimaryKey: primaryKey)!
    }
    
    func getArray<T: Object>(_ sorting:String = "", filter:String = "", returnType: T.Type)-> [T] {
        let realm = try! Realm()
        
        if sorting == "" && filter == "" {
            return Array( realm.objects(returnType))
        }
        else if sorting == "" && filter != "" {
            return Array(realm.objects(returnType).filter(filter))
        }
        else if sorting != "" && filter == "" {
           return Array(realm.objects(returnType).sorted(byKeyPath: sorting))
        }
        return Array(realm.objects(returnType).sorted(byKeyPath: sorting).filter(filter))
    }
   
}


