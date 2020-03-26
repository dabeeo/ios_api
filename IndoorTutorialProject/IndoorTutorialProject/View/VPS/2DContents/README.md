## Add 2DContents 

VPSView에 2D Contents를 추가하는 뷰 컨트롤러 입니다.  

<img src="sample_vps_add_2dContents.gif" width="236.5" height="500" />



## Sample Code

* VPS2DContentsViewController.swift

  * Add 2D Contents

    ```swift
    func setup2DContents() {
            
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
    
    ```



