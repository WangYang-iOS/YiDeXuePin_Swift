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

    @IBOutlet weak var layout: UICollectionViewFlowLayout!
    @IBOutlet weak var collectionView: UICollectionView!
    var vcTitle:String?
    var categoryId : String?
    var goodsList = [GoodsModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        requestGoodsList()
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
            self.requestGoodsList()
        })
        collectionView.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: {
            self.requestGoodsList()
        })
    }
}

extension YYClassListViewController {
    func requestGoodsList() {
        SHOW_PROGRESS(view: view)
        guard let categoryId = self.categoryId else {
            return
        }
        let dic = ["type":"category","pageNum":"\(self.pageNumber)","category":categoryId]
        WYNetWorkTool.share.request(url: "/goods/category/goods_list.htm", dic: dic) { (success, result) in
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
