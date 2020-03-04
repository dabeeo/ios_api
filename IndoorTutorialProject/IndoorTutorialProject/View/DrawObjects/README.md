## Add DrawObjects  

 MapView에 DrawObjects를 추가하는 뷰 컨트롤러 입니다.  



## Sample Code 

* DrawObjectsViewController.swift

  * Add Polygon

    ```swift
    func addPolygon() {
            
            // Polygon 포인트 설정
            // Polygon 포인트는 시계 방향 순서대로 add
            let polygonPoints : NSMutableArray = []
            
            polygonPoints.add(DMPoint(x: 2550.0, y: 1100.0, z: 0.0))
            polygonPoints.add(DMPoint(x: 2950.0, y: 1250.0, z: 0.0))
            polygonPoints.add(DMPoint(x: 3000.0, y: 1350.0, z: 0.0))
            polygonPoints.add(DMPoint(x: 2350.0, y: 1350.0, z: 0.0))
            
            // Polygon 옵션값 설정
            let polygonOptions: DMPolygonOptions = DMPolygonOptions.init()
            polygonOptions.strokeColor = "#FFE400"
            polygonOptions.fillColor = "#FFE400"
            
            // Polygon 초기화
            let polygon: DMPolygon = DMPolygon(points: polygonPoints,
                                               options: polygonOptions)
            
            // Polygon Event Delegate 설정
            polygon.polygonEventDelegate = self as? DMPolygonEventDelegate
            
            // 해당 지도에 Polygon 추가
            polygon.add(to: self.mapView)
    }
    ```

  * Add Polyline

    ```swift
    func addPolyline() {
            
            // Polyline 포인트 설정
            // Polyline 포인트는 라인의 포인트 순서로 add
            let polylinePoints : NSMutableArray = []
            polylinePoints.add(DMPoint(x: 3000.0, y: 1000.0, z: 0.0))
            polylinePoints.add(DMPoint(x: 3200.0, y: 1200.0, z: 0.0))
            polylinePoints.add(DMPoint(x: 3300.0, y: 1500.0, z: 0.0))
            
            // Polyline 옵션값 설정
            let polylineOptions: DMPolylineOptions = DMPolylineOptions.init()
            polylineOptions.width = 7
            polylineOptions.startCap = CAPTYPE_ROUND
            polylineOptions.endCap = CAPTYPE_ROUND
            polylineOptions.joinType = JOINTYPE_ROUND
            polylineOptions.color = "#FF007F"
            
            // Polyline 초기화
            let polyline: DMPolyline = DMPolyline(points: polylinePoints, 
                                                  options: polylineOptions)
            
            // Polyline Event Delegate 설정
            polyline.polylineEventDelegate = self as? DMPolylineEventDelegate
            
            // 해당 지도에 Polyline 추가
            polyline.add(to: self.mapView)
    }
    ```

  * Add Circle

    ```swift
    func addCircle() {
            
            // Circle 포인트 설정
            let circleCenterPoint = DMPoint.init(x: 3000.0, y: 1500.0, z: 0.0)
            
            // Circle 옵션값 설정
            let circleOptions: DMCircleOptions = DMCircleOptions.init()
            circleOptions.radius = 50;                  
            circleOptions.fillColor = "#BCE55C"         
            circleOptions.strokeColor = "#000000"      
            
            // Circle 초기화
            let circle: DMCircle = DMCircle(center: circleCenterPoint, 
                                            options: circleOptions)
            
            // Circle Event Delegate 설정
            circle.circleEventDelegate = self as? DMCircleEventDelegate
            
            // 해당 지도에 Circle 추가
            circle.add(to: self.mapView)
    }
    ```

  * Add Marker

    ```swift
    func addMarker() {
            
         
            // Marker 포인트 설정
            let markerPoint = DMPoint(x: 2900.0, y: 1500.0, z: 0.0)
            
            let imgUrl: String = "https://indoor.dabeeomaps.com/image/assets/logo_maps-3x-54848d261e3cc1fbd0465a25c50dcc7a.png"
            let image = DMImage.init(imageURL: imgUrl,
                                        width: 200.0,
                                        height: 50.0)
            
            let anchorPoint: DMPoint = DMPoint.init(x: 50, y: 50.0, z: 0.0)
            
            // Marker 옵션값 설정
            let markerOptions : DMMarkerOptions = DMMarkerOptions.init(anchor: anchorPoint,
                                                                       opacity: 1.0,
                                                                       priority: 0,
                                                                       title: "",
                                                                       icon: image,
                                                                       displayType: MARKER_DISPLAY_ALL,
                                                                       autoScale: true,
                                                                       autoRotate: true,
                                                                       fontColor: "#5CD1E5",
                                                                       fontSize: 50,
                                                                       fontWeight: MARKER_FONTWEIGHT_NORMAL,
                                                                       align: MARKER_ALIGN_CENTER,
                                                                       spacing: 30,
                                                                       rotate: 0.0)
            // Marker 초기화
            let marker: DMMarker = DMMarker(position: markerPoint, options: markerOptions)
            
            // Marker Event Delegate 설정
            marker.markerEventDelegate = self as? DMMarkerEventDelegate
            
            // 해당 지도에 Marker 추가
            marker.add(to: self.mapView)
    }
    ```
