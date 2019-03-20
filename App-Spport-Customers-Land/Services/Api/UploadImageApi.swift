//
//  UploadImageApi.swift
//  App-Spport-Customers-Land
//
//  Created by apple on 3/14/19.
//  Copyright © 2019 haiphat. All rights reserved.
//

import Foundation
import UIKit

class UploadImageApi : DgmApi{
    
    var apiUrl: String {
        get {
            return Config.URL_UPLOAD_IMAGE
        }
    }
    
    var apiEndpoint: String {
        get {
            return ""
        }
    }
    
    func uploadImage(_ image: UIImage ,completion: @escaping ((DgmResponse) -> Void)){
        self.upload(method: "file", multipartFormData: {
            (multipartFormData) in
            if let imgData = UIImagePNGRepresentation(image) {
                multipartFormData.append(imgData, withName: "file", fileName: "userAvatar.png", mimeType: "image/png")
            }
        }, completion: completion)
    }
    

}
