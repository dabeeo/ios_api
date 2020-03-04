## Add Event

에디터에서 작업한 POI, Custom DrawObjects 객체에 Event를 추가하는 뷰 컨트롤러 입니다.



## Sample Code

* PoiEventViewController.swift

  * Init Poi Event

    ```swift
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
    ```

  * Use Poi Event

    ``` swift
    extension PoiEventViewController: DMMarkerEventDelegate {
        func click(_ marker: DMMarker!) {
            //do something
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
    ```




* DrawObjectsEventController.swift

  * Init DrawObjects Event

    ``` 	swift
    func addPolygon() {
        let polygon: DMPolygon = DMPolygon(points: polygonPoints,
                                           options: polygonOptions)
        
        // Polygon Event Delegate 설정
        polygon.polygonEventDelegate = self as? DMPolygonEventDelegate
        polygon.add(to: self.mapView)
    }
    
    func addPolyline() {
        let polyline: DMPolyline = DMPolyline(points: polylinePoints, 
                                              options: polylineOptions)
        
        // Polyline Event Delegate 설정
        polyline.polylineEventDelegate = self as? DMPolylineEventDelegate
        polyline.add(to: self.mapView)
    }
    
    func addCircle() {
        let circle: DMCircle = DMCircle(center: circleCenterPoint, 
                                        options: circleOptions)
        
        // Circle Event Delegate 설정
        circle.circleEventDelegate = self as? DMCircleEventDelegate
       	circle.add(to: self.mapView)
    }
    
    func addMarker() {
        let marker: DMMarker = DMMarker(position: markerPoint, 
                                        options: markerOptions)
        
        // Marker Event Delegate 설정
        marker.markerEventDelegate = self as? DMMarkerEventDelegate
        marker.add(to: self.mapView)
    }
    ```

  * Use DrawObjects Event

    ``` 	swift
    extension DrawObjectsEventViewController: DMPolygonEventDelegate {
        func click(_ polygon: DMPolygon!) {
        	//do something
        }
    }
    
    extension DrawObjectsEventViewController: DMPolylineEventDelegate {
        func click(_ polyline: DMPolyline!) {
            //do something
        }
    }
    
    extension DrawObjectsEventViewController: DMCircleEventDelegate {
        func click(_ circle: DMCircle!) {
            //do something
        }
    }
    
    extension DrawObjectsEventViewController: DMMarkerEventDelegate {
        func click(_ marker: DMMarker!) {
            //do something
        }
    }
    ```

