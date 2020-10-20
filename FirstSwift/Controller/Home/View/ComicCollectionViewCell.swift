//
//  ComicCollectionViewCell.swift
//  FirstSwift
//
//  Created by tongyuecheng on 2020/10/19.
//  Copyright © 2020 tongyuecheng. All rights reserved.
//

import UIKit

/// 设置样式
enum ComicCollectionViewCellStyle {
    case none
    case withTitle
    case withTitleAndDesc
}

class ComicCollectionViewCell: BaseCollectionViewCell {
    private lazy var iconView:  UIImageView = {
        let iconView = UIImageView()
        iconView.contentMode = .scaleAspectFill
        iconView.clipsToBounds = true
        return iconView
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = .black
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        return titleLabel
    }()
    
    private lazy var desclabel: UILabel = {
        let descLabel = UILabel()
        descLabel.textColor = .gray
        descLabel.font = UIFont.systemFont(ofSize: 12)
        return descLabel
    }()
    
    /// 重写父类的方法  布局UI
    override func setupLayout() {
        clipsToBounds = true
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
            make.height.equalTo(25)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        contentView.addSubview(iconView)
        iconView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(titleLabel.snp.top)
        }
        iconView.layer.cornerRadius = 5
        iconView.layer.borderColor = UIColor.background.cgColor
        iconView.layer.borderWidth = 0.5
        
        contentView.addSubview(desclabel)
        desclabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10))
            make.top.equalTo(titleLabel.snp.bottom)
            make.height.equalTo(20)
        }
    }
    
    
    
    var cellStyle: ComicCollectionViewCellStyle = .withTitle {
        didSet {
            switch cellStyle {
            case .none:
                /// 布局更新
                titleLabel.snp.updateConstraints { (make) in
                    make.bottom.equalToSuperview().offset(25)
                }
                titleLabel.isHidden = true
                desclabel.isHidden = true
            case .withTitle:
                titleLabel.snp.makeConstraints { (make) in
                    make.bottom.equalToSuperview().offset(-10)
                }
                titleLabel.isHidden = false
                desclabel.isHidden = true
            case .withTitleAndDesc:
                titleLabel.snp.makeConstraints { (make) in
                    make.bottom.equalToSuperview().offset(-25)
                }
                titleLabel.isHidden = false
                desclabel.isHidden = false
            }
        }
    }
    
    var model: ItemModel? {
        didSet {
            guard let model = model else {
                return
            }
            iconView.kf.setImage(urlString: model.cover, placeholder: (bounds.width > bounds.height) ? UIImage(named: "normal_placeholder_h") : UIImage(named: "normal_placeholder_v"))
            titleLabel.text = model.title ?? ""
            desclabel.text = model.subTitle ?? ""
            
        }
    }
    
}
