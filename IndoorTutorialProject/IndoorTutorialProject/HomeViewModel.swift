//
//  HomeViewModel.swift
//  IndoorTutorialProject
//
//  Created by DABEEO on 2020/03/02.
//  Copyright © 2020 DABEEO. All rights reserved.
//

import Foundation
import UIKit

protocol RouterProtocol {
    func showVC(_ className: String, animated: Bool)
}

class HomeViewModel: NSObject {
    
    var arrMenu: Array<Menu>! = []
    var delegate: RouterProtocol? = nil
    
    override init() {
        
        arrMenu.append(Menu(menuClassName: "MapViewController", title: "1. Basic MapView"))
        arrMenu.append(Menu(menuClassName: "DrawObjectsViewController", title: "2. Add DrawObjects"))
        arrMenu.append(Menu(menuClassName: "UIComponentViewController", title: "3. Add UIComponent"))
        arrMenu.append(Menu(menuClassName: "PoiEventViewController", title: "4. Add Event (Map Poi)"))
        arrMenu.append(Menu(menuClassName: "DrawObjectsEventViewController", title: "5. Add Event (Custom DrawObjects)"))
        arrMenu.append(Menu(menuClassName: "MapAnimationViewController", title: "6. Map Animation"))
        arrMenu.append(Menu(menuClassName: "PreviewViewController", title: "7. Preview"))
        arrMenu.append(Menu(menuClassName: "VPSViewController", title: "8. VPSView"))
        arrMenu.append(Menu(menuClassName: "VPS2DContentsViewController", title: "9. Add 2D Contents"))
        arrMenu.append(Menu(menuClassName: "VPS3DContentsViewController", title: "10. Add 3D Contents"))
    }
}

extension HomeViewModel: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MenuTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuTableViewCell
        
        cell.lbTitle.text = arrMenu[indexPath.row].title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65.0
    }
}

extension HomeViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let menuClass = arrMenu[indexPath.row].menuClassName
        delegate?.showVC(menuClass, animated: true)
    }

}
