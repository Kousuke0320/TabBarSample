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

class ModalContentViewController: UIViewController {
    
    var tableViewArray = [UITableViewCell]()
    var articles: Article = Article()
    let disposeBag = DisposeBag()
    var tableview: UITableView?
    var lat: Double?
    var lon: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let connectATabelog = ConnectToApiGurunavi()
        
        
        let viewFrame = UIScreen.main.bounds
        let viewLabelSize = CGSize(width: viewFrame.width, height: viewFrame.height - 60)
        let viewPoint = CGPoint(x: 0, y: 60)
        let frame = CGRect(x: viewPoint.x, y: viewPoint.y, width: viewLabelSize.width, height: viewLabelSize.height)
        tableview = UITableView(frame: frame)
        if let table = tableview {
            self.view.addSubview(table)
            self.setUpCell()
        }
        
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
        
        self.tableview?.delegate = self
        self.tableview!.dataSource = self
        
        connectATabelog.fetchArticle(lat: self.lat, lon: self.lon, completion: { (articles) in
            guard let articleValue = articles else {
                return
            }
            //なぜかnilがはいる
            self.articles = articleValue
            
            DispatchQueue.main.async {
                self.tableview?.reloadData()
                //self.showAnimation()
            }
        })
    }
}

extension ModalContentViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setUpCell() {
        self.tableview?.register(UINib(nibName: "SpotCell", bundle: nil), forCellReuseIdentifier: "SpotCell")
    }
    
    //cellをセットする
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.results?.shop?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let storyboard: UIStoryboard = UIStoryboard(name: "SpotDetailViewController", bundle: nil)
        let nextView = storyboard.instantiateInitialViewController()
        nextView?.modalPresentationStyle = .pageSheet
        self.present(nextView!, animated: true, completion: nil)
    }
}
