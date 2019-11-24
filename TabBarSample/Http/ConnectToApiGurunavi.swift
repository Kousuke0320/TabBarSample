//
//  ConnectToApiGurunavi.swift
//  TabBarSample
//
//  Created by 田中康介 on 2019/10/13.
//  Copyright © 2019 田中康介. All rights reserved.
//

import Foundation

class ConnectToApiGurunavi {
    let url =  "https://webservice.recruit.co.jp/hotpepper/gourmet/v1/"
    
    func fetchArticle(name: String?, completion: @escaping (Article?) -> Swift.Void) {
        
        guard let name = name else {
            return
        }
        //URLが無効ならreturnを返す
        guard var urlComponents = URLComponents(string: url) else {
            return
        }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "key", value: "b68ec133adc2d82e"),
            URLQueryItem(name: "format", value: "json"),
            URLQueryItem(name: "name", value: name)
        ]
        
        let task = URLSession.shared.dataTask(with: urlComponents.url!) { data, response, error in
            
            guard let jsonData = data else {
                return
            }
            
            do {
                let article = try JSONDecoder().decode(Article.self, from: jsonData)
                //completion(article)
                completion(article)
                
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    //緯度経度で検索
    func fetchArticle(lat: Double?, lon: Double?, completion: @escaping (Article?) -> Swift.Void) {
        guard let lat = lat,
            let lon = lon else {
                return
        }
        
        //URLが無効ならreturnを返す
        guard var urlComponents = URLComponents(string: url) else {
            return
        }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "key", value: "b68ec133adc2d82e"),
            URLQueryItem(name: "lat", value: String("\(lat)")),
            URLQueryItem(name: "lng", value: String("\(lon)")),
            URLQueryItem(name: "format", value: "json")
        ]
        
        let task = URLSession.shared.dataTask(with: urlComponents.url!) { data, response, error in
            
            guard let jsonData = data else {
                return
            }
            
            do {
                let article = try JSONDecoder().decode(Article.self, from: jsonData)
                print(article)
                //completion(article)
                completion(article)
                
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}
