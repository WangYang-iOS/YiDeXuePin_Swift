//
//  WYCommomMethod.swift
//  DiYa
//
//  Created by wangyang on 2017/9/28.
//  Copyright © 2017年 wangyang. All rights reserved.
//

import UIKit

class WYCommomMethod: NSObject {
    class func saveValue(value:String,key:String) {
        UserDefaults.standard.setValue(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    class func valueForKey(key:String) -> String {
        return UserDefaults.standard.value(forKey: key) as? String ?? ""
    }
}
