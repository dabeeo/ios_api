<img src="/image/logo.png" width="240" height="47.5"></img>



# Tutorial for iOS

본 저장소는 다비오맵스 SDK를 보다 쉽게 적용하기 위한 튜토리얼 프로젝트를 제공합니다.


## Index

1. [Init MapView](/IndoorTutorialProject/IndoorTutorialProject/View/Basic)
2. [Add DrawObjects](/IndoorTutorialProject/IndoorTutorialProject/View/DrawObjects)
3. [Add UIComponent](/IndoorTutorialProject/IndoorTutorialProject/View/UIComponent)
4. [Add Event (Map Poi)](/IndoorTutorialProject/IndoorTutorialProject/View/Event)
5. [Add Event (Custom DrawObjects)](/IndoorTutorialProject/IndoorTutorialProject/View/Event)
6. [Map Animation](/IndoorTutorialProject/IndoorTutorialProject/View/Animation)
7. [Preview](/IndoorTutorialProject/IndoorTutorialProject/View/Navigation)
8. [Init VPSView](/IndoorTutorialProject/IndoorTutorialProject/View/VPS)



## API Document

* 상세 API는  [iOS_국문_v1.1.2.pdf](/iOS_국문_v1.1.2.pdf) 파일을 확인하세요.



## Download

- [다비오맵스 홈페이지](https://dabeeomaps.com/service/ios) 내 좌측 [SDK 다운로드] 탭에서 다운로드



## Project Setting

- General

  - DabeeoMaps Framework 파일을 추가합니다.
    
    <img src="/image/ps01.png" width="600" height="60"></img>

  - Deployment Target을 11.0 이상으로 설정합니다.
    
    <img src="/image/ps02.png" width="600" height="65"></img>

- Build Setting

  - Enable Bitcode를  No 로 설정합니다.

    <img src="/image/ps03.png" width="400" height="55"></img>

- Run > Options Setting

    - Metal API Validation을 Disabled 로 설정합니다.

      <img src="/image/ps04.png" width="650" height="150"></img>



## Info.plist Setting

* Http 통신을 허용합니다.

  ```swift
  <key>NSAppTransportSecurity</key>
   <dict> 
     <key>NSAllowsArbitraryLoads</key>
     <true/>
   </dict>
  ```



## Start

* Import SDK

  ```swift
   import DabeeoMaps_SDK
  ```

