//
//  SearchViewController.swift
//  TabBarSample
//
//  Created by 田中康介 on 2019/11/24.
//  Copyright © 2019 田中康介. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift


class SearchViewController: UIViewController {
    @IBOutlet private weak var firstTextField: PickerTextField!
    @IBOutlet private weak var secondTextField: PickerTextField!
    @IBOutlet private weak var thirdTextField: PickerTextField!
    @IBOutlet private weak var forthTextField: PickerTextField!
    @IBOutlet private weak var button: UIButton!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setupTextField()
        
//        button.rx.tap.asDriver().asObservable().bind { (_) in
//            let nextViewController = SpotDetailViewController()
//            self.navigationController?.pushViewController(nextViewController, animated: true)
//        }.disposed(by: disposeBag)
        button.rx.tap.subscribe { (_) in
            print("aaa")
            let nextViewController = SecondViewController()
            self.present(nextViewController, animated: true, completion: nil)
        }.disposed(by: disposeBag)
    }
    
    func setupTextField() {
        firstTextField.setup(dataList: ["a","a","a","b","b","b"])
        secondTextField.setup(dataList: ["a","a","a","b","b","b"])
        thirdTextField.setup(dataList: ["a","a","a","b","b","b"])
        forthTextField.setup(dataList: ["a","a","a","b","b","b"])
    }
    
    func setupBackground() {
        //グラデーションの開始色
        let topColor = UIColor(red:0.07, green:0.13, blue:0.26, alpha:1)
        //グラデーションの開始色
        let bottomColor = UIColor(red:0.54, green:0.74, blue:0.74, alpha:1)

        //グラデーションの色を配列で管理
        let gradientColors: [CGColor] = [topColor.cgColor, bottomColor.cgColor]

        //グラデーションレイヤーを作成
        let gradientLayer: CAGradientLayer = CAGradientLayer()

        //グラデーションの色をレイヤーに割り当てる
        gradientLayer.colors = gradientColors
        //グラデーションレイヤーをスクリーンサイズにする
        gradientLayer.frame = self.view.bounds

        //グラデーションレイヤーをビューの一番下に配置
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
}

extension SearchViewController {
    
}
