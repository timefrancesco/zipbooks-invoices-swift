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
    private init() {} //This prevents others from using the default '()' initializer for this class.
    
    //MARK: Save functions
    
    func saveObject(data: Object){
        let realm = try! Realm()
        try! realm.write({ () -> Void in
            realm.add(data, update: true)
        })
    }
    
    func saveArray(data: [Object]){
        let realm = try! Realm()
        try! realm.write({ () -> Void in
            for val in data{
                realm.add(val, update: true)
            }
        })
    }
    
    //MARK: Read functions
    
    func getInvoicesAll() -> [Invoice]{
        return getArray(returnType: Invoice.self)
    }
    
    func getInvoicesForCompany(companyName:String) -> [Invoice]{
        let customerId = getCustomerIdFromName(companyName)
        return getArray(filter: "customer_id = " + String(customerId), returnType: Invoice.self)
    }
    
    func getProjectsAll() -> [Project]{
        return getArray(returnType: Project.self)
    }
    
    func getCustomerIdFromName(customerName:String) -> Int {
        return getArray(filter: "name = " + customerName, returnType: Customer.self)[0].id
    }
    
    func getCustomerNameFromId(customerID:Int) -> String {
        let name =  getArray(filter: "id = " + String(customerID), returnType: Customer.self)[0].name!
        print(name)
         return name
    }
    
    func getObject<T: Object>(primaryKey:Object, returnType: T.Type)-> T {
        let realm = try! Realm()
        return  realm.objectForPrimaryKey(returnType, key: primaryKey)!
    }
    
    func getArray<T: Object>(sorting:String = "", filter:String = "", returnType: T.Type)-> [T] {
        let realm = try! Realm()
        
        if sorting == "" && filter == "" {
            return Array( realm.objects(returnType))
        }
        else if sorting == "" && filter != "" {
            return Array(realm.objects(returnType).filter(filter))
        }
        else if sorting != "" && filter == "" {
           return Array(realm.objects(returnType).sorted(sorting))
        }
        return Array(realm.objects(returnType).sorted(sorting).filter(filter))
    }
   
}


