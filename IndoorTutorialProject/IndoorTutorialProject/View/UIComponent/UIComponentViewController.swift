//
//  UIComponentViewController.swift
//  IndoorTutorialProject
//
//  Created by DABEEO on 2020/03/03.
//  Copyright © 2020 DABEEO. All rights reserved.
//

import Foundation
import UIKit
import DabeeoMaps_SDK

class UIComponentViewController: UIViewController {
    
    var mapView: DMMapView!
    var componentArea: DMUIComponent!
    
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
    
    @IBAction func addUIComponent() {
        
        let imageView: UIImageView = UIImageView.init(frame: CGRect(x: 0.0, y: 0.0, width: 150, height: 40))
        imageView.image = UIImage.init(named: "logo")
        
        componentArea = DMUIComponent.init(uiComponent: ())
        componentArea.setCurrentSize(CGSize(width: 150, height: 40))
        
        componentArea.addSubview(imageView)
        
        self.mapView.addUIComponent(componentArea, order: 2, positionType: TOP_LEFT)
        
    }
    
    @IBAction func removeUIComponent() {
        self.mapView.removeUIComponent(componentArea.getId())
    }
    
    @IBAction func extendMapView() {
        self.mapUIView.frame.size.width = self.mapUIView.frame.size.width + 20.0
        self.mapUIView.frame.size.height = self.mapUIView.frame.size.height + 20.0
    }
    
    @IBAction func reduceMapView() {
        self.mapUIView.frame.size.width = self.mapUIView.frame.size.width - 20.0
        self.mapUIView.frame.size.height = self.mapUIView.frame.size.height - 20.0
    }
}

extension UIComponentViewController: DMMapEventDelegate {
    func ready(_ mapView: DMMapView!, mapInfo: DMMapInfo!) {
        self.mapView = mapView
        
    }
    
    func error(_ code: String!, message: String!) {
        print("[DrawObjectsVC] - CODE : "+code, "/ MESSAGE : "+message);
    }
}
