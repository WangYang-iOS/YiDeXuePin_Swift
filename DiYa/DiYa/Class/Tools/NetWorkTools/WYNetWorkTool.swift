//
//  WYNetWorkTool.swift
//  DiYa
//
//  Created by wangyang on 2017/9/28.
//  Copyright © 2017年 wangyang. All rights reserved.
//

import UIKit
import AFNetworking

class WYNetWorkTool: NSObject {
    class func startRequest(url:String,dic:[String:String],complete:(()->())?) {
        let baseUrl = URL(string: BASE_URL)
        let manager = AFHTTPSessionManager(baseURL: baseUrl, sessionConfiguration: URLSessionConfiguration.default)
        manager.requestSerializer.timeoutInterval = TIME_OUT
        manager.responseSerializer.acceptableContentTypes = NSSet(objects: "text/html","text/plain","application/json","text/json") as? Set<String>
        manager.post(url, parameters: dic, progress: { (progress) in
            //
        }, success: { (task, response) in
            //
            
        }) { (task, error) in
            //
        }
    }
}


