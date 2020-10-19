//
//  FindNavView.swift
//  FirstSwift
//
//  Created by tongyuecheng on 2020/10/16.
//  Copyright © 2020 tongyuecheng. All rights reserved.
//

import UIKit

class FindNavView: UIView {

    private let MaxValue: CGFloat = (screenWidth - 20) / 2
    
    private lazy var msgBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "sep_Message_White"), for: .normal)
        return btn
    }()
    
    private lazy var searchBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "classify_search_btn"), for: .normal)
        btn.setTitle(" 镇魂街", for: .normal)
        btn.setTitleColor(.red, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 13)
        btn.titleLabel?.textAlignment = .left
        btn.backgroundColor = .init(red: 1, green: 1, blue: 1, alpha: 0.5)
        btn.layer.cornerRadius = 20
        return btn
    }()

    private lazy var stackView: UIStackView = {
        let stackV = UIStackView()
        stackV.spacing = 10
        stackV.alignment = .fill
        stackV.distribution = .fillEqually
        stackV.axis = .horizontal
        return stackV
    }()
    
    private lazy var topBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "home_1_default"), for: .normal)
        btn.setTitle("排行", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 14)
        return btn
    }()
    
    private lazy var VIPBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "home_2_default"), for: .normal)
        btn.setTitle("VIP", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 14)
        return btn
    }()
    
    private lazy var subscribeBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "home_3_default"), for: .normal)
        btn.setTitle("订阅", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 14)
        return btn
    }()
    
    private lazy var classifyBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "home_4_default"), for: .normal)
        btn.setTitle("分类", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 14)
        return btn
    }()
    
    public var defaultSearch: String? {
        didSet {
            if  let defaultSearch = defaultSearch {
                searchBtn.setTitle("--" + defaultSearch, for: .normal)
            }
        }
    }
    
    private var defaultValue: CGFloat = 0
    private var selfDefaultHeight: CGFloat = 0
    
    public var value: CGFloat? {
        didSet {
            self.layoutIfNeeded()
            
            if let value = value {
                if defaultValue == 0 {
                    defaultValue = value
                    selfDefaultHeight = self.frame.size.height
                    
                } else {
                    var changeValue = (-defaultValue) - (-value)
                    
                }
            }
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("初始化信息报错")
    }
    
    func setupLayout() {
        addSubview(msgBtn)
        msgBtn.snp.makeConstraints { (make) in
            make.top.equalTo(44)
            make.left.equalTo(20)
            make.width.height.equalTo(25)
        }
        
        addSubview(searchBtn)
        searchBtn.snp.makeConstraints { (make) in
            make.top.equalTo(40)
            make.left.equalTo(65)
            make.height.equalTo(35)
            make.width.equalTo(screenWidth - 85)
        }
        
        addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.top.equalTo(searchBtn.snp.bottom).offset(10)
            make.right.equalTo(-20)
            make.height.equalTo(35)
            make.width.equalTo(screenWidth - 40)
        }
        stackView.addArrangedSubview(topBtn)
        stackView.addArrangedSubview(VIPBtn)
        stackView.addArrangedSubview(subscribeBtn)
        stackView.addArrangedSubview(classifyBtn)
        
    }
    
    
}
