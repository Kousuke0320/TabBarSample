//
//  Rest.swift
//  sapleiosApp
//
//  Created by 田中康介 on 2019/08/10.
//  Copyright © 2019 田中康介. All rights reserved.
//

import Foundation

struct Shop: Codable {
    var name: String?
    var address: String?
    var photo: Images?
    var lat: Double?
    var lng: Double?
}

extension Shop {
    init(_ json: [String: Any]) {
        if let name = json["name"] as? String {
            self.name = name
        }
        if let address = json["address"] as? String {
            self.address = address
        }
        if let photo = json["photo"] as? Images {
            self.photo = photo
        }
        if let lat = json["lat"] as? Double {
            self.lat = lat
        }
        if let lng = json["lng"] as? Double {
            self.lng = lng
        }
    }
}

