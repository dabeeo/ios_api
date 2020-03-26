//
//  VPS2DContentView.swift
//  DabeeoMaps_App
//
//  Created by srkim on 2020/03/16.
//  Copyright © 2020 DABEEO. All rights reserved.
//

import Foundation
import UIKit

class VPS2DContentView: UIView {
    
    @IBOutlet var lbText: UILabel!
    @IBOutlet var ivImage: UIImageView!
    
    static func instanceFromNib() -> VPS2DContentView {
        return Bundle.main.loadNibNamed("VPS2DContentView", owner: self, options: nil)!.first as! VPS2DContentView
    }
}
