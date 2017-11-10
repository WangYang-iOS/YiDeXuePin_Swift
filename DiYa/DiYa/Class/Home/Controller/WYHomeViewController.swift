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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        setUI()
        homeData()
    }
}

extension WYHomeViewController {
    func setUI() {
        tableView = UITableView(frame:CGRect(x: 0, y: 64, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 49 - 64), style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(UINib.init(nibName: "HomeCell", bundle: nil), forCellReuseIdentifier: "HomeCell")
        tableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            self.homeData()
        })
    }
}

extension WYHomeViewController:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView .dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as? HomeCell
        cell?.goodsList = (listArray[indexPath.row]).goodsList
        return cell!
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 67*HEIGHT_MULTIPLE+88*HEIGHT_MULTIPLE*Goods_MULTIPLE
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
        WYNetWorkTool.share.request(url: "/main/index.htm", dic: ["pageNum":pageNumber]) { (isSuccess, result) in
            if isSuccess {
                guard let dic = result as? [String:Any],
                    let json = dic["categoryListModelList"],
                    let array = NSArray.yy_modelArray(with: HomeModel.self, json: json) else {
                        return
                }
                self.listArray = array as! [HomeModel]
//                print(array as! [HomeModel])
//                print(self.listArray[0].categoryName)
//                for (_,model) in self.listArray.enumerated() {
//                    print(model.announcement)
//                }
            }
            self.tableView.mj_header.endRefreshing()
            self.tableView.reloadData()
        }
    }
    
}
