//
//  Image.swift
//  sapleiosApp
//
//  Created by 田中康介 on 2019/08/10.
//  Copyright © 2019 田中康介. All rights reserved.
//

import Foundation

struct Images: Codable {
    var mobile: Image?
}

extension Images {
    init(_ json: [String: Any]) {
        if let mobile = json["mobile"] as? Image {
            self.mobile = mobile
        }
    }
}

struct Image: Codable {
    var s: String?
    var m: String?
    var l: String?
}

extension Image {
    init(_ json: [String: Any]) {
        if let shop_image1 = json["s"] as? String {
            self.s = shop_image1
        }
        if let shop_image2 = json["m"] as? String {
            self.m = shop_image2
        }
        if let shop_image2 = json["l"] as? String {
            self.l = shop_image2
        }
    }
}

