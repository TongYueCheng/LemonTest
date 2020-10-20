//
//  BaseCollectionReusableView.swift
//  FirstSwift
//
//  Created by tongyuecheng on 2020/10/19.
//  Copyright © 2020 tongyuecheng. All rights reserved.
//

import Reusable

class BaseCollectionReusableView: UICollectionReusableView, Reusable{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder aDecoder:  NSCoder) {
        fatalError("init (coder:) has not been implemented")
    }
    
    open func setupLayout() {}
        
}
