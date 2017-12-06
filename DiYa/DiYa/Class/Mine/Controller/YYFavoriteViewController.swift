//
//  YYFavoriteViewController.swift
//  DiYa
//
//  Created by wangyang on 2017/11/24.
//  Copyright © 2017年 wangyang. All rights reserved.
//

import UIKit
import MJRefresh

class YYFavoriteViewController: WYBaseViewController {

    @IBOutlet weak var layout: UICollectionViewFlowLayout!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var favoriteList = [GoodsModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "我的收藏"
        setUI()
        requestFavoriteList()
    }
}

extension YYFavoriteViewController {
    func setUI() {
        let width = (SCREEN_WIDTH - 10) / 2.0
        layout.estimatedItemSize = CGSize(width: width, height: 400)
        collectionView.register(UINib.init(nibName: "YYFavoriteCell", bundle: nil), forCellWithReuseIdentifier: "YYFavoriteCell")
        collectionView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            self.pageNumber = 0
            self.requestFavoriteList()
        })
        collectionView.mj_footer = MJRefreshBackNormalFooter.init(refreshingBlock: {
            self.requestFavoriteList()
        })
    }
}

extension YYFavoriteViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "YYFavoriteCell", for: indexPath) as! YYFavoriteCell
        cell.goodsModel = favoriteList[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteList.count
    }
}

extension YYFavoriteViewController {
    func requestFavoriteList() {
        WYNetWorkTool.share.request(url: "/user/favorite/goods.htm", dic: ["pageNum":self.pageNumber]) { (success, result) in
            if success {
                if self.pageNumber == 0 {
                    self.favoriteList.removeAll()
                    self.collectionView.reloadData()
                }
                guard let result = result,
                    let page = result["totalPage"] as? String,
                    let totalPage = Int(page),
                    let array = result["data"] as? [Any] else {
                        return
                }
                if self.pageNumber == 0 && totalPage == 0 {
                    self.collectionView.mj_footer.endRefreshingWithNoMoreData()
                }else if self.pageNumber == totalPage - 1 {
                    self.collectionView.mj_footer.endRefreshingWithNoMoreData()
                }else {
                    self.collectionView.mj_footer.endRefreshing()
                    self.pageNumber += 1
                }
                guard let list = NSArray.yy_modelArray(with: GoodsModel.self, json: array) as? [GoodsModel] else {
                    return
                }
                self.favoriteList = self.favoriteList + list
            }
            self.collectionView.mj_header.endRefreshing()
            self.collectionView.reloadData()
        }
    }
}
