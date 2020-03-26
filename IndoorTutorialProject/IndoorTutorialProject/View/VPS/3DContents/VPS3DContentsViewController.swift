//
//  VPS3DContentsViewController.swift
//  IndoorTutorialProject
//
//  Created by DABEEO on 2020/03/26.
//  Copyright © 2020 DABEEO. All rights reserved.
//

import Foundation
import UIKit
import DabeeoMaps_SDK

class VPS3DContentsViewController: UIViewController {
    
    var mapView: DMMapView!
    var myLocationMarker: DMMarker!
    var currentFloor: DMFloorInfo? = nil
    
    let arr3dContents: NSMutableArray? = NSMutableArray()
    
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
    
    func setup3DContents() {
        
        let arrContentLocations: NSMutableArray = NSMutableArray()
        
        let biplaneLoc: DMLocation = DMLocation.init(x: 3122, y: 1475, floorLevel: self.currentFloor!.level)
        let robotLoc: DMLocation = DMLocation.init(x: 3061, y: 1229, floorLevel: self.currentFloor!.level)
        
        let biplane: VPS3DContent = VPS3DContent()
        biplane.contentId = "biplane"                                   //Content ID
        biplane.rootName = "toy_biplane"                                //Content 모델 파일 RootName
        biplane.resourceURL = "SCNAssets.scnassets/toy_biplane"         //Content 모델 파일 경로
        biplane.fileFormat = "usdz"                                     //Content 모델 파일 확장자
        biplane.location = biplaneLoc                                   //Content 위치
        biplane.z = -50.0                                               //Content 높이
        biplane.scale = SCNVector3Make(0.01, 0.01, 0.01)                //Content 노출 배율
        biplane.visibleDistance = 10                                     //Content 노출 거리
        biplane.directionType = DIRECTION_FIXING                        //Content 방향 타입
        biplane.direction = 90                                          //Content 방향 각도
        biplane.arContentEvent = self                                   //Content 이벤트 전달 받을 Delgate
        
        let robot: VPS3DContent = VPS3DContent()
        robot.contentId = "robot"
        robot.rootName = "toy_robot_vintage"
        robot.resourceURL = "SCNAssets.scnassets/toy_robot_vintage"
        robot.fileFormat = "usdz"
        robot.location = robotLoc
        robot.z = 20.0
        robot.scale = SCNVector3Make(0.02, 0.02, 0.02)
        robot.visibleDistance = 10
        robot.arContentEvent = self
        
        arr3dContents?.add(biplane)
        arr3dContents?.add(robot)
        
        //AR Viewdp 표시할 3D Contents 설정
        self.vpsView.set3DContents(arr3dContents!)
        
        //Content 위치 표시 - Test용
        arrContentLocations.add(biplaneLoc)
        arrContentLocations.add(robotLoc)

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
    
    func showAlert(msg: String) {
        let alert = UIAlertController.init(title: "",
                                           message: msg,
                                           preferredStyle: UIAlertController.Style.alert)
        
        let confirmAction = UIAlertAction.init(title: "확인",
                                               style: UIAlertAction.Style.default) { (action) in }
        
        alert.addAction(confirmAction)
        self.present(alert, animated: false, completion: nil)
    }
}

@available(iOS 11.0, *)
extension VPS3DContentsViewController: DMMapEventDelegate {
    
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
extension VPS3DContentsViewController: VPSEventDelegate {
    
    // VPSView 초기화 완료
    func vpsReady() {
        
        //3D Contents 설정 및 View에 추가
        setup3DContents()
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
    func network(_ currentRetry: Int32, totalRetry: Int32, currentResult: Bool) {
        if !currentResult {
            if(currentRetry == totalRetry) {
                showAlert(msg: "위치 탐색 실패")
            }
        }
    }
    
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

@available(iOS 11.0, *)
extension VPS3DContentsViewController: VPSARContentEventDelegate {
    
    //Content Click 시, 발생
    func clickContent(_ contentId: String!) {
        self.showAlert(msg: contentId + " Click!!!!")
    }
    
    //Content 노출 시, 발생
    func showContent(_ contentId: String!, distance: CGFloat) {
        print("showContent - contentId : ", contentId, "distance : ", distance)
    }
    
    //Content Render 실패 시, 발생
    func errorContent(_ contentId: String!, message: String!) {
        print("errorContent - contentId : ", contentId, "message : ", message)
    }
}
