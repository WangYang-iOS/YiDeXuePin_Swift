//
//  YYAllClassView.swift
//  DiYa
//
//  Created by wangyang on 2017/12/11.
//  Copyright © 2017年 wangyang. All rights reserved.
//

import UIKit
let padding = (SCREEN_WIDTH - 70 * 4) / 5.0


class YYAllClassView: UIView {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var layout: UICollectionViewFlowLayout!
    var titleArray : [GoodsModel]? {
        didSet {
//            guard let titleArray = titleArray else {
//                return
//            }
//            if lastModel == nil {
//                lastModel = titleArray[0]
//                lastModel?.isSelected = true
//            }
            collectionView.reloadData()
        }
    }
    var lastModel : GoodsModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }
}

extension YYAllClassView {
    fileprivate func setUI() {
        //
        collectionView.register(UINib.init(nibName: "YYAllClassViewCell", bundle: nil), forCellWithReuseIdentifier: NSStringFromClass(YYAllClassViewCell.classForCoder()))
    }
}

extension YYAllClassView:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(YYAllClassViewCell.classForCoder()), for: indexPath) as! YYAllClassViewCell
        cell.model = titleArray?[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //
        guard let titleArray = titleArray else {
            return
        }
        let model = titleArray[indexPath.item]
        if model == lastModel {
            return
        }else {
            model.isSelected = true
            lastModel?.isSelected = false
            lastModel = model
        }
        collectionView.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (titleArray?.count)!
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsetsMake(14, padding, 14, padding)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
         return padding
    }
}
