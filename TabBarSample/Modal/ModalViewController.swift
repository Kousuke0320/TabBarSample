//
//  ModalViewController.swift
//  TabBarSample
//
//  Created by 田中康介 on 2019/10/13.
//  Copyright © 2019 田中康介. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

class ModalContentViewController: UITableViewController {
    
    var tableViewArray = [UITableViewCell]()
    var articles: Article = Article()
    let disposeBag = DisposeBag()
    var lat: Double?
    var lon: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpCell()
        let connectATabelog = ConnectToApiGurunavi()
//        connectATabelog.fetchArticle(name: "自由が丘", completion: { (articles) in
//            guard let articleValue = articles else {
//                return
//            }
//
//            self.articles = articleValue
//
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        })
        connectATabelog.fetchArticle(lat: self.lat, lon: self.lon, completion: { (articles) in
            guard let articleValue = articles else {
                return
            }
            //なぜかnilがはいる
            self.articles = articleValue

            DispatchQueue.main.async {
                self.tableView.reloadData()
                //self.showAnimation()
            }
        })
    }
}

extension ModalContentViewController {
    
    func setUpCell() {
        self.tableView.register(UINib(nibName: "SpotCell", bundle: nil), forCellReuseIdentifier: "SpotCell")
    }
    
    //cellをセットする
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //       let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        //let cell = tableView.dequeueReusableCell(withIdentifier: "SpotCell") as! SpotCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "SpotCell") as! SpotCell
        let article = articles
        let rest = article.results?.shop?[indexPath.row]
        //cell.textLabel?.text = rest?.name
//        cell.label.text = rest?.name
        cell.label.text = rest?.name
        
        guard let stringUrl = rest?.photo?.mobile?.l, !stringUrl.isEmpty else {
            return cell
        }
        
        print("緯度情報\(rest?.lat)")
        print("経度情報\(rest?.lng)")
        
        let url = URL(string: stringUrl)
        do {
            let data = try Data(contentsOf: url!)
            let image = UIImage(data: data)
            //cell.imageView?.image = image
            //cell.imageview.image = image
            cell.imageview.image = image
        }catch let err {
            print("Error : \(err.localizedDescription)")
        }
        
        return cell
    }
    
    //cellの数をセットする
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.results?.shop?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let storyboard: UIStoryboard = UIStoryboard(name: "SpotDetailViewController", bundle: nil)
        let nextView = storyboard.instantiateInitialViewController()
        nextView?.modalPresentationStyle = .pageSheet
        self.present(nextView!, animated: true, completion: nil)
    }
}
