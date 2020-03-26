//
//  VPS2DContentsViewController.swift
//  IndoorTutorialProject
//
//  Created by DABEEO on 2020/03/26.
//  Copyright © 2020 DABEEO. All rights reserved.
//

import Foundation
import UIKit
import DabeeoMaps_SDK

class VPS2DContentsViewController: UIViewController {

    var mapView: DMMapView!
    var myLocationMarker: DMMarker!
    var currentFloor: DMFloorInfo? = nil
    
    let arr2dContents: NSMutableArray? = NSMutableArray()
    
    @IBOutlet var vpsView: DMVPSView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupVPSView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    func setupVPSView() {
        
        let authorization: DMAuthorization = Authorization.getAuthInfo()
        
        // VPS 및 지도 뷰 옵션 생성
        let vpsOptions: DMVPSOptions = DMVPSOptions.init()
        let mapOptions: DMMapOptions = DMMapOptions.init()
        
        vpsOptions.timeInterval = 0.02                           // 위치정보 전달 주기
        vpsOptions.timeIntervalAngle = 0.02                      // 진행방향(각도)정보 전달 주기

        vpsView?.mapEvent = self                                // Map Delegate 설정
        vpsView?.vpsEvent = self                                // VPS Delegate 설정
        
        // VPS 및 Map의 사용을 위한 인증정보 객체 전달
        vpsView?.setVPSOptions(vpsOptions,
                               mapOptions: mapOptions,
                               authorization: authorization)
    }
    
    func setupMyLocationMarker() {
        let markerPoint = DMPoint(x: 0, y: 0, z: 0.0)
        let uiimg = UIImage.init(named: "img_mylocation")
        let img = DMImage.init(uiImage: uiimg)
        img?.width = CGFloat(100 * 0.4)
        img?.height = CGFloat(100 * 0.4)
        
        myLocationMarker = DMMarker(position: markerPoint)
        
        myLocationMarker?.icon = img
        myLocationMarker?.displayType = MARKER_DISPLAY_ICON
        myLocationMarker?.isAutoScale = true
        myLocationMarker?.isAutoRotate = true
        myLocationMarker?.add(to: self.mapView)
    }
    
    func setup2DContents() {
        
        let arrContentLocations: NSMutableArray = NSMutableArray()
        
        let c1Loc: DMLocation = DMLocation.init(x: 3122, y: 1475, floorLevel: self.currentFloor!.level)
        let c2Loc: DMLocation = DMLocation.init(x: 3061, y: 1229, floorLevel: self.currentFloor!.level)
        
        DispatchQueue.main.async {
            let c1: VPS2DContent = VPS2DContent.init()
            c1.contentId = "content01"                                  //Content ID
            
            let view1: VPS2DContentView = VPS2DContentView.instanceFromNib()
            view1.ivImage.image = UIImage.init(named: "logo")!
            view1.lbText.text = "1번입니다"
            c1.contentView = view1                                      //Content 뷰
            
            c1.location = c1Loc                                         //Content 위치
            c1.scale = SCNVector3Make(0.1, 0.1, 0.1)                    //Content 노출 비율
            
            let c2: VPS2DContent = VPS2DContent.init()
            c2.contentId = "content02"
            
            let view2: VPS2DContentView = VPS2DContentView.instanceFromNib()
            view2.ivImage.image = UIImage.init(named: "logo")!
            view2.lbText.text = "2번입니다"
            c2.contentView = view2
            
            c2.location = c2Loc
            
            self.arr2dContents!.add(c1)
            self.arr2dContents!.add(c2)
            
            self.vpsView?.set2DContents(self.arr2dContents!)
        }
        
        //Content 위치 표시 - Test용
        arrContentLocations.add(c1Loc)
        arrContentLocations.add(c2Loc)

        showContentsLocation(arrLocations: arrContentLocations)
    }
    
    func showContentsLocation (arrLocations : NSMutableArray) {
        
        for i in 0..<arrLocations.count {
            let location: DMLocation = arrLocations.object(at: i) as! DMLocation
            let point: DMPoint = DMPoint.init(x: location.x, y: location.y, z: 0.0)
            
            let circle: DMCircle = DMCircle(center: point)
            circle.radius = 10
            circle.fillColor = "#00ff00"
            circle.add(to: self.mapView)
        }
    }
}

@available(iOS 11.0, *)
extension VPS2DContentsViewController: DMMapEventDelegate {
    
    func ready(_ mapView: DMMapView!, mapInfo: DMMapInfo!) {
        
        self.mapView = mapView
        self.currentFloor = mapView.floorInfo()
        
        setupMyLocationMarker()
        
        //do something
    }
    
    func error(_ code: String!, message: String!) {
        //handle error
    }
}

@available(iOS 11.0, *)
extension VPS2DContentsViewController: VPSEventDelegate {
    
    // VPSView 초기화 완료
    func vpsReady() {
        
        //2D Contents 설정 및 View에 추가
        setup2DContents()
    }
    
    // VPSView 초기화 실패
    func vpsError(_ code: String!, message: String!) {
        //handle error
    }
    
    // 디바이스의 tilt각도의 XZ 및 XY 정보
    func tiltXZ(_ xz: Double, xy: Double) { }
    
    // 위치 통신 시작
    func beginNetwork() { }
    
    // 위치 통신 시
    func network(_ currentRetry: Int32, totalRetry: Int32, currentResult: Bool) { }
    
    // 위치 통신 종료
    func endNetwork() { }
    
    // MotionGuideView show
    func showMotionView() { }
    
    // MotionGuideView hide
    func hideMotionView() { }
    
    // 현재 위치정보, 현재 디바이스 방향 정보 전달
    func onLocation(_ location: DMLocation!, direction: CGFloat) {
        
        DispatchQueue.main.async {
            
            let loc: DMPoint = DMPoint.init(x: location.x, y: location.y, z: 0)
            
            if self.myLocationMarker?.mapView != nil {
                //내 위치 마커 > 현 위치로 표시.
                self.myLocationMarker?.position = loc
                self.mapView.mapCenter = self.myLocationMarker?.position
            }
        }
    }
    
    // 현재 디바이스의 방향 정보 전달
    func onDirectionAngle(_ angle: CGFloat) { }
    
    // 현재 VPSTrackingState 전달 (상태가 변경될 때만 발생)
    func onState(_ tracking: VPS_Tracking_State) { }
    
    func onMoving(_ moving: VPS_Moving_State) { }
    
}
