//
//  MapAnimationViewController.swift
//  IndoorTutorialProject
//
//  Created by DABEEO on 2020/03/04.
//  Copyright © 2020 DABEEO. All rights reserved.
//

import Foundation
import UIKit
import DabeeoMaps_SDK

class MapAnimationViewController: UIViewController {
    
    var mapView: DMMapView!
    var mapOptions: DMMapOptions!
    var mapInfo: DMMapInfo!
    
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
        
        mapOptions = DMMapOptions.init()
        mapOptions.zoom = 4
        mapOptions.isMoveAnimation = true
        mapOptions.isZoomAnimation = true
        
        let mapView: DMMapView = DMMapView.init(frame: frame,
                                                mapEvent: self,
                                                options: mapOptions,
                                                authorization: authorization)
        self.mapUIView.addSubview(mapView)
    }
    
    @IBAction func actionMove() {
        self.mapView.mapCenter = DMPoint.init(x: CGFloat.random(in: 0..<self.mapInfo.size.width),
                                              y: CGFloat.random(in: 0..<self.mapInfo.size.height),
                                              z: 0.0)
    }
    
    @IBAction func actionZoom() {
        self.mapView.zoom = CGFloat.random(in: self.mapOptions.minZoom..<self.mapOptions.maxZoom)
    }
    
    @IBAction func actionMoveAndZoom() {
        let point: DMPoint = DMPoint.init(x: CGFloat.random(in: 0..<self.mapInfo.size.width),
                                              y: CGFloat.random(in: 0..<self.mapInfo.size.height),
                                              z: 0.0)
        let zoom = CGFloat.random(in: self.mapOptions.minZoom..<self.mapOptions.maxZoom)
        
        self.mapView.setView(point, zoomLevel: zoom, animation: true)
    }
}

extension MapAnimationViewController: DMMapEventDelegate {
    func ready(_ mapView: DMMapView!, mapInfo: DMMapInfo!) {
        self.mapView = mapView
        self.mapInfo = mapInfo
    }
    
    func error(_ code: String!, message: String!) {
        print("[MapAnimationVC] - CODE : "+code, "/ MESSAGE : "+message);
    }
}

