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
import ReachabilitySwift


let IPHONE_6_SCREEN_WIDTH = 750

class Utility {

    
    class func setToken(_ token:String) throws {
        UserDefaults.standard.set(token, forKey: "token")
    }
    
    class func getToken()->String{
        let token =  UserDefaults.standard.value(forKey: "token") as? String
        return token == nil ?  "" :  token!
    }
    
    class func setUserEmail(_ email:String) throws {
        UserDefaults.standard.set(email, forKey: "email")
    }
    
    class func setUserName(_ username:String) throws {
        UserDefaults.standard.set(username, forKey: "username")
    }

    class func getUserEmail()->String{
        return  UserDefaults.standard.value(forKey: "email") as! String
    }
    
    class func getUserName()->String{
        return  UserDefaults.standard.value(forKey: "username") as! String
    }
    
    class func calculateTotal(_ quantity:String, rate:String) -> String {
        let quantityN = Double(quantity)
        let rateN = Double(rate)
        
        let total = rateN! * quantityN!
        return String(format:"%.2f",total)
    }
    
    class func getDefaultGrayColor() -> UIColor {
        return UIColor(hex:0x3D3D3D)
    }
    
    class func getScreenWidth()->Int{
        return Int(UIScreen.main.bounds.width)
    }
    
    class func getMainColor() -> UIColor {
        return UIColor(hex:0x005192)
    }
}
/*
open class Reachability {
    class func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
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
}*/


class Connectivity: NSObject { 
    
    static let sharedInstance = Connectivity() // singleton lazy initialization, apple supports it sice swift 1.2
    var reachability = Reachability()!
    
    override init() {
        super.init()
        getReachability()
    }
    
    func getReachability() {
        reachability = Reachability.init()!
    }
    
    func startMonitor() {
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
        monitorConnectivity()
    }
    
    deinit {
        self.reachability.stopNotifier()
    }
    
    func isConnected() -> Bool {
        switch self.reachability.currentReachabilityStatus {
        case .notReachable:
            return false
        case .reachableViaWiFi:
            return true
        case .reachableViaWWAN:
            return true
        }
    }
    
    func isOnMobileConnection() -> Bool {
        switch self.reachability.currentReachabilityStatus {
        case .notReachable:
            return false
        case .reachableViaWiFi:
            return false
        case .reachableViaWWAN:
            return true
        }
    }
    
    func monitorConnectivity() {
        self.reachability.whenReachable = { reachability in
            DispatchQueue.main.async {
                if self.reachability.isReachableViaWiFi {
                    print("Reachable via WiFi")
                } else {
                   print("Reachable via Cellular")
                }
            }
        }
        
        self.reachability.whenUnreachable = { reachability in
            DispatchQueue.main.async {
                print("Not reachable")
            }
        }
    }
}
