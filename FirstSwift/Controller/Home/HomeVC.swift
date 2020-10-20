//
//  HomeVC.swift
//  FirstSwift
//
//  Created by tongyuecheng on 2020/10/15.
//  Copyright © 2020 tongyuecheng. All rights reserved.
//

import UIKit

class HomeVC: BaseController {
    
    /// 模型
    private var galleryItems = [GalleryItemsItem]()
    private var textItems = [TextItems]()
    private var modules = [Modules]()
    private var defaultSearch: String?
    
    
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
    
    private lazy var collectionView: UICollectionView = {
        let lt = UCollectionViewSectionBackgroundLayout()
        lt.minimumInteritemSpacing = 5
        lt.minimumLineSpacing = 10
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: lt)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.alwaysBounceVertical = true
        collectionView.contentInset = UIEdgeInsets(top: screenHeight/3, left: 0, bottom: 0, right: 0)
        collectionView.scrollIndicatorInsets = collectionView.contentInset

        // 注册cell
        collectionView.register(cellType: ComicCollectionViewCell.self)
        
        // 注册组头，尾
        collectionView.register(supplementaryViewType: ComicCollectionHeaderView.self, ofKind: UICollectionView.elementKindSectionHeader)
        collectionView.register(supplementaryViewType: ComicCollectionFooterView.self, ofKind: UICollectionView.elementKindSectionFooter)
        
        
        // 刷新控件
        collectionView.uHead = URefreshHeader { [weak self] in self?.setupLoadData() }
        collectionView.uFoot = URefreshDiscoverFooter()
        collectionView.uempty = UEmptyView(verticalOffset:-(collectionView.contentInset.top)) {self.setupLayout()}
        
        return collectionView
        
    }()
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLoadData()
    }
    
    private func didSelectBanner(index: NSInteger) {
        print("轮播图被点击了。。。")
    }
    
    
    private func setupLoadData() {
        
        ApiLoadingProvider.request(Api.findHome,model: HomeDatasModel.self) {
            [weak self] (returnData) in
            self?.galleryItems = returnData?.galleryItems ?? []
            self?.textItems = returnData?.textItems ?? []
            self?.modules = returnData?.modules ?? []
            
            self?.collectionView.uHead.endRefreshing()
            self?.collectionView.uempty?.allowShow = true
            self?.collectionView.reloadData()
            
            
            self?.bannerView.bg_imagePaths = self?.galleryItems.filter { $0.topCover != nil }.map { $0.topCover! } ?? []
            self?.bannerView.imagePaths = self?.galleryItems.filter { $0.cover != nil}.map{ $0.cover! } ?? []
            self?.defaultSearch = returnData?.defaultSearch
            self?.navView.defaultSearch = self?.defaultSearch
        }
    }
    
    // 继承父类
    override func setupLayout() {
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(bannerView)
        bannerView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(screenHeight/3)
        }
        
        view.addSubview(navView)
        navView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(120)
        }
    }
}



extension HomeVC: UICollectionViewDataSource,UCollectionViewSectionBackgroundLayoutDelegateLayout{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = modules[indexPath.section]
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: ComicCollectionViewCell.self)
        cell.model = model.items?[indexPath.row].first
        cell.cellStyle = .withTitleAndDesc
        return cell
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return modules.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, backgroundColorForSectionAt section: Int) -> UIColor {
        return UIColor.white
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let model = modules[section]
        return model.items?.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    // 头尾视图
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, for: indexPath, viewType: ComicCollectionHeaderView.self)
            let model = modules[indexPath.section]
            headerView.iconView.kf.setImage(urlString: model.moduleInfo?.icon)
            headerView.titleLabel.text = model.moduleInfo?.title
            headerView.moreActionClosure { [weak self] in
                
            }
            return headerView
        } else {
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, for: indexPath, viewType: ComicCollectionFooterView.self)
            return footerView
        }
    }
    
    
    // 头部高度
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: screenWidth, height: 50)
    }
    
    // 尾部高度
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return modules.count - 1 != section ? CGSize(width: screenWidth, height: 10) : CGSize.zero
    }
    
    // cell 高度
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let model = modules[indexPath.section]
        switch model.items?.count {
        case 4:
            let width = floor(Double(screenWidth - 30) / 2)
            return CGSize(width: width, height: width * 0.85)
        case 5:
            let width = floor(Double(screenWidth - 30) / 3)
            if indexPath.row == 0 {
                return CGSize(width: width * 2, height: width * 1.75)
            }
            return CGSize(width: width, height: width * 1.75)
        case 3,6:
            let width = floor(Double(screenWidth - 30) / 3)
            return CGSize(width: width, height: width * 1.75)
        default:
            let width = floor(Double(screenWidth - 30) / 3)
            return CGSize(width: width, height: width * 1.75)
        }
    }
    
}



