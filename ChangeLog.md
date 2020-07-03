# SDK Change Log


## v1.1.9

### 새로운 기능

- MapHandle Drag Hidden 기능 추가 (언제든지 MapHandle 켜고, 끄기 가능 )

### 버그 수정

- Navigation Event 중 directions 호출 추기 변경 

---

## v1.1.8

### 새로운 기능

- MapHandle Drag 기능 추가 (mapViewHandleEnable: ,moveBar: )
- MapView Pinch Point Rotate 기능 추가 (2개의 손가락 사이의 점을 기준으로 맵을 회전 시킬 수 있습니다.) 

### 버그 수정

- Navigation 경유지 설정 후 경로를 검색하면서 SDK가 멈추는(Crash) 버그를 수정하였습니다.
- Navigation 이동 수단 Boundary 체크 오류 수정 (이동 수단 근처로 가지 않아도 간헐적으로 이동 수단 이용 중 팝업이 뜨는 버그를 수정하였습니다. )

---

## v1.1.7

### 새로운 기능

- MapView에 Handle을 추가하여 드래그 & 리사이즈 기능을 제공합니다. 

### 버그 수정

- VPS2DContent 스크린 뷰에 붙는 버그를 수정하였습니다.

---

## v1.1.6

### 새로운 기능

- VPS3DContent, VPS2DContent 추가, 삭제시 이벤트를 받을 수 있습니다.

### 버그 수정

- VPS3DContent 최초 AR 킷 실행 시 카메라가 보는 각도로 돌아가져 있는 버그를 수정하였습니다. 

---

## v1.1.5

### 버그 수정

- VPS3DContent의 위치가 올바르지 않게 노출되는 버그를 수정하였습니다.
- VPS3DContent의 속성이 SCNNode(AR객체)에 적용되지 않는 버그를 수정하였습니다.

---

## v1.1.4

### 새로운 기능

- VPS3DContent를 통하여 AR 장면에 3D Contents의 추가, 이동, 삭제가 가능합니다. 또한, Contents File이 갖고있는 AnimationKey를 조회하고 실행할 수 있습니다.
  - VPS3DContentsViewController에서 사용방법을 확인하세요.

