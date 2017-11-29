//
//  YYGoodsDetailController.swift
//  DiYa
//
//  Created by wangyang on 2017/11/22.
//  Copyright © 2017年 wangyang. All rights reserved.
//

import UIKit

class YYGoodsDetailController: WYBaseViewController {
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var addShopCartButton: UIButton!
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var soldButton: UIButton!
    var goodsId : String?
    var pics = [String]()
    
    lazy var bannerView:YYBannerView! = {
        let bannerView = YYBannerView.loadNib()
        return bannerView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "商品详情"
        bannerView.frame = CGRect(x: 0, y: 0, width: topView.bounds.width, height: topView.bounds.height)
        topView.addSubview(bannerView)
        bannerView.loadBanners(bannerList: pics)
    }
    @IBAction func addShopCartButton(_ sender: UIButton) {
    }
    @IBAction func buyButton(_ sender: UIButton) {
    }
}

