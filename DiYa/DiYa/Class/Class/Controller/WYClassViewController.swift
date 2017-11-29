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
    var categoryList : [CategoryModelList]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "分类"
        oneClassView.delegate = self
        twoClassView.delegate = self
    }
}

extension WYClassViewController {
    func requestCategoryList() {
        SHOW_PROGRESS(view: view)
        WYNetWorkTool.share.request(url: "/goods/category.htm", dic: [:]) { (isSuccess, result) in
            HIDDEN_PROGRESS(view: self.view)
            if isSuccess {
                guard let result = result,
                    let dic = result["data"] as? [String:Any] else {
                        return
                }
                
                guard let json = dic["categoryList"],
                    let array = NSArray.yy_modelArray(with: CategoryModelList.self, json: json) else {
                    return
                }
                self.oneClassView.categoryMenu = array as? [CategoryModelList]
                self.categoryList = array as? [CategoryModelList]
                
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
    
    ///根据一级分类获取二级分类
    
    func requestTwoClassViewData(dic:[String:Any]) {
        SHOW_PROGRESS(view: view)
        WYNetWorkTool.share.request(url: "/goods/category/info.htm", dic: dic) { (success, result) in
            HIDDEN_PROGRESS(view: self.view)
            if success {
                guard let result = result,
                    let dic = result["data"] as? [String:Any],
                    let json = dic["categoryModelList"],
                    let array = NSArray.yy_modelArray(with: CategoryModel.self, json: json) else {
                        return
                }
                self.twoClassView.categoryModel = array as? [CategoryModel]
            }
        }
    }
}

extension WYClassViewController:OneClassViewDelegate,TwoClassViewDelegate {
    func oneClassViewDidSelectedCell(index: Int) {
        
        guard let array = categoryList else {
            return
        }
        
        let model = array[index]
        requestTwoClassViewData(dic: ["parentId":model.id])
    }
    
    func collectionViewCell(collectionViewCell: TwoClassCell?, didSelectedItemAt index: Int) {
        //
        
        let listVC = YYClassListViewController()
        listVC.vcTitle = collectionViewCell?.goodsModel?.name
        listVC.categoryId = collectionViewCell?.goodsModel?.id
        navigationController?.pushViewController(listVC, animated: true)
    }
}
