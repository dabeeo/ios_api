//
//  Authorization.swift
//  IndoorTutorialProject
//
//  Created by DABEEO on 2020/03/03.
//  Copyright © 2020 DABEEO. All rights reserved.
//

import Foundation
import DabeeoMaps_SDK

class Authorization: NSObject {
    
    override init() {
        super.init()
    }
    
    public static func getAuthInfo() -> DMAuthorization {
        return DMAuthorization.init(clientId: "28AXw_veA2YbNKDP6poTpT",
                                    clientSecret: "70c540c169af62808f4da3709e988e06")
    }
}
