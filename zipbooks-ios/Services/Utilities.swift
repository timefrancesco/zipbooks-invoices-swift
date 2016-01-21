//
//  Utilities.swift
//  zipbooks-ios
//
//  Created by Francesco Pretelli on 11/01/16.
//  Copyright © 2016 Francesco Pretelli. All rights reserved.
//

import Foundation
class Utility {

    class func setToken(token:String) throws {
        NSUserDefaults.standardUserDefaults().setObject(token, forKey: "token")
    }
    
    class func getToken()->String{
        let token =  NSUserDefaults.standardUserDefaults().valueForKey("token") as? String
        return token == nil ?  "" :  token!
    }
    
    class func setUserEmail(email:String) throws {
        NSUserDefaults.standardUserDefaults().setObject(email, forKey: "email")
    }
    
    class func setUserName(username:String) throws {
        NSUserDefaults.standardUserDefaults().setObject(username, forKey: "username")
    }

    class func getUserEmail()->String{
        return  NSUserDefaults.standardUserDefaults().valueForKey("email") as! String
    }
    
    class func getUserName()->String{
        return  NSUserDefaults.standardUserDefaults().valueForKey("username") as! String
    }
    
    class func calculateTotal(quantity:String, rate:String) -> String {
        let quantityN = Double(quantity)
        let rateN = Double(rate)
        
        let total = rateN! * quantityN!
        return String(format:"%.2f",total)
    }
}