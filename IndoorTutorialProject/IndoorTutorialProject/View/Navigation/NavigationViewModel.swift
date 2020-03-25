//
//  NavigationViewModel.swift
//  IndoorTutorialProject
//
//  Created by DABEEO on 2020/03/04.
//  Copyright © 2020 DABEEO. All rights reserved.
//

import Foundation
import DabeeoMaps_SDK

class NavigationViewModel: NSObject {
    
    var navigation: DMNavigation!
    
    var startLocation: DMLocation!
    var endLocation: DMLocation!
    var currentFloor : DMFloorInfo!
    
    var originMarker: DMMarker!
    var destinationMarker: DMMarker!
    var pathLine: DMPolyline!
    
    var route: DMRoute!
    var isNavigating: Bool! = false
    
    var delegate: PreviewDelegate? = nil
    
    override init() {
        
    }
    
    func readyForNavigation(mapView: DMMapView, navigationMode: DMNavigationMode) {
        
        let naviOptions: DMNavigationOptions = DMNavigationOptions.init()
        
        switch navigationMode {
        case NAVIGATION_MODE_PREVIEW:
            naviOptions.mode = NAVIGATION_MODE_PREVIEW
            naviOptions.remainingPath.width = 3
            
            break
        case NAVIGATION_MODE_GUIDANCE:
            
            break
        case NAVIGATION_MODE_SIMULATE:
            
            break
        default:
            break
        }
        
        
        self.navigation = DMNavigation.init(map: mapView,
                                            origin: self.startLocation,
                                            destination: self.endLocation,
                                            wayLocations: nil,
                                            options: naviOptions)
        self.drawPath(mapView: mapView)
        
        delegate?.readyNavigation()
    }
    
    func start() {
        self.navigation.startDirections()
    }
    
    func cancel() {
        self.navigation.cancelDirections()
        hideMarkers()
        hidePath()
        
        startLocation = nil
        endLocation = nil
    }
    
    func drawPath(mapView: DMMapView) {
        
        if(navigation == nil || startLocation == nil || endLocation == nil) {
            return
        }
        
        if(isNavigating) {
            return
        }
        
        drawMarkers(mapView: mapView)
        
        route = getRoute()
        
        if (route != nil) {
            let points: NSMutableArray = getFloorPathPoint(route.sectionList,
                                                            self.currentFloor.level)
            
            let polylineOptions: DMPolylineOptions = DMPolylineOptions.init()
            polylineOptions.width = 3
            polylineOptions.color = "#1DDB16"
            
            pathLine = DMPolyline.init(points: points, options: polylineOptions)
            pathLine.isVisible = true
            
            pathLine.add(to: mapView)
        }
        
    }
    
    func getRoute() -> DMRoute {
        let r: DMRoute = (navigation != nil ? navigation.routes : nil)!
        return r
    }
    
    func drawMarkers(mapView: DMMapView) {
        originMarker = self.navigation.originMarker
        destinationMarker = self.navigation.destinationMarker
        
        originMarker?.position = DMPoint.init(x: self.startLocation.x, y: self.startLocation.y, z: 0.0)
        destinationMarker?.position = DMPoint.init(x: self.endLocation.x, y: self.endLocation.y, z: 0.0)
        
        originMarker.displayType = MARKER_DISPLAY_ALL
        destinationMarker.displayType = MARKER_DISPLAY_ALL
        
        if(originMarker != nil
            && mapView.floorInfo()?.level == self.startLocation.floorLevel) {
            
            originMarker?.add(to: mapView)
        }
        
        if(destinationMarker != nil
            && mapView.floorInfo()?.level == self.endLocation.floorLevel) {
            destinationMarker?.add(to: mapView)
        }
    }
    
    func hideMarkers() {
        originMarker.displayType = MARKER_DISPLAY_NONE
        destinationMarker.displayType = MARKER_DISPLAY_NONE
    }
    
    func hidePath() {
        pathLine.remove()
    }
    
    //해당 층의 Path Point 가져오기
    func getFloorPathPoint(_ route : NSMutableArray, _ floorLevel : Int) -> NSMutableArray {
        
        let ret: NSMutableArray = []
        let pathList : NSMutableArray = []
        
        for i in 0..<route.count {
            let section : DMNavigationSection = route.object(at: i) as! DMNavigationSection
            
            if(section.floorLevel != floorLevel) {
                continue // 현재층의 location이 아니면 패스
            }
            
            pathList.addObjects(from:section.pathList as! [Any])
        }
        
        for i in 0..<pathList.count {
            let loc = pathList.object(at: i) as! DMNavigationLocation

            let p : DMPoint = DMPoint.init(x: loc.x, y: loc.y, z: 0.0)
            ret.add(p)
        }

        return ret
    }
}
