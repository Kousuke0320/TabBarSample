//
//  FirstViewController.swift
//  TabBarSample
//
//  Created by 田中康介 on 2019/10/13.
//  Copyright © 2019 田中康介. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Lottie
import CoreLocation
import MapKit
import FloatingPanel

class FirstViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager: CLLocationManager!
    var lat: Double?
    var lon: Double?
    
    var floatingPanelController: FloatingPanelController!
    var disposeBag = DisposeBag()
    var viewModel: FirstViewModel!
    
    private let eventSubject = PublishSubject<Void>()
    //private let animation = PublishSubject<Bool>(
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSearchView()
        setupLocationManager()
        
        eventSubject
            .subscribe { (_) in
            self.viewModel = FirstViewModel(lat: self.lat, lon: self.lon, viewController: self)
            }
        .disposed(by: disposeBag)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func setUpSearchView() {
        let viewFrame = UIScreen.main.bounds
        let viewLabelSize = CGSize(width: viewFrame.width - 20, height: 50)
        let viewPoint = CGPoint(x: (viewFrame.width - viewLabelSize.width) / 2, y: 60)
        let searchViewFrame = CGRect(x: viewPoint.x, y: viewPoint.y, width: viewLabelSize.width, height: viewLabelSize.height)
        let searchBar = UITextField(frame: searchViewFrame)
        searchBar.delegate = self
        self.view.addSubview(searchBar)
    }
    
    func setupLocationManager() {
        //位置情報取得インスタンス
        locationManager = CLLocationManager()
        
        guard let locationManager = locationManager else {
            return
        }
        //位置情報取得をリクエスト
        locationManager.requestWhenInUseAuthorization()
        
        let status = CLLocationManager.authorizationStatus()
        // 使用時に位置情報を許可した時に実施
        if status == .authorizedWhenInUse {
            //viewController自身をdelegate(向先に設定する)
            locationManager.delegate = self
            //10m単位で位置情報を取得する
            locationManager.distanceFilter = 10
            locationManager.startUpdatingLocation()
        }
        //animationView.isHidden = true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.first
        self.lat = location?.coordinate.latitude
        self.lon = location?.coordinate.longitude
        print("location\(lat)\(lon)")
        eventSubject.onCompleted()
        
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        if let coordinate = location?.coordinate {
            let region = MKCoordinateRegion(center: coordinate, span: span)
            mapView.region = region
        }
    }
}

extension FirstViewController: UITextFieldDelegate {

    func textFieldDidEndEditing(_ textField: UITextField) {
        let viewController = SearchViewController()
        let navigationView = UINavigationController(rootViewController: viewController)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
