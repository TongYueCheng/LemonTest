//
//  BaseController.swift
//  FirstSwift
//
//  Created by tongyuecheng on 2020/10/15.
//  Copyright © 2020 tongyuecheng. All rights reserved.
//

import UIKit
import SnapKit
import Then
import Reusable
import Kingfisher


class BaseController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.background
        
        if #available(iOS 11.0, *) {
            UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configNavigationBar()
    }
    
    func setupLayout() {}
    
    func configNavigationBar() {
        guard let navi = navigationController else {
            return
        }
        if navi.visibleViewController == self {
            navi.barStyle(.theme)
            navi.disablePopGesture = false
            navi.setNavigationBarHidden(false, animated: true)
            if navi.viewControllers.count > 1 {
                navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backGreen"), style: .plain,
                                                                   target: self,
                                                                   action: #selector(pressBack))
            }
        }
    }
    
    @objc func pressBack() {
        navigationController?.popViewController(animated: true)
    }

}

extension BaseController {
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
}
