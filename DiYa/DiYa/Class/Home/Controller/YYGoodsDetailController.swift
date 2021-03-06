//
//  YYGoodsDetailController.swift
//  DiYa
//
//  Created by wangyang on 2017/11/22.
//  Copyright © 2017年 wangyang. All rights reserved.
//

import UIKit
import WebKit
class YYGoodsDetailController: WYBaseViewController {
    @IBOutlet weak var scrollViewWidth: NSLayoutConstraint!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var goodsInfoView: YYGoodsInfoView!
    @IBOutlet weak var categoryView: YYGoodsCategoryView!
    @IBOutlet weak var goodsDesView: UIView!
    @IBOutlet weak var skuCategoryViewHeight: NSLayoutConstraint!
    @IBOutlet weak var addShopCartButton: UIButton!
    @IBOutlet weak var webViewHeight: NSLayoutConstraint!
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var soldButton: UIButton!
    var goodsId : String?
    var goodsModel = GoodsModel()
    var skuList = [SkuCategoryModel]()
    var skuArray = [GoodsSkuModel]()
    
    var isFavorite = false
    
    lazy var bannerView:YYBannerView! = {
        let bannerView = YYBannerView.loadNib()
        return bannerView
    }()
    lazy var webView : WKWebView! = {
        let webView = WKWebView(frame: CGRect(x: 0, y: 44, width: SCREEN_WIDTH, height: 100))
        webView.navigationDelegate = self
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollViewWidth.constant = SCREEN_WIDTH
        setUI()
        requestGoodsDetail()
        requestSkuData()
    }
    @IBAction func addShopCartButton(_ sender: UIButton) {
        //加入购物车
        YYGoodsManager.shareManagre.showGoodsSelectView(goodsModel:goodsModel, skuCategoryList: self.skuList, goodsSkuList: self.skuArray) { (skuValue, number) in
            //
            let dic = ["sku":skuValue,"goodsId":self.goodsModel.id,"number":number] as [String : Any]
            self.requestAddCart(dic: dic)
        }
    }
    @IBAction func buyButton(_ sender: UIButton) {
        //立即买入
        YYGoodsManager.shareManagre.showGoodsSelectView(goodsModel:goodsModel, skuCategoryList: self.skuList, goodsSkuList: self.skuArray) { (skuValue, number) in
            let dic = ["sku":skuValue,"goodsId":self.goodsModel.id,"number":number,"type":"goods"] as [String : Any]
            self.requestBuyGoods(dic: dic)
        }
    }
}
///UI
extension YYGoodsDetailController {
    fileprivate func setUI() {
        navigationItem.title = "商品详情"
        bannerView.frame = CGRect(x: 0, y: 0, width: topView.bounds.width, height: topView.bounds.height)
        topView.addSubview(bannerView)
        webView?.frame = CGRect(x: 0, y: 44, width: SCREEN_WIDTH, height: 100)
        goodsDesView.addSubview(webView)
    }
}
///响应事件
extension YYGoodsDetailController {
    override func clickRightButton() {
        requestFavorite()
    }
}

///接口
extension YYGoodsDetailController {
    ///请求商品详情
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
                if let evaluate = json["evaluate"] as? Int {
                    self.goodsInfoView.evaluate = String(describing: evaluate)
                }
                let thumb = json["thumb"] as? [String]
                self.bannerView.loadBanners(bannerList: thumb)
                
                guard let skuCategoryList = NSArray.yy_modelArray(with: SkuCategoryModel.self, json: json["skuCategoryList"] as Any) as? [SkuCategoryModel] else {
                    return
                }
                self.categoryView.skuCategoryList = skuCategoryList
                self.skuList = skuCategoryList
                
                self.skuCategoryViewHeight.constant = self.categoryView.lastViewHeight
                let urlStr = BASE_URL + "/goods/web/detail.htm?id=" + goodsModel.id
                guard let url = URL(string: urlStr) else{
                    return
                }
                self.webView.load(URLRequest(url: url))

                //判断是否已经收藏过
                guard let favorite = json["favorite"] as? Bool else {
                    return
                }
                self.isFavorite = favorite
                if favorite == true {
                    self.rightBarButton(imgStr: "icon_collect")
                }else {
                    self.rightBarButton(imgStr: "icon_noCollect")
                }
            }
        }
    }
    ///请求商品规格列表
    fileprivate func requestSkuData() {
        guard let goodsId = goodsId else {
            return
        }
        WYNetWorkTool.share.request(url: "/goods/sku_list.htm", dic: ["id":goodsId]) { (success, result) in
            if success {
                //
                guard let result = result,
                    let json = result["data"] as? [String:Any],
                    let goodsSkuList = json["goodsSkuList"],
                    let array = NSArray.yy_modelArray(with: GoodsSkuModel.self, json: goodsSkuList) as? [GoodsSkuModel] else {
                        return
                }
                self.skuArray = array;
            }
        }
    }
    ///请求是否收藏
    fileprivate func requestFavorite() {
        SHOW_PROGRESS(view: view)
        WYNetWorkTool.share.request(url: "/goods/favorite.htm", dic: ["id":goodsModel.id]) { (success, result) in
            //
            HIDDEN_PROGRESS(view: self.view)
            if success {
                self.isFavorite = !self.isFavorite
                if self.isFavorite == true {
                    self.rightBarButton(imgStr: "icon_collect")
                }else {
                    self.rightBarButton(imgStr: "icon_noCollect")
                }
            }
        }
    }
    ///请求加入购物车
    fileprivate func requestAddCart(dic:[String:Any]) {
        SHOW_PROGRESS(view: view)
        WYNetWorkTool.share.request(url: "/cart/add.htm", dic: dic) { (success, result) in
            HIDDEN_PROGRESS(view: self.view)
            if success {
                YYGoodsManager.shareManagre.hiddenSelectView()
            }
        }
    }
    ///请求立即购买
    fileprivate func requestBuyGoods(dic:[String:Any]) {
        SHOW_PROGRESS(view: view)
        WYNetWorkTool.share.request(url: "/order/preview.htm", dic: dic) { (success, result) in
            HIDDEN_PROGRESS(view: self.view)
            if success {
                YYGoodsManager.shareManagre.hiddenSelectView()
            }
        }
    }
}

extension YYGoodsDetailController : WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        //通过js获取webview高度
        webView.evaluateJavaScript("document.body.scrollHeight") { (result, error) in
            guard let result = result as? CGFloat else {
                return
            }
            self.webViewHeight.constant = 44.0 + result
            self.webView.frame = CGRect(x: 0, y: 44, width: SCREEN_WIDTH, height: result)
        }
    }
}

