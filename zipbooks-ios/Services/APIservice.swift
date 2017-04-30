//
//  apis.swift
//  zipbooks-ios
//
//  Created by Francesco Pretelli on 11/01/16.
//  Copyright © 2016 Francesco Pretelli. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

class APIservice {

    static let sharedInstance = APIservice() //singleton lazy initialization, apple supports it sice swift 1.2
    fileprivate init() {} //This prevents others from using the default '()' initializer for this class.
   
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
    
    func login(_ email:String, password:String, callback: @escaping (_ result: Bool) -> Void ){
        
        let body = [
            "email": email,
            "password": password
        ]

        Alamofire.request(LOGIN_ENDPOINT, method: HTTPMethod.post, parameters: body, encoding: JSONEncoding(), headers: nil).responseObject{ (response: DataResponse<AuthObject>) in
            guard response.result.error == nil
                else {
                    // got an error in getting the data, need to handle it
                    print("error in API login -> " + String(describing: response.result.error!))
                    callback(false)
                    return
                }
            //handling the data
            do {
                let data = response.result.value! as AuthObject
                
                if data.token == "" || data.user?.email == nil || data.user?.name == nil {
                    callback (false)
                }
                else{
                    try Utility.setToken(data.token)
                    try Utility.setUserEmail((data.user?.email)!)
                    try Utility.setUserName((data.user?.name)!)
                
                    callback (true)
                }
            }
            catch  {
                 callback (false)
            }
        }
       
    }
   
    func getInvoices(_ callback: @escaping (_ data: [Invoice]?) -> Void ){
        sendRequestArray(remoteEndpoint: INVOICES_ENDPOINT, method: HTTPMethod.get){ (result:[Invoice]?) in
            callback(result)
        }
    }
    
    func getCustomers(_ callback: @escaping (_ data: [Customer]?) -> Void ){
        sendRequestArray(remoteEndpoint: CUSTOMERS_ENDPOINT, method: HTTPMethod.get){ (result:[Customer]?) in
            callback(result)
        }
    }
    
    func getProjects(_ callback: @escaping (_ data: [Project]?) -> Void ){
        sendRequestArray(remoteEndpoint: PROJECTS_ENDPOINT, method: HTTPMethod.get){ (result:[Project]?) in
            callback(result)
        }
    }
    
    func getTasks(_ callback: @escaping (_ data: [Task]?) -> Void ){
        sendRequestArray(remoteEndpoint: TASKS_ENDPOINT, method: HTTPMethod.get){ (result:[Task]?) in
         callback(result)
        }
    }
    
    func getExpenses(_ callback: @escaping (_ data: [Expense]?) -> Void ){
        sendRequestArray(remoteEndpoint: EXPENSES_ENDPOINT, method: HTTPMethod.get){ (result:[Expense]?) in
             callback(result)
        }
    }
    
    func getTimeEntries(_ callback: @escaping (_ data: [TimeEntry]?) -> Void ){
        sendRequestArray(remoteEndpoint: TIME_ENTRIES_ENDPOINT, method: HTTPMethod.get){ (result:[TimeEntry]?) in
            callback(result)
        }
    }
    
    //MARK: Post Functions
    
    func setExpense(_ expense: ExpensePost, callback: @escaping (_ data: Expense?) -> Void ){
         sendRequestObject(remoteEndpoint: EXPENSES_ENDPOINT, method: HTTPMethod.post, parameters: Mapper().toJSON(expense)){ (result: Expense?) in
            callback(result)
        }
    }
    
    func setTimeEntry(_ expense: TimeEntryPost, callback: @escaping (_ data: TimeEntry?) -> Void ){
         sendRequestObject(remoteEndpoint: TIME_ENTRIES_ENDPOINT, method: HTTPMethod.post, parameters: Mapper().toJSON(expense)){ (result: TimeEntry?) in
            callback(result)
        }
    }
    
    func saveNewCustomer(_ customer: CustomerPost, callback: @escaping (_ data: Customer?) -> Void ){
        sendRequestObject(remoteEndpoint: CUSTOMERS_ENDPOINT, method: HTTPMethod.post, parameters: Mapper().toJSON(customer)){ (result: Customer?) in
            callback(result)
        }
    }
    
    func saveNewProject(_ project: ProjectPost, callback: @escaping (_ data: Project?) -> Void ){
        sendRequestObject(remoteEndpoint: PROJECTS_ENDPOINT, method: HTTPMethod.post, parameters: Mapper().toJSON(project)){ (result: Project?) in
            callback(result)
        }
    }
    
    func saveNewTask(_ task: TaskPost, callback: @escaping (_ data: Task?) -> Void ){
        sendRequestObject(remoteEndpoint: TASKS_ENDPOINT, method: HTTPMethod.post, parameters: Mapper().toJSON(task)){ (result: Task?) in
            callback(result)
        }
    }
    
    /*func sendPostRequest<T: Mappable>( _ endpoint:String, method:Alamofire.Method, parameters: [String : AnyObject], callback: @escaping (_ result: T?) -> Void ) {
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
    }*/
    
    func sendRequestObject<T: Mappable>(remoteEndpoint endpoint:String, method:HTTPMethod, parameters: [String: Any]? = nil,  callback: @escaping (_ result: T?) -> Void ) {
        Alamofire.request(endpoint, method: method, parameters: parameters, encoding: JSONEncoding(), headers: authHeaders).responseObject{ (response: DataResponse<T>) in
                
            guard response.result.error == nil
                else {
                    // got an error in getting the data, need to handle it
                    print("error in API object request -> " + String(describing: response.result.error!))
                    callback(nil)
                    return
            }
            callback (response.result.value!)
        }
    }

    func sendRequestArray<T: Mappable>(remoteEndpoint endpoint:String, method:HTTPMethod, parameters: [String: Any]? = nil,  callback: @escaping (_ result: [T]?) -> Void ) {
        Alamofire.request(endpoint, method: method, parameters: parameters, encoding: JSONEncoding(), headers: authHeaders).responseArray { (response: DataResponse<[T]>) in
            guard response.result.error == nil
                else {
                    // got an error in getting the data, need to handle it
                    print("error in API array request for " + endpoint + "-> " + String(describing: response.result.error!))
                    callback(nil)
                    return
            }
            callback (response.result.value!)
        }
    }
    
    
    func generateHeaderAfterAuth(){
        authHeaders = [
            "Authorization": "bearer " + Utility.getToken()
        ]
    }
}
