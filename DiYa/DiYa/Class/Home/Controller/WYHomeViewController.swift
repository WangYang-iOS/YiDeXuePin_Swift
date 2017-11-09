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
    
    override func awakeFromNib() {
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
}

extension WYHomeViewController {
    func setUI() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            self.homeData()
        })
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

extension WYHomeViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView .dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "indexpath" + "\(indexPath.row)"
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
}

extension WYHomeViewController {
    func homeData() {
        WYNetWorkTool.share.request(url: "/main/index.htm", dic: ["pageNum":pageNumber]) { (isSuccess, result) in
            if isSuccess {
                print(result as? [String:Any] ?? [:])
                let dic = result as? [String:Any] ?? [:]
                let array = dic["categoryListModelList"]
                self.listArray = NSArray.yy_modelArray(with: HomeModel.self, json: array ?? []) as? [HomeModel] ?? [HomeModel]()
                
//                self.listArray = HomeModel.mj_objectArray(withKeyValuesArray: array) as? [HomeModel] ?? [HomeModel]()
                print(self.listArray)
                
                print(self.listArray[0].categoryName)
                
                for (_,model) in self.listArray.enumerated() {
                    print(model.announcement)
                }
            }
        }
    }
}
