//
//  OneClassView.swift
//  DiYa
//
//  Created by wangyang on 2017/11/9.
//  Copyright © 2017年 wangyang. All rights reserved.
//

import UIKit


class OneClassView: UIView {

    @IBOutlet weak var tableView: UITableView!
    
    var categoryMenu : [CategoryModelList]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    var lastModel = CategoryModelList()
    
    override func awakeFromNib() {
         super.awakeFromNib()
        setUI()
    }
}

extension OneClassView {
    fileprivate func setUI() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(UINib.init(nibName: "OneClassCell", bundle: nil), forCellReuseIdentifier: "OneClassCell")
    }
}

extension OneClassView:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OneClassCell", for: indexPath) as? OneClassCell
        cell?.categoryModelList = categoryMenu?[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
        tableView.deselectRow(at: indexPath, animated: true)
        let model = categoryMenu?[indexPath.row]
        if model == lastModel {
            return
        }
        model?.isSelected = true
        lastModel.isSelected = false
        lastModel = model!
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryMenu?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 44
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
}

