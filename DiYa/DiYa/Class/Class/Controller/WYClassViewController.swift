//
//  WYClassViewController.swift
//  DiYa
//
//  Created by wangyang on 2017/11/9.
//  Copyright © 2017年 wangyang. All rights reserved.
//

import UIKit
import YYModel

class WYClassViewController: WYBaseViewController {

    @IBOutlet weak var oneClassView: OneClassView!
    @IBOutlet weak var twoClassView: TwoClassView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "分类"
    }
}

extension WYClassViewController {
    func requestCategoryList() {
        WYNetWorkTool.share.request(url: "/goods/category.htm", dic: [:]) { (isSuccess, result) in
            if isSuccess {
                guard let dic = result as? [String:Any],
                    let json = dic["categoryList"],
                    let array = NSArray.yy_modelArray(with: CategoryModelList.self, json: json) else {
                    return
                }
                self.oneClassView.categoryMenu = array as? [CategoryModelList]
                
                guard let json1 = dic["categoryModelList"],
                    let array1 = NSArray.yy_modelArray(with: CategoryModel.self, json: json1) else {
                        return
                }
                self.twoClassView.categoryModel = array1 as? [CategoryModel]
                
                for (_,model) in array1.enumerated() {
                    print(model)
                }
                
            }
        }
    }
}
