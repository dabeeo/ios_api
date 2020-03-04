//
//  MapViewController.swift
//  IndoorTutorialProject
//
//  Created by DABEEO on 2020/03/02.
//  Copyright © 2020 DABEEO. All rights reserved.
//

import Foundation
import UIKit
import DabeeoMaps_SDK

class MapViewController: UIViewController {
    
    var mapView: DMMapView!
    
    @IBOutlet var mapUIView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        initMapView()
    }
    
    func initMapView() {
        
        let authorization: DMAuthorization = Authorization.getAuthInfo()
        
        let frame: CGRect = CGRect(x: self.mapUIView.frame.origin.x,
                                   y: 0.0,
                                   width: self.mapUIView.frame.size.width,
                                   height: self.mapUIView.frame.size.height)
        
        let mapOptions: DMMapOptions = DMMapOptions.init()
        mapOptions.zoom = 4
        
        let mapView: DMMapView = DMMapView.init(frame: frame,
                                                mapEvent: self,
                                                options: mapOptions,
                                                authorization: authorization)
        self.mapUIView.addSubview(mapView)
    }
}

extension MapViewController: DMMapEventDelegate {
    func ready(_ mapView: DMMapView!, mapInfo: DMMapInfo!) {
        
    }
    
    func error(_ code: String!, message: String!) {
        
    }
}
