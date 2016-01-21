//
//  apis.swift
//  zipbooks-ios
//
//  Created by Francesco Pretelli on 11/01/16.
//  Copyright © 2016 Francesco Pretelli. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import AlamofireObjectMapper
import ObjectMapper

class APIservice {

    static let sharedInstance = APIservice() //singleton lazy initialization, apple supports it sice swift 1.2
    private init() {} //This prevents others from using the default '()' initializer for this class.
   
    static var ZIPBOOK = "https://api.zipbooks.com/v1"
    
    let LOGIN_ENDPOINT = ZIPBOOK + "/auth/login"
    let INVOICES_ENDPOINT = ZIPBOOK + "/invoices"
    let CUSTOMERS_ENDPOINT = ZIPBOOK + "/customers"
    let PROJECTS_ENDPOINT = ZIPBOOK + "/projects"
    let EXPENSES_ENDPOINT = ZIPBOOK + "/expenses"
    let TASKS_ENDPOINT = ZIPBOOK + "/tasks"
    let TIME_ENTRIES_ENDPOINT = ZIPBOOK + "/time_entries"
    
    var authHeaders = [
        "Authorization": "bearer " + Utility.getToken(),
    ]
    
    func login(email:String, password:String, callback: (result: Bool) -> Void ){
        
        let body = [
            "email": email,
            "password": password
        ]
        
        Alamofire.request(.POST, LOGIN_ENDPOINT, parameters:body).responseObject { (response:  Response<AuthObject, NSError>) in

            guard response.result.error == nil
                else {
                    // got an error in getting the data, need to handle it
                    print("error in API login -> " + String(response.result.error!))
                    callback(result: false)
                    return
                }
            //handling the data
            do {
                let data = response.result.value! as AuthObject
                
                if data.token == "" || data.user?.email == nil || data.user?.name == nil {
                    callback (result: false)
                }
                else{
                    try Utility.setToken(data.token)
                    try Utility.setUserEmail((data.user?.email)!)
                    try Utility.setUserName((data.user?.name)!)
                
                    callback (result: true)
                }
            }
            catch  {
                 callback (result: false)
            }
        }
       
    }
   
    func getInvoices(callback: (data: [Invoice]?) -> Void ){
        sendRequestArray(Invoice.self, endpoint: INVOICES_ENDPOINT, method: Alamofire.Method.GET){ (result:[Invoice]?) in
            callback(data: result)
        }
        
        /*sendRequestObject(Invoice.self, endpoint: INVOICES_ENDPOINT, method: Alamofire.Method.GET){ (result:Invoice?) in
            
        }*/
    }
    
    func getCustomers(callback: (data: [Customer]?) -> Void ){
        sendRequestArray(Customer.self, endpoint: CUSTOMERS_ENDPOINT, method: Alamofire.Method.GET){ (result:[Customer]?) in
            callback(data: result)
        }
    }
    
    func getProjects(callback: (data: [Project]?) -> Void ){
        sendRequestArray(Project.self, endpoint: PROJECTS_ENDPOINT, method: Alamofire.Method.GET){ (result:[Project]?) in
            callback(data: result)
        }
    }
    
    func getTasks(callback: (data: [Task]?) -> Void ){
        sendRequestArray(Task.self, endpoint: TASKS_ENDPOINT, method: Alamofire.Method.GET){ (result:[Task]?) in
            callback(data: result)
        }
    }
    
    func getExpenses(callback: (data: [Expense]?) -> Void ){
        sendRequestArray(Expense.self, endpoint: EXPENSES_ENDPOINT, method: Alamofire.Method.GET){ (result:[Expense]?) in
            callback(data: result)
        }
    }
    
    func getTimeEntries(callback: (data: [TimeEntry]?) -> Void ){
        sendRequestArray(TimeEntry.self, endpoint: TIME_ENTRIES_ENDPOINT, method: Alamofire.Method.GET){ (result:[TimeEntry]?) in
            callback(data: result)
        }
    }
    
    //MARK: Post Functions
    
    func setExpense(expense: ExpensePost, callback: (data: Expense?) -> Void ){
        sendPostRequest(Expense.self, endpoint: EXPENSES_ENDPOINT, method: Alamofire.Method.POST, parameters: Mapper().toJSON(expense)){ (result: Expense?) in
            callback(data: result)
        }
    }
    
    func sendPostRequest<T: Mappable>(obj: T.Type, endpoint:String, method:Alamofire.Method, parameters: [String : AnyObject], callback: (result: T?) -> Void ) {
        Alamofire.request(method, endpoint, headers:authHeaders, parameters: parameters, encoding: .JSON).responseObject { (response: Response<T, NSError>) in
            guard response.result.error == nil
                else {
                    // got an error in getting the data, need to handle it
                    print("error in API object request -> " + String(response.result.error!))
                    callback(result: nil)
                    return
            }
            callback (result: response.result.value!)
        }
    }
    
    func sendRequestObject<T: Mappable>(obj: T.Type, endpoint:String, method:Alamofire.Method, callback: (result: T?) -> Void ) {
        Alamofire.request(method, endpoint, headers:authHeaders).responseObject { (response: Response<T, NSError>) in
            guard response.result.error == nil
                else {
                    // got an error in getting the data, need to handle it
                    print("error in API object request -> " + String(response.result.error!))
                    callback(result: nil)
                    return
            }
            callback (result: response.result.value!)
        }
    }

    func sendRequestArray<T: Mappable>(obj: T.Type, endpoint:String, method:Alamofire.Method, callback: (result: [T]?) -> Void ) {
        Alamofire.request(method, endpoint, headers:authHeaders).responseArray { (response: Response<[T], NSError>) in
            guard response.result.error == nil
                else {
                    // got an error in getting the data, need to handle it
                    print("error in API array request -> " + String(response.result.error!))
                    callback(result: nil)
                    return
            }
            callback (result: response.result.value!)
        }
    }
    
    
    func generateHeaderAfterAuth(){
        authHeaders = [
            "Authorization": "bearer " + Utility.getToken()
        ]
    }
    
}