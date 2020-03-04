//
//  PreviewViewController.swift
//  IndoorTutorialProject
//
//  Created by DABEEO on 2020/03/04.
//  Copyright © 2020 DABEEO. All rights reserved.
//

import Foundation
import UIKit
import DabeeoMaps_SDK

protocol PreviewDelegate {
    func readyNavigation()
}

class PreviewViewController: UIViewController {
    
    var mapView: DMMapView!
    var mapOptions: DMMapOptions!
    var navigationMode: DMNavigationMode! = NAVIGATION_MODE_PREVIEW
    
    let viewModel = NavigationViewModel()
    
    @IBOutlet var mapUIView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
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
        
        let mapView: DMMapView = DMMapView.init(frame: frame,
                                                mapEvent: self,
                                                options: mapOptions,
                                                authorization: authorization)
        self.mapUIView.addSubview(mapView)
    }
    
    func initialize() {
        viewModel.delegate = self
    }
    
    func initPoiEvent() {
        if let markers: NSMutableArray = mapView.getPoiData() {
            addMarkersEvent(arr: markers)
        }
    }
    
    func addMarkersEvent(arr: NSMutableArray) {
        for i in 0..<arr.count {
            let m : DMMarker = arr.object(at: i) as! DMMarker
            
            m.markerEventDelegate = self as? DMMarkerEventDelegate
        }
    }
    
    @IBAction func btnStartClick() {
        self.viewModel.start()
    }
    
    @IBAction func btnCancelClick() {
        self.viewModel.cancel()
    }
}

extension PreviewViewController: DMMapEventDelegate {
    func ready(_ mapView: DMMapView!, mapInfo: DMMapInfo!) {
        
        self.mapView = mapView
        
        self.viewModel.currentFloor = self.mapView.floorInfo()
        
        initPoiEvent()
        
        //do something
    }
    
    func floorEnd(_ floorInfo: DMFloorInfo!, reasonType: ReasonType) {
        
        self.viewModel.currentFloor = floorInfo
        
        initPoiEvent()
        
        self.viewModel.drawPath(mapView: mapView)
        
        //do something
    }
    
    func longClick(_ point: DMPoint!) {
        let alert = UIAlertController.init(title: "선택위치",
                                           message: String.init(format: "(x = %0.2f, y = %0.2f)", point.x, point.y),
                                           preferredStyle: UIAlertController.Style.alert)
        
        let startAction = UIAlertAction.init(title: "출발",
                                             style: UIAlertAction.Style.default) { (action) in
                                                
                                            self.viewModel.startLocation = DMLocation.init(x: point.x,
                                                                                           y: point.y,
                                                                                           floorLevel: self.viewModel.currentFloor.level)
        }
        
        let endAction = UIAlertAction.init(title: "도착",
                                           style: UIAlertAction.Style.default) { (action) in
                                            
                                            self.viewModel.endLocation = DMLocation.init(x: point.x,
                                                                                         y: point.y,
                                                                                         floorLevel: self.viewModel.currentFloor.level)
                                            
                                            self.viewModel.readyForNavigation(mapView: self.mapView,
                                                                              navigationMode: self.navigationMode)
        }
        
        alert.addAction(startAction)
        alert.addAction(endAction)
        self.present(alert, animated: false, completion: nil)
    }
    
    func error(_ code: String!, message: String!) {
        print("[PoiEventVC] - CODE : "+code, "/ MESSAGE : "+message);
        
        //handle error
    }
}
extension PreviewViewController: DMMarkerEventDelegate {
    func click(_ marker: DMMarker!) {
        let alert = UIAlertController.init(title: marker.title,
                                           message: "",
                                           preferredStyle: UIAlertController.Style.alert)
        
        let startAction = UIAlertAction.init(title: "출발",
                                             style: UIAlertAction.Style.default) { (action) in
                                            
                                            self.viewModel.startLocation = DMLocation.init(x: marker.position.x,
                                                                                           y: marker.position.y,
                                                                                           floorLevel: self.viewModel.currentFloor.level)
        }
        
        let endAction = UIAlertAction.init(title: "도착",
                                           style: UIAlertAction.Style.default) { (action) in
                                            
                                            self.viewModel.endLocation = DMLocation.init(x: marker.position.x,
                                                                                         y: marker.position.y,
                                                                                         floorLevel: self.viewModel.currentFloor.level)
                                            
                                            self.viewModel.readyForNavigation(mapView: self.mapView,
                                                                              navigationMode: self.navigationMode)
        }
        
        alert.addAction(startAction)
        alert.addAction(endAction)
        self.present(alert, animated: false, completion: nil)
    }
}

extension PreviewViewController: PreviewDelegate {
    func readyNavigation() {
        self.viewModel.navigation.delegate = self
    }
}

extension PreviewViewController: DMNavigationEventDelegate {
    func directionsBegin(_ routes: DMRoute!) {
        viewModel.isNavigating = true
        viewModel.hidePath()
    }
    
    func directions(_ routes: DMRoute!) {
        //use GUIDANCE Mode
        //do something
    }
    
    func directionAnimations(_ routes: DMRoute!) {
        //do something
    }
    
    func directionsEnd(_ routes: DMRoute!) {
        viewModel.isNavigating = false
        
        self.mapView.rotate = 0
        
        self.viewModel.startLocation = nil
        self.viewModel.endLocation = nil
        
        //do something
    }
    
    func pathRescan() {
        //use GUIDANCE Mode
        //do something
    }
    
    func navigationError(_ code: String!, message: String!) {
        viewModel.isNavigating = false
        //handle error
    }
}
