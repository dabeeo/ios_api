//
//  PoiEventViewController.swift
//  IndoorTutorialProject
//
//  Created by DABEEO on 2020/03/04.
//  Copyright © 2020 DABEEO. All rights reserved.
//

import Foundation
import UIKit
import DabeeoMaps_SDK

class PoiEventViewController: UIViewController {
    
    var mapView: DMMapView!
    var mapOptions: DMMapOptions!
    
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
        
        let mapView: DMMapView = DMMapView.init(frame: frame,
                                                mapEvent: self,
                                                options: mapOptions,
                                                authorization: authorization)
        self.mapUIView.addSubview(mapView)
    }
    
    func initPoiEvent() {
        if let markers: NSMutableArray = self.mapView.getPoiData() {
            addMarkersEvent(arr: markers)
        }
    }
    
    func addMarkersEvent(arr: NSMutableArray) {
        for i in 0..<arr.count {
            let m : DMMarker = arr.object(at: i) as! DMMarker
            
            m.markerEventDelegate = self as? DMMarkerEventDelegate
        }
    }
}

extension PoiEventViewController: DMMapEventDelegate {
    func ready(_ mapView: DMMapView!, mapInfo: DMMapInfo!) {
        self.mapView = mapView
        
        initPoiEvent()
        
        //do something
    }
    
    func floorEnd(_ floorInfo: DMFloorInfo!, reasonType: ReasonType) {
        
        initPoiEvent()
        
        //do something
    }
    
    func error(_ code: String!, message: String!) {
        print("[PoiEventVC] - CODE : "+code, "/ MESSAGE : "+message);
        
        //handle error
    }
}

extension PoiEventViewController: DMMarkerEventDelegate {
    func click(_ marker: DMMarker!) {
        let alert = UIAlertController.init(title: "POI 선택",
                                           message: "You clicked below item.\n"+marker.title+"("+marker.getId()+")",
                                           preferredStyle: UIAlertController.Style.alert)
        
        let confirmAction = UIAlertAction.init(title: "확인",
                                               style: UIAlertAction.Style.default) { (action) in }
        
        alert.addAction(confirmAction)
        self.present(alert, animated: false, completion: nil)
    }
}
