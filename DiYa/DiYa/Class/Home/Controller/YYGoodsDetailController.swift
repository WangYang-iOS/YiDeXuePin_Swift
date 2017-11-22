//
//  YYGoodsDetailController.swift
//  DiYa
//
//  Created by wangyang on 2017/11/22.
//  Copyright © 2017年 wangyang. All rights reserved.
//

import UIKit

class YYGoodsDetailController: WYBaseViewController {
    @IBOutlet weak var addShopCartButton: UIButton!
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var soldButton: UIButton!
    var goodsId : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigation()
    }
    @IBAction func addShopCartButton(_ sender: UIButton) {
    }
    @IBAction func buyButton(_ sender: UIButton) {
    }
}

extension YYGoodsDetailController {
    fileprivate func navigation() {
        navigationItem.title = "商品详情"
        leftBarButton()
    }
}
