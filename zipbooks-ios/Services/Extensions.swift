//
//  Extensions.swift
//  zipbooks-ios
//
//  Created by Francesco Pretelli on 14/01/16.
//  Copyright © 2016 Francesco Pretelli. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift
import ObjectMapper

// Based on Swift 1.2, ObjectMapper 0.15, RealmSwift 0.94.1
// Author: Timo Wälisch <timo@waelisch.de>

class ArrayTransform<T:RealmSwift.Object> : TransformType where T:Mappable {
    typealias Object = List<T>
    typealias JSON = Array<AnyObject>
    
    func transformFromJSON(_ value: Any?) -> List<T>? {
        let realmList = List<T>()
        
        if let jsonArray = value as? Array<Any> {
            for item in jsonArray {
                if let realmModel = Mapper<T>().map(JSONObject: item) {
                    realmList.append(realmModel)
                }
            }
        }
        
        return realmList
    }
    
    func transformToJSON(_ value: List<T>?) -> Array<AnyObject>? {
        
        guard let realmList = value, realmList.count > 0 else { return nil }
        
        var resultArray = Array<T>()
        
        for entry in realmList {
            resultArray.append(entry)
        }
        
        return resultArray
    }
}


extension UIColor {
    convenience init(hex: UInt) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

extension String {
    func toDouble() -> Double {
        if let myNumber = NumberFormatter().number(from: self) {
            return myNumber.doubleValue
        } else {
            return 0
        }
    }
}

extension UINavigationController {
    
    open override var childViewControllerForStatusBarHidden : UIViewController? {
        return self.topViewController
    }
    
    open override var childViewControllerForStatusBarStyle : UIViewController? {
        return self.topViewController
    }
}

extension Date {

    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
    }
}
