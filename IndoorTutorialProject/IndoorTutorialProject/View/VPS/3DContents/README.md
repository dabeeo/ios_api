## Add 3DContents 

VPSView에 3D Contents를 추가하는 뷰 컨트롤러 입니다.  

<img src="sample_vps_add_3dContents.gif" width="236.5" height="500" />




## Contents 모델 파일 

* 지원 확장자
  * .usdz
  * .dae

* 프로젝트 내부 **.scnassets 폴더**에 위치하여야 함.



## Sample Code

* VPS3DContentsViewController.swift

  * Add 3D Contents

    ```swift
    func setup3DContents() {
            
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
        biplane.visibleDistance = 5                                     //Content 노출 거리
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
        robot.visibleDistance = 5
        robot.arContentEvent = self
        
        arr3dContents?.add(biplane)
        arr3dContents?.add(robot)
        
        //AR Viewdp 표시할 3D Contents 설정
        self.vpsView.set3DContents(arr3dContents!)
        
        ...
    }
    
    @available(iOS 11.0, *)
    extension VPSViewController: DMMapEventDelegate {
        
        func ready(_ mapView: DMMapView!, mapInfo: DMMapInfo!) {
            self.mapView = mapView
            self.currentFloor = mapView.floorInfo()
            
            //내 위치 마커 추가
            setupMyLocationMarker()
            
            //do something
        }
        
        func error(_ code: String!, message: String!) {
            //handle error
        }
    }
    
    @available(iOS 11.0, *)
    extension VPSViewController: VPSEventDelegate {
        
        // VPSView 초기화 완료
        func vpsReady() {
            //3D Contents 설정 및 View에 추가
            setup3DContents()
        }
        
        ...
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
    ```



