//
//  HomeVC.swift
//  FirstSwift
//
//  Created by tongyuecheng on 2020/10/15.
//  Copyright © 2020 tongyuecheng. All rights reserved.
//

import UIKit

class HomeVC: BaseController {
    
    // 模型
    private var galleryItems = [GalleryItemsItem]()
    
    
    /// 头部导航视图
    private lazy var navView: FindNavView = {
        let navV = FindNavView()
        return navV
    }()
    
    /// banner 图
    private lazy var bannerView: LLCycleScrollView = {
        let cycleScrollView = LLCycleScrollView()
        cycleScrollView.backgroundColor = UIColor.background
        cycleScrollView.autoScroll = true
        cycleScrollView.autoScrollTimeInterval = 3
        cycleScrollView.placeHolderImage = UIImage(named: "normal_placeholder_h")
        cycleScrollView.coverImage = UIImage(named: "normal_placeholder_h")
        cycleScrollView.pageControlBottom = 30
        cycleScrollView.pageControlPosition = .center
        cycleScrollView.pageControlActiveImage = UIImage(named: "finishobj")
        cycleScrollView.titleBackgroundColor = .blue
        cycleScrollView.customPageControlStyle = .image
        
        // 点击 item的回调
        cycleScrollView.lldidSelectItemAtIndex = didSelectBanner(index:)
        return cycleScrollView
        
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func didSelectBanner(index: NSInteger) {
        print("轮播图被点击了。。。")
    }
    
    
    // 继承父类
    override func setupLayout() {
        view.addSubview(navView)
        navView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(120)
        }
    }
}
