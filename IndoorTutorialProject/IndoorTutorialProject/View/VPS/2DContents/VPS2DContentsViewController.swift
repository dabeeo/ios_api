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
}

@available(iOS 11.0, *)
extension VPS2DContentsViewController: DMMapEventDelegate {
    
    func ready(_ mapView: DMMapView!, mapInfo: DMMapInfo!) {
        self.mapView = mapView
        
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
        //do something
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
