//
//  UserInfo.swift
//  DiYa
//
//  Created by wangyang on 2017/9/28.
//  Copyright © 2017年 wangyang. All rights reserved.
//

import Foundation

@objcMembers class UserInfo: NSObject {
    var accessToken = ""
    var address = ""
    var createTime = ""
    var deviceToken = ""
    var deviceType = ""
    var integrityStatus = ""
    var mobile = ""
    var nickname = ""
    var state = ""
    var tip = ""
    var type = ""
    var updateTime = ""
    var avatar = ""
    var sign = ""
    var birthday = ""
    var sex = ""
    var wechatUnionid = ""
    var weiboUnionid = ""
    var qqUnionid = ""
    var borrowBookStatus = ""

    var bookNumber = ""
    var deposit = ""
    var id = ""
    var membershipPoint = ""
    var memshipDiscount = ""
    var schoolId = ""
    var serverPointer = ""
    var discount = ""
    var borrowNumber = ""
    
    override var description: String {
        return self.yy_modelDescription()
    }
    
}
