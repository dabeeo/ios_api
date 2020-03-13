## Init MapView

에디터에서 작업한 지도를 로드하는 뷰 컨트롤러 입니다.

<img src="sample_init_mapview.gif" width="236.5" height="500" />



## Sample Code

* 지도 사용을 위한 인증정보 설정

  * Authorization.swift

    ```swift
    public static func getAuthInfo() -> DMAuthorization {
            return DMAuthorization.init(clientId: [your_client_id],
                                        clientSecret: [your_client_secret])
    }
    ```

* 지도뷰 초기화 및 뷰에 추가 

  * MapViewController.swift

    ```swift
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
    }
    
    extension MapViewController: DMMapEventDelegate {
        func ready(_ mapView: DMMapView!, mapInfo: DMMapInfo!) {
            
        }
        
        func error(_ code: String!, message: String!) {
            
        }
    }
    ```

