//
//  WYShopCartController.swift
//  DiYa
//
//  Created by wangyang on 2017/9/28.
//  Copyright © 2017年 wangyang. All rights reserved.
//

import UIKit
import MJRefresh

class WYShopCartController: WYBaseViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bottomHeight: NSLayoutConstraint!
    @IBOutlet weak var bottomView: YYShopcartBottomView!
    
    var goodsList = [ShopcartModel]()
    var price : CGFloat = 0
    var isEditingShopCart: Bool = false {
        didSet {
            bottomView.isEditing = isEditingShopCart
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
}

extension WYShopCartController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isEditingShopCart {
            let cell = tableView.dequeueReusableCell(withIdentifier: "YYEditShopCartCell", for: indexPath) as! YYEditShopCartCell
            cell.delegate = self
            let list = goodsList[indexPath.section]
            cell.goodsModel = list.cartGoodsFormList[indexPath.row]
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "YYShopcartCell", for: indexPath) as! YYShopcartCell
            cell.delegate = self
            let list = goodsList[indexPath.section]
            cell.goodsModel = list.cartGoodsFormList[indexPath.row]
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
        let model = goodsList[indexPath.section].cartGoodsFormList[indexPath.row]
        let vc = YYGoodsDetailController()
        vc.goodsId = model.id
        navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = YYShopcartHeaderView.loadXib1() as! YYShopcartHeaderView
        headerView.frame = RECT(x: 0, y: 0, width: SCREEN_WIDTH, height: 44)
        headerView.delegate = self
        headerView.shopCarModel = goodsList[section]
        return headerView
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let list = goodsList[section]
         return list.cartGoodsFormList.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return goodsList.count
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
         return 0.01
    }
}
///设置UI 下拉刷新
extension WYShopCartController {
    fileprivate func setUI() {
        navigationItem.title = "购物车"
        rightBarButton(title: "编辑")
        isEditingShopCart = false
        bottomHeight.constant = tabBarController?.tabBar.frame.size.height ?? 49
        bottomView.delegate = self
        bottomView.price = "0.00"
        tableView.register(UINib.init(nibName: "YYShopcartCell", bundle: nil), forCellReuseIdentifier: "YYShopcartCell")
        tableView.register(UINib.init(nibName: "YYEditShopCartCell", bundle: nil), forCellReuseIdentifier: "YYEditShopCartCell")
        requestShopcartData()
        tableView.mj_header = MJRefreshStateHeader.init(refreshingBlock: {
            self.requestShopcartData()
        })
    }
    ///计算选中的商品总价
    fileprivate func refreshSelectedprice() {
        price = 0
        for (_,shopcartModel) in goodsList.enumerated() {
            if shopcartModel.isSelected {
                for (_,goodsModel) in shopcartModel.cartGoodsFormList.enumerated() {
                    price = price + CGFloat((goodsModel.discountPrice as NSString).floatValue * (goodsModel.number as NSString).floatValue)
                }
            }else {
                for (_,goodsModel) in shopcartModel.cartGoodsFormList.enumerated() {
                    if goodsModel.isSelected {
                        price = price + CGFloat((goodsModel.discountPrice as NSString).floatValue * (goodsModel.number as NSString).floatValue)
                    }
                }
            }
        }
        bottomView.price = String(format: "%.2f", price)
        refreshBottomSelectedButton()
    }
    
    fileprivate func refreshBottomSelectedButton() {
        var allSelected = true
        for (_,shopcartModel) in goodsList.enumerated() {
            if !shopcartModel.isSelected {
                allSelected = false
            }
        }
        bottomView.allSelected = allSelected
    }
}
///请求数据
extension WYShopCartController {
    func requestShopcartData() {
        SHOW_PROGRESS(view: view)
        WYNetWorkTool.share.request(url: "/cart/list.htm", dic: [:]) { (success, result) in
            HIDDEN_PROGRESS(view: self.view)
            if success {
                guard
                let result = result,
                let json = result["data"],
                let array = NSArray.yy_modelArray(with: ShopcartModel.self, json: json) as? [ShopcartModel] else {
                    return
                }
                self.goodsList = array
            }
            self.tableView.mj_header.endRefreshing()
            self.tableView.reloadData()
        }
    }
}

