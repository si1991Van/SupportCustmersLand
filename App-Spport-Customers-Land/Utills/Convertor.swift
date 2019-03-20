//
//  Convertor.swift
//  App-Spport-Customers-Land
//
//  Created by apple on 12/29/18.
//  Copyright © 2018 haiphat. All rights reserved.
//

import Foundation
import SwiftyJSON

class  Convertor  {
    
    static func convertArray<Entity>(_ json: JSON, transform: (JSON) -> Entity) -> [Entity] {
        var objs: [Entity] = []
        for t in json.arrayValue {
            objs.append(transform(t))
        }
        return objs
    }
    
    static func convertObject<Entity>(_ json: JSON, transform: (JSON) -> Entity) -> Entity {
        return transform(json)
    }
}
