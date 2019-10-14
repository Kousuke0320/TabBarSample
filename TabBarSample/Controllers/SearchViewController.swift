//
//  SearchViewController.swift
//  TabBarSample
//
//  Created by 田中康介 on 2019/10/14.
//  Copyright © 2019 田中康介. All rights reserved.
//

import Foundation
import UIKit

class SearchViewController: UIViewController {
    
    class func initialiseController() -> UIViewController? {
        let storyboard: UIStoryboard = UIStoryboard(name: "SearchViewController", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController()
        
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
