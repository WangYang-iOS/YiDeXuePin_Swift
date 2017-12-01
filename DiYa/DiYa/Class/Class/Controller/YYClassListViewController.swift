//
//  YYClassListViewController.swift
//  DiYa
//
//  Created by wangyang on 2017/11/29.
//  Copyright © 2017年 wangyang. All rights reserved.
//

import UIKit

class YYClassListViewController: WYBaseViewController {

    @IBOutlet weak var layout: UICollectionViewFlowLayout!
    @IBOutlet weak var collectionView: UICollectionView!
    var vcTitle:String?
    var categoryId : String?
    var goodsList = [GoodsModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        guard let categoryId = categoryId else {
            return
        }
        requestGoodsList(dic: ["type":"category","pageNum":"\(pageNumber)","category":categoryId])
    }
}

extension YYClassListViewController {
    fileprivate func setUI() {
        navigationItem.title = vcTitle
        leftBarButton()
        let width = (SCREEN_WIDTH - 10) / 2.0
        layout.estimatedItemSize = CGSize(width: width, height: 400)
        collectionView.register(UINib.init(nibName: "YYFavoriteCell", bundle: nil), forCellWithReuseIdentifier: "YYFavoriteCell")
    }
}

extension YYClassListViewController {
    func requestGoodsList(dic:[String:Any]) {
        SHOW_PROGRESS(view: view)
        WYNetWorkTool.share.request(url: "/goods/category/goods_list.htm", dic: dic) { (success, result) in
            HIDDEN_PROGRESS(view: self.view)
            if success {
                guard let result = result,
                let dic = result["data"],
                let list = NSArray.yy_modelArray(with: GoodsModel.self, json: dic) as? [GoodsModel] else {
                    return
                }
                self.goodsList = self.goodsList + list
                print(list)
            }
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
