## Add UIComponent

Custom UIComponent를 추가/제거,

UIComponent 객체 간의 충돌시 UIComponent show/hide 기능을 확인할 수 있는 뷰 컨트롤러 입니다.



## Sample Code

* UIComponentViewController.swift

  * Component 생성

    ```swift
    let imageView: UIImageView = UIImageView.init(frame: CGRect(x: 0.0, 
                                                                y: 0.0, 
                                                                width: 150, 
                                                                height: 40))
    imageView.image = UIImage.init(named: "logo")
            
    let componentArea = DMUIComponent.init(uiComponent: ())
    componentArea.setCurrentSize(CGSize(width: 150, height: 40))
            
    componentArea.addSubview(imageView)
    ```

  * Component 추가/삭제

    ```swift
    self.mapView.addUIComponent(componentArea, order: 2, positionType: TOP_LEFT)
    
    self.mapView.removeUIComponent(componentArea.getId())
    ```
