//
//  WYShopCartController.swift
//  DiYa
//
//  Created by wangyang on 2017/9/28.
//  Copyright © 2017年 wangyang. All rights reserved.
//

import UIKit

class WYShopCartController: WYBaseViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bottomHeight: NSLayoutConstraint!
    var goodsList = [ShopcartModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "购物车"
        bottomHeight.constant = tabBarController?.tabBar.frame.size.height ?? 49
        tableView.register(UINib.init(nibName: "YYShopcartCell", bundle: nil), forCellReuseIdentifier: "YYShopcartCell")
        requestShopcartData()
    }
}

extension WYShopCartController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "YYShopcartCell", for: indexPath) as! YYShopcartCell
        let list = goodsList[indexPath.section]
        cell.goodsModel = list.cartGoodsFormList[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = YYShopcartHeaderView.loadXib1() as! YYShopcartHeaderView
        headerView.frame = RECT(x: 0, y: 0, width: SCREEN_WIDTH, height: 44)
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

extension WYShopCartController {
    fileprivate func requestShopcartData() {
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
            self.tableView.reloadData()
        }
    }
}
