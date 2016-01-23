//
//  Utilities.swift
//  zipbooks-ios
//
//  Created by Francesco Pretelli on 11/01/16.
//  Copyright © 2016 Francesco Pretelli. All rights reserved.
//

import Foundation
import UIKit
import SystemConfiguration

let IPHONE_6_SCREEN_WIDTH = 750

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
    
    class func getDefaultGrayColor() -> UIColor {
        return UIColor(hex:0x3D3D3D)
    }
    
    class func getScreenWidth()->Int{
        return Int(UIScreen.mainScreen().bounds.width)
    }
}

public class Reachability {
    class func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(&zeroAddress) {
            SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0))
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
}