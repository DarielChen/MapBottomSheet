//
//  MapViewController.swift
//  MapBottomSheet
//
//  Created by Dariel on 2018/8/25.
//  Copyright © 2018年 Dariel. All rights reserved.
//

import MapKit
import UIKit

class MapViewController: UIViewController {
    
    private lazy var mapView = MKMapView(frame: view.bounds)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.showsUserLocation = true
        view.addSubview(mapView)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
}
