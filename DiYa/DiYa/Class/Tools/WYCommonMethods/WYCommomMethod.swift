//
//  WYCommomMethod.swift
//  DiYa
//
//  Created by wangyang on 2017/9/28.
//  Copyright © 2017年 wangyang. All rights reserved.
//

import UIKit

class WYCommomMethod: NSObject {
    class func saveValue(value:Any?,key:String) {
        UserDefaults.standard.setValue(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    class func valueForKey(key:String) -> Any? {
        return UserDefaults.standard.value(forKey: key)
    }
}
