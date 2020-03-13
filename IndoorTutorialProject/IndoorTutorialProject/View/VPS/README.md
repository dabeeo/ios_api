## Init VPSView

Dabeeo VPS(Vision Positioning System) 기능을 사용할 수 있는 AR, 지도뷰를 나타낸 뷰 컨트롤러 입니다.  


## 측위

VPSView를 사용하기 위해서는 **수집 프로세스**가 필요합니다.  
아래의 Sample Code는 **수집 프로세스**를 진행한 후에 정상작동이 되는 점 참고하시기 바랍니다.

* 자세한 사항은 [Dabeeo](https://www.dabeeo.com/ko/contact/)에 문의 부탁드립니다.

## ARKit
Dabeeo VPS는 Apple ARKit Framework를 이용합니다.  
 * 지원버전 및 기타사항은 [ARKit 가이드](https://developer.apple.com/documentation/arkit?language=objc)를 참고해주시기 바랍니다.  


## Sample Code

* 카메라 사용 권한 설정

  ```swift
  <key>NSCameraUsageDescription</key>
  <string>카메라를 사용합니다!</string>
  ```

* 지도 사용을 위한 인증정보 설정

  - Authorization.swift

    ```swift
    public static func getAuthInfo() -> DMAuthorization {
          	return DMAuthorization.init(clientId: [your_client_id],
          	                            clientSecret: [your_client_secret])
    }
    ```

* VPSView 초기화 및 뷰에 추가

  * VPSViewController.swift

    ```swift
    func setupVPSView() {
            
        let authorization: DMAuthorization = Authorization.getAuthInfo()
        
        // VPS 및 지도 뷰 옵션 생성
        let vpsOptions: VPSOptions = VPSOptions.init()
        let mapOptions: DMMapOptions = DMMapOptions.init()
        
        vpsOptions.timeInterval = 1.0                           // 위치정보 전달 주기
        vpsOptions.timeIntervalAngle = 0.1                      // 진행방향(각도)정보 전달
        vpsView?.mapEvent = self                                // Map Delegate 설정
        vpsView?.vpsEvent = self                                // VPS Delegate 설정
        
        mapOptions.zoom = 3
        
        // VPS 및 Map의 사용을 위한 인증정보 객체 전달
        vpsView?.setVPSOptions(vpsOptions,
                               mapOptions: mapOptions,
                               authorization: authorization)
    }
    
    @available(iOS 11.0, *)
    extension VPSViewController: DMMapEventDelegate {
        
        func ready(_ mapView: DMMapView!, mapInfo: DMMapInfo!) {
            self.mapView = mapView
            
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
        func onLocation(_ location: DMLocation!, direction: CGFloat) { }
        
        // 현재 디바이스의 방향 정보 전달
        func onDirectionAngle(_ angle: CGFloat) { }
        
        // 현재 VPSTrackingState 전달 (상태가 변경될 때만 발생)
        func onState(_ tracking: VPS_Tracking_State) { }
    }
    ```


