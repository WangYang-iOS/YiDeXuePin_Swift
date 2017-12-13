//
//  HomeModel.swift
//  DiYa
//
//  Created by wangyang on 2017/11/8.
//  Copyright © 2017年 wangyang. All rights reserved.
//

import Foundation

@objcMembers class HomeModel: NSObject {
    var categoryName = ""
    var category = ""
    var goodsList = [GoodsModel]()
    var announcement = AnnouncementModel()
    
    override var description: String {
        return self.yy_modelDescription()
    }
    
    /// MJExtension中解析嵌套数组类型需要加上该方法
    ///
    /// - Returns: returns
    override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["goodsList":GoodsModel.self]
    }
    
    /// yymodel中解析嵌套数组类型需要加上该方法
    ///
    /// - Returns: returns
    static func modelContainerPropertyGenericClass() -> [AnyHashable : Any]! {
        return ["goodsList":GoodsModel.self]
    }
}

@objcMembers class GoodsModel: NSObject {
    var category = ""
    var id = ""
    var marketPrice = ""
    var picture = ""
    var price = ""
    var title = ""
    var sales = ""
    
    var name = ""
    var isHot = ""
    var sort = ""
    var parentId = ""
    var isSelected : Bool = false
    
    override var description: String {
        return self.yy_modelDescription()
    }
}

@objcMembers class AnnouncementModel: NSObject {
    var goodsId = ""
    var id = ""
    var jumpUrl = ""
    var picture = ""
    var type = ""
    var title = ""
    override var description: String {
        return self.yy_modelDescription()
    }
}

@objcMembers class CategoryModelList: NSObject {
    var id = ""
    var isHot = ""
    var sort = ""
    var name = ""
    var picture = ""
    var isSelected : Bool = false
    
    override var description: String {
        return self.yy_modelDescription()
    }
}

@objcMembers class CategoryModel:NSObject {
    var id = ""
    var parentId = ""
    var name = ""
    var goodsCategoryList = [GoodsModel]()
    
    override var description: String {
        return self.yy_modelDescription()
    }
    
    override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["goodsList":GoodsModel.self]
    }
    
    static func modelContainerPropertyGenericClass() -> [AnyHashable : Any]! {
        return ["goodsCategoryList":GoodsModel.self]
    }
}

@objcMembers class SkuCategoryModel: NSObject {
    var value = ""
    var name = ""
    override var description: String {
        return self.yy_modelDescription()
    }
}
