//
//  WYNetWorkTool.swift
//  DiYa
//
//  Created by wangyang on 2017/9/28.
//  Copyright © 2017年 wangyang. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MBProgressHUD

class WYNetWorkTool {
    
    static let share = WYNetWorkTool.init()
    
    private init() {
        //
    }
    
    func request(url:String,dic:[String:Any],callBack:@escaping (_ isSuccess:Bool,_ response:Any?)->()) -> () {
        Alamofire.request(BASE_URL + url, method: .post, parameters: dic, encoding: URLEncoding.default).responseJSON { (response) in
            switch response.result.isSuccess {
            case true:
                if let value = response.result.value {
                    let dic = value as? [String:Any]
                    let result = dic?["data"] 
                    callBack(true, result);
                }
            case false:
                callBack(false,["error":response.result.error as Any])
                print(response.result.error ?? "网络错误")
            }
        }
    }
}


//class WYNetWorkTool: AFHTTPSessionManager {
//
//    static let shareManager : WYNetWorkTool = {
//        let manager = WYNetWorkTool()
//        manager.requestSerializer.timeoutInterval = TIME_OUT
//        manager.responseSerializer.acceptableContentTypes = NSSet(objects: "text/html","text/plain","application/json","text/json") as? Set<String>
//       return manager
//    }()
//
//    class func startRequest(url:String,dic:[String:String],complete:((_ isSuccess:Bool,_ response:Any?)->())?) {
//
//        let urlString = BASE_URL + url
//
//        let dictionary = WYNetWorkTool.shareManager.addAdditionalParams(dic: dic)
//
//        print("请求参数：\(dictionary)")
//        WYNetWorkTool.shareManager.post(urlString, parameters: dic, progress: { (progress) in
//            //
//        }, success: { (task, response) in
//            //
//            let dic = response as? [String:Any] ?? [:]
//            if dic["retCode"] as? String ?? "" == "0" {
//                complete?(true,response)
//                print("请求成功：\(String(describing: response))")
//            }
//
//        }) { (task, error) in
//            //
//            complete?(false,nil)
//            print("请求失败：\(error)")
//        }
//    }
//
//    fileprivate func addAdditionalParams( dic:[String:String]) -> [String:String]{
//        var dic = dic
//        let accessToken = WYCommomMethod.valueForKey(key: ACCESS_TOKEN)
//        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
//        let deviceToken = WYCommomMethod.valueForKey(key: DEVICE_TOKEN)
//        if accessToken.characters.count > 0 {
//            dic[ACCESS_TOKEN] = accessToken
//        }
//        if version.characters.count > 0 {
//            dic[CURRENT_VERSION] = version
//        }
//        if deviceToken.characters.count > 0 {
//            dic[DEVICE_TOKEN] = deviceToken
//        }
//        dic[APP_SOURCE] = "iOS"
//        dic[DEVICE_ID] = "iOS"
//        return dic
//    }
//}

