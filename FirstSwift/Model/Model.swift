//
//  Model.swift
//  FirstSwift
//
//  Created by tongyuecheng on 2020/10/16.
//  Copyright © 2020 tongyuecheng. All rights reserved.
//

import HandyJSON

/// 发现首页相关model
struct FloatItems: HandyJSON {
    var localInfoButton = false
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

struct Ext: HandyJSON {
    var key: String!
    var val: String!
}

struct ItemModel: HandyJSON {
    var comicId: Int = 0
    var cover: String?
    var subTitle: String?
    var title: String?
    
}

struct ModuleInfo: HandyJSON {
    var argName: String?
    var argValue: Int = 0
    var bgCover: String?
    var icon: String?
    var title: String?
}

struct Modules: HandyJSON{
    var moduleInfo: ModuleInfo?
    var moduleType: Int = 0
    var uiType: Int = 0
    var items: [[ItemModel]]?
}

struct TextItems: HandyJSON {
    
}

struct HomeDatasModel: HandyJSON{
    var textItems: [TextItems]?
    var curTime: Int = 0
    var defaultSearch: String?
    var editTime: String?
    var floatItems: FloatItems?
    var galleryItems: [GalleryItemsItem]?
    var modules: [Modules]?
    var showPageName: String?
}

extension Array: HandyJSON {}

struct ReturnDta<T: HandyJSON>: HandyJSON {
    var message:String?
    var returnData: T?
    var stateCode: Int = 0
}

struct ResponseData<T: HandyJSON>: HandyJSON {
    var code: Int = 0
    var data: ReturnDta<T>?
    
    
}