extension WYShopCartController : YYShopcartHeaderViewDelegate {
    func didClickCategory(shopcartModel: ShopcartModel) {
        shopcartModel.isSelected = !shopcartModel.isSelected
        //更改该分区全部商品的选中状态
        for (_,goodsModel) in shopcartModel.cartGoodsFormList.enumerated() {
            goodsModel.isSelected = shopcartModel.isSelected
        }
        tableView.reloadData()
        refreshSelectedprice()
    }
    func didSelectedCategory(categoryId: String) {
        let vc = YYClassListViewController()
        vc.categoryId = categoryId
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension WYShopCartController : YYShopcartCellDelegate {
    func didSelectCell(goodsModel: GoodsModel) {
        goodsModel.isSelected = !goodsModel.isSelected
        ///遍历购物车数组，判断每个分区商品是否全部选中
        for (_,shopcartModel) in goodsList.enumerated() {
            //设置一个遍历，标记该分区是否全选
            var allSelected = true
            for (_,model) in shopcartModel.cartGoodsFormList.enumerated() {
                //如果点击的商品是这个分区下
                if model == goodsModel {
                    //则先判断是否选中，如果没有选中，则该分区不是全选状态
                    if goodsModel.isSelected == false {
                        shopcartModel.isSelected = false
                        allSelected = false
                    }
                }else {
                    //如果点击的商品和遍历的商品不是同一个 ，则先判断是否选中，如果不是，则该分区并不是全部选中状态
                    if model.isSelected == false {
                        allSelected = false
                    }
                }
            }
            //将上述过程产生的标记赋值给该分区
            shopcartModel.isSelected = allSelected
        }
        //刷新表格
        tableView.reloadData()
        refreshSelectedprice()
    }
}

extension WYShopCartController : YYEditShopCartCellDelegate {
    func didSelectedGoods(goodsModel: GoodsModel) {
        goodsModel.isSelected = !goodsModel.isSelected
        ///遍历购物车数组，判断每个分区商品是否全部选中
        for (_,shopcartModel) in goodsList.enumerated() {
            //设置一个标记，标记该分区是否全选
            var allSelected = true
            for (_,model) in shopcartModel.cartGoodsFormList.enumerated() {
                //如果点击的商品是这个分区下
                if model == goodsModel {
                    //则先判断是否选中，如果没有选中，则该分区不是全选状态
                    if goodsModel.isSelected == false {
                        shopcartModel.isSelected = false
                        allSelected = false
                    }
                }else {
                    //如果点击的商品和遍历的商品不是同一个 ，则先判断是否选中，如果不是，则该分区并不是全部选中状态
                    if model.isSelected == false {
                        allSelected = false
                    }
                }
            }
            //将上述过程产生的标记赋值给该分区
            shopcartModel.isSelected = allSelected
        }
        //刷新表格
        tableView.reloadData()
        refreshSelectedprice()
    }
    func didSelectedCategory(goodsModel: GoodsModel) {
        //选择分类
    }
}

extension WYShopCartController : YYShopcartBottomViewDelegate {
    func didAllSelectedGoods(isSelected: Bool) {
        for (_,shopcartModel) in goodsList.enumerated() {
            shopcartModel.isSelected = isSelected
            for (_,goodsModel) in shopcartModel.cartGoodsFormList.enumerated() {
                goodsModel.isSelected = shopcartModel.isSelected
            }
        }
        tableView.reloadData()
        refreshSelectedprice()
    }
    func didCommitOrder() {
        //
    }
    func didClickDeleteGoods() {
        //
    }
    
    func didClickFavorateGoods() {
        //
    }
}

extension WYShopCartController {
    override func clickRightButton() {
        isEditingShopCart = !isEditingShopCart
        if isEditingShopCart {
            rightBarButton(title: "完成")
        }else {
            rightBarButton(title: "编辑")
        }
        tableView.reloadData()
    }
}
