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
    @IBOutlet weak var goodsInfoView: YYGoodsInfoView!
    @IBOutlet weak var categoryView: YYGoodsCategoryView!
    @IBOutlet weak var skuCategoryViewHeight: NSLayoutConstraint!
    @IBOutlet weak var addShopCartButton: UIButton!
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var soldButton: UIButton!
    var goodsId : String?
    var pics = [String]()
    var goodsModel = GoodsModel()
    lazy var bannerView:YYBannerView! = {
        let bannerView = YYBannerView.loadNib()
        return bannerView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        requestGoodsDetail()
//        bannerView.loadBanners(bannerList: pics)
    }
    @IBAction func addShopCartButton(_ sender: UIButton) {
    }
    @IBAction func buyButton(_ sender: UIButton) {
    }
}

extension YYGoodsDetailController {
    fileprivate func setUI() {
        navigationItem.title = "商品详情"
        bannerView.frame = CGRect(x: 0, y: 0, width: topView.bounds.width, height: topView.bounds.height)
        topView.addSubview(bannerView)
    }
}

extension YYGoodsDetailController {
    fileprivate func requestGoodsDetail() {
        guard let goodsId = goodsId else {
            return
        }
        WYNetWorkTool.share.request(url: "/goods/detail.htm", dic: ["id":goodsId]) { (success, result) in
            if success {
                guard let result = result,
                let json = result["data"] as? [String: Any] else {
                        return
                }
                guard let goodsModel = GoodsModel.yy_model(withJSON: json["goods"] as Any) else {
                    return
                }
                self.goodsModel = goodsModel
                self.goodsInfoView.goodsModel = goodsModel;
                self.goodsInfoView.evaluate = json["evaluate"] as? String
                let thumb = json["thumb"] as? [String]
                self.bannerView.loadBanners(bannerList: thumb)
                
                guard let skuCategoryList = NSArray.yy_modelArray(with: SkuCategoryModel.self, json: json["skuCategoryList"] as Any) as? [SkuCategoryModel] else {
                    return
                }
                self.categoryView.skuCategoryList = skuCategoryList
                self.skuCategoryViewHeight.constant = self.categoryView.lastViewHeight
            }
        }
    }
}
