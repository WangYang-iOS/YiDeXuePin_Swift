//
//  YYClassListViewController.swift
//  DiYa
//
//  Created by wangyang on 2017/11/29.
//  Copyright © 2017年 wangyang. All rights reserved.
//

import UIKit
import MJRefresh
class YYClassListViewController: WYBaseViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    @IBOutlet weak var layout: UICollectionViewFlowLayout!
    @IBOutlet weak var collectionView: UICollectionView!
    
    fileprivate lazy var bannerView : YYBannerScrollView = {
        let bannerView = YYBannerScrollView.loadXib()
        bannerView.backgroundColor = UIColor.hexString(colorString: COLOR_BACKGROUND)
        bannerView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 45)
        bannerView.delegate = self
        return bannerView
    }()
    
    fileprivate lazy var allClassView : YYAllClassView = {
       let classView = YYAllClassView.loadXib1() as! YYAllClassView
        classView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 0)
        classView.isHidden = true
        classView.delegate = self
        return classView
    }()
    
    var vcTitle:String?
    var categoryId : String?
    var type = ""
    
    var goodsList = [GoodsModel]()
    var classList : [GoodsModel]? {
        didSet {
            var titleArray = [String]()
            guard let classList = classList else {
                return
            }
            for (_,model) in classList.enumerated() {
                print(model.isSelected)
                titleArray.append(model.name)
            }
            bannerView.titleArray = titleArray
            allClassView.titleArray = classList
            var line = titleArray.count / 4
            if line != 0 {
                line = line + 1
            }
            let height = line * (25 + 20) - 20 + 14 + 51
            allClassView.frame.size.height = CGFloat(height)
        }
    }
    var index : Int? {
        didSet {
            bannerView.index = index;
            allClassView.index = index
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
}

extension YYClassListViewController {
    fileprivate func setUI() {
        navigationItem.title = vcTitle
        leftBarButton()
        let width = (SCREEN_WIDTH - 10) / 2.0
        layout.estimatedItemSize = CGSize(width: width, height: 400)
        collectionView.register(UINib.init(nibName: "YYFavoriteCell", bundle: nil), forCellWithReuseIdentifier: "YYFavoriteCell")
        collectionView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            self.pageNumber = 0
            self.requestGoodsList(categoryId: self.categoryId ?? "")
        })
        collectionView.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: {
            self.requestGoodsList(categoryId: self.categoryId ?? "")
        })
        if type == "indexCategory" {
            topViewHeight.constant = 0
            requestGoodsList(categoryId: categoryId ?? "")
        }else {
            topViewHeight.constant = 45
            topView.addSubview(bannerView)
            view.addSubview(allClassView)
        }
    }
}

extension YYClassListViewController {
    func requestGoodsList(categoryId:String) {
        SHOW_PROGRESS(view: view)
        var url = ""
        if type == "category" {
            url = "/goods/category/goods_list.htm"
        }else {
            url = "/goods/category/goods_list.htm"
        }
        let dic = ["type":type,"pageNum":"\(self.pageNumber)","category":categoryId]
        WYNetWorkTool.share.request(url: url, dic: dic) { (success, result) in
            HIDDEN_PROGRESS(view: self.view)
            if success {
                if self.pageNumber == 0 {
                    self.goodsList.removeAll()
                }
                guard let result = result,
                let dic = result["data"],
                let page = result["totalPage"] as? String,
                let totalPage = Int(page),
                let list = NSArray.yy_modelArray(with: GoodsModel.self, json: dic) as? [GoodsModel] else {return}
                if totalPage == 0 && self.pageNumber == 0 {
                    self.collectionView.mj_footer.endRefreshingWithNoMoreData()
                }else if self.pageNumber == totalPage - 1  {
                    self.collectionView.mj_footer.endRefreshingWithNoMoreData()
                }else {
                    self.pageNumber += 1
                    self.collectionView.mj_footer.endRefreshing()
                }
                self.goodsList = self.goodsList + list
                print(list)
            }
            self.collectionView.mj_header.endRefreshing()
            self.collectionView.reloadData()
        }
    }
}

extension YYClassListViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "YYFavoriteCell", for: indexPath) as! YYFavoriteCell;
        cell.goodsModel = goodsList[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return goodsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = YYGoodsDetailController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension YYClassListViewController:YYBannerScrollViewDelegate {
    func bannerScrollViewclickIndex(index: Int) {
        guard let model = classList?[index] else {
            return
        }
        if self.categoryId == model.id {
            return
        }
        self.pageNumber = 0
        self.categoryId = model.id
        requestGoodsList(categoryId: model.id)
    }
    
    func openClassView() {
        allClassView.isHidden = false
    }
}

extension YYClassListViewController {
    fileprivate func showClassView() {
        //
        
        
    }
    fileprivate func hiddenClassView() {
        //
    }
}

extension YYClassListViewController : YYAllClassViewDelegate {
    func classViewClickIndex(index: Int) {
        self.index = index
    }
}
