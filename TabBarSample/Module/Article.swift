//
//  Article.swift
//  sapleiosApp
//
//  Created by 田中康介 on 2019/08/10.
//  Copyright © 2019 田中康介. All rights reserved.
//

import Foundation

struct Article: Codable {
    
    var results: results?
    //初期化をしないと表示されない
    init() {
        
    }
}

struct results: Codable {
    var shop: [Shop]?
}

extension results {
    init(_ json: [String: Any]) {
        if let shop = json["shop"] as? [Shop] {
            self.shop = shop
        }
    }
}

