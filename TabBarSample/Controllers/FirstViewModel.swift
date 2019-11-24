//
//  FirstViewModel.swift
//  TabBarSample
//
//  Created by 田中康介 on 2019/10/13.
//  Copyright © 2019 田中康介. All rights reserved.
//

import Foundation
import FloatingPanel

final class FirstViewModel {
    var floatingPanelController: FloatingPanelController!
    
    init(lat: Double?, lon: Double?, viewController: UIViewController) {
        floatingPanelController = FloatingPanelController()
        //floatingPanelController.delegate = self
        
        let modalViewController = ModalContentViewController()
        modalViewController.lat = lat
        modalViewController.lon = lon
        floatingPanelController.set(contentViewController: modalViewController)
        //floatingPanelController.track(scrollView: modalViewController.tableView)
        floatingPanelController.addPanel(toParent: viewController, belowView: nil, animated: false)
    }
}
