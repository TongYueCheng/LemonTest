//
//  Model.swift
//  FirstSwift
//
//  Created by tongyuecheng on 2020/10/16.
//  Copyright © 2020 tongyuecheng. All rights reserved.
//

import HandyJSON

struct Ext {
    var key: String!
    var val: String!
}

struct GalleryItemsItem: HandyJSON {
    var content: String?
    var id: Int = 0
    var ext: [Ext]?
    var title: String?
    var topCover:String?
    var linkType: Int = 0
    var cover: String?
}


