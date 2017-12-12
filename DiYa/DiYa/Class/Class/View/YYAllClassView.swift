//
//  YYAllClassView.swift
//  DiYa
//
//  Created by wangyang on 2017/12/11.
//  Copyright © 2017年 wangyang. All rights reserved.
//

import UIKit
let padding = (SCREEN_WIDTH - 70 * 4) / 5.0

@objc protocol YYAllClassViewDelegate {
    @objc optional
    func classViewClickIndex(index:Int)
}

class YYAllClassView: UIView {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var layout: UICollectionViewFlowLayout!
    weak var delegate : YYAllClassViewDelegate?
    var titleArray : [GoodsModel]? {
        didSet {
            collectionView.reloadData()
        }
    }
    var lastModel : GoodsModel?
    var index : Int? {
        didSet {
            guard let titleArray = titleArray,
                let index = index else {
                return
            }
            lastModel = titleArray[index]
            lastModel?.isSelected = true
            collectionView.reloadData()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }
}

extension YYAllClassView {
    fileprivate func setUI() {
        //
        collectionView.register(UINib.init(nibName: "YYAllClassViewCell", bundle: nil), forCellWithReuseIdentifier: NSStringFromClass(YYAllClassViewCell.classForCoder()))
        collectionView.register(UINib.init(nibName: "YYAllClassReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "YYAllClassReusableView")
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
            self.isHidden = true
            return
        }else {
            model.isSelected = true
            lastModel?.isSelected = false
            lastModel = model
        }
        collectionView.reloadData()
        delegate?.classViewClickIndex?(index: indexPath.item)
        self.isHidden = true
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            let headView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "YYAllClassReusableView", for: indexPath) as! YYAllClassReusableView
            headView.hiddenClassBlock = { [weak self] in
                self?.isHidden = true
            }
            return headView
        }
        return UICollectionReusableView()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: SCREEN_WIDTH, height: 51)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (titleArray?.count)!
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsetsMake(0, padding, 14, padding)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20;
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
         return padding
    }
}
