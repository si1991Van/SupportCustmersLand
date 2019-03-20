//
//  ChatResponse.swift
//  App-Spport-Customers-Land
//
//  Created by apple on 3/4/19.
//  Copyright © 2019 haiphat. All rights reserved.
//

import Foundation

class ChatResponse {
    var notviewed: Bool?
    var text: String?
    var timestamp: Double?
    var fullname: String?
    var type: String?
    
    init(fullname: String?, type: String?, timestamp: Double?, text: String?, notviewed: Bool?) {
        self.fullname = fullname
        self.type = type
        self.timestamp = timestamp
        self.text = text
        self.notviewed = notviewed
    }
}
