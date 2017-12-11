//
//  WYHomeViewController.swift
//  DiYa
//
//  Created by wangyang on 2017/9/26.
//  Copyright © 2017年 wangyang. All rights reserved.
//

import UIKit
import YYModel
import MJRefresh

class WYHomeViewController: WYBaseViewController {
    var tableView: UITableView!
    var listArray = [HomeModel]()
    var pics = [String]()
    
    lazy var bannerView : YYBannerView! = {
        let bannerView = YYBannerView.loadNib()
        bannerView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 200)
        return bannerView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        setUI()
        homeData()
        NotificationCenter.default.addObserver(self, selector: #selector(clickGoods), name: NSNotification.Name(rawValue:NSNotificationNameHomeGoodsClick), object: nil)
    }
    
    @objc func clickGoods(notification:NSNotification?){
        guard let dic = notification?.userInfo as? [String:GoodsModel] ,
            let model = dic["model"] else {
            return
        }
        let vc = YYGoodsDetailController()
        vc.goodsId = model.id
        vc.pics = pics
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension WYHomeViewController {
    func setUI() {
        tableView = UITableView(frame:CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 49 - 64), style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.estimatedSectionHeaderHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(UINib.init(nibName: "HomeCell", bundle: nil), forCellReuseIdentifier: "HomeCell")
        tableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            self.homeData()
        })
        tableView.tableHeaderView = bannerView
    }
}

extension WYHomeViewController:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView .dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as? HomeCell
        cell?.categoryLabel.text = (listArray[indexPath.section]).categoryName
        ///先加载商品title和价格
        cell?.goodsList = (listArray[indexPath.section]).goodsList
        /// 判断是否在拖拽和是否已经减速，用户停止滑动再加载图片
        if !tableView.isDragging && !tableView.isDecelerating {
            cell?.scrollView.loadImage(array: (listArray[indexPath.section]).goodsList)
        }else {
            cell?.scrollView.loadImage(array: [GoodsModel]())
        }
        cell?.clickMoreGoods = { [weak self] in
            let vc = YYClassListViewController()
            vc.vcTitle = (self?.listArray[indexPath.section])?.categoryName
            vc.categoryId = (self?.listArray[indexPath.section])?.category
            vc.type = "indexCategory"
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        return cell!
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return listArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 67*HEIGHT_MULTIPLE+88*HEIGHT_MULTIPLE*Goods_MULTIPLE+10+42
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        loadCell()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if decelerate {
            loadCell()
        }
    }
    
    func loadCell() {
        guard let indexPathArray = tableView.indexPathsForVisibleRows else {
            return
        }
        for (_,indexPath) in indexPathArray.enumerated() {
            //
            let cell = tableView.cellForRow(at: indexPath) as! HomeCell
            cell.goodsList = (listArray[indexPath.section]).goodsList
        }
    }
}

extension WYHomeViewController {
    fileprivate func setNavigation() {
        navigationItem.title = "首页"
        let customTitleView = WYHomeTitleView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 44))
        self.navigationItem.titleView = customTitleView
        customTitleView.clickSearchBlock = { ()->() in
            print("跳转到搜索界面")
        }
    }
}

extension WYHomeViewController {
    func homeData() {
        SHOW_PROGRESS(view: view)
        WYNetWorkTool.share.request(url: "/main/index.htm", dic: ["pageNum":pageNumber]) { (isSuccess, result) in
            HIDDEN_PROGRESS(view: self.view)
            if isSuccess {
                guard let result = result,
                let dic = result["data"] as? [String:Any] else {
                        return
                }
                
                let categoryListModelList = dic["categoryListModelList"]
                let array = NSArray.yy_modelArray(with: HomeModel.self, json: categoryListModelList as Any)
                self.listArray = array as? [HomeModel] ?? [HomeModel]()
                
                let announcementList = dic["announcementList"]
                let announcementListArray = NSArray.yy_modelArray(with: AnnouncementModel.self, json: announcementList as Any) as? [AnnouncementModel] ?? [AnnouncementModel]()
                
                var pics = [String]()
                for (_,model) in announcementListArray.enumerated() {
                    pics.append(model.picture)
                }
                self.pics = pics
                self.bannerView.loadBanners(bannerList: pics)
            }
            self.tableView.mj_header.endRefreshing()
            self.tableView.reloadData()
        }
    }
}
