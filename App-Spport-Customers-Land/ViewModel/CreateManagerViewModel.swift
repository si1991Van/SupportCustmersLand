//
//  CreateManagerViewModel.swift
//  App-Spport-Customers-Land
//
//  Created by apple on 3/5/19.
//  Copyright © 2019 haiphat. All rights reserved.
//

import Foundation
import SwiftyJSON
import UIKit

class CreateManagerViewModel: NSObject {
    var id : Int?
    var fullname: String?
    var phone: String?
    var email: String?
    var title: String?
    var product_type: Int?
    var land_type: Int?
    var address: String?
    var city_id: Int?
    var district_id: Int?
    var area: String?
    var area_type: Int?
    var price: String?
    var price_type: Int?
    var content: String?
    var images: String?
    var type: String?
    var managerResponse : ManagerResponse?
    var typeUpdate : Int?
    var itemUrl : LinkResponse?
    
    var optionResponse = OptionResponse()
}

extension CreateManagerViewModel{
    func getOption(onSuccess : @escaping () -> Void ,onFail : @escaping (String?) -> Void) -> Void {
        Api.consignmentApi.getOption(completion: {response in DispatchQueue.main.async {
            let status = response.json()?["status"].int
            let message = response.json()?["message"].string
            if status == 200{
                let data = response.json()?["data"]
                var response = OptionResponse()
                
                response.product_type = Convertor.convertArray(data!["product_type"]){
                    jsonProduct -> ProductResponse in
                    let producType = ProductResponse()
                    producType.id = jsonProduct["id"].int
                    producType.name = jsonProduct["name"].string
                    producType.type = jsonProduct["type"].int
                    
                    producType.children = Convertor.convertArray(jsonProduct["children"]){ json -> BaseOption in
                        let baseOption = BaseOption()
                        baseOption.id = json["id"].int
                        baseOption.name = json["name"].string
                        baseOption.type = json["type"].int
                        return baseOption
                    }
                    return producType
                }
                response.city = Convertor.convertArray(data!["city"]){
                    jsonCity -> CityResponse in
                    let cityResponse = CityResponse()
                    cityResponse.id = jsonCity["id"].int
                    cityResponse.name = jsonCity["name"].string
                    cityResponse.type = jsonCity["type"].int
                    cityResponse.district = Convertor.convertArray(jsonCity["district"]){ json -> BaseOption in
                        let baseOption = BaseOption()
                        baseOption.id = json["id"].int
                        baseOption.name = json["name"].string
                        baseOption.type = json["type"].int
                        return baseOption
                    }
                    return cityResponse
                }
                
                response.area = Convertor.convertArray(data!["area"]){
                    json -> BaseOption in
                    let baseOption = BaseOption()
                    baseOption.id = json["id"].int
                    baseOption.name = json["name"].string
                    baseOption.type = json["type"].int
                    return baseOption
                }
                
                response.price_type = Convertor.convertArray(data!["price_type"]){
                    json -> BaseOption in
                    let baseOption = BaseOption()
                    baseOption.id = json["id"].int
                    baseOption.name = json["name"].string
                    baseOption.type = json["type"].int
                    return baseOption
                }
                self.optionResponse = response
                onSuccess()
                
            }else{
                onFail(message)
            }
            }
        })
    }
    
    func addManager(onSuccess : @escaping (String?) -> Void ,onFail : @escaping (String?) -> Void) -> Void {
        Api.consignmentApi.addConsignment(fullname: fullname, phone: phone, email: email, title: title, product_type: String(describing: product_type as! Int), land_type: String(describing: land_type as! Int), address: address, city_id: String(describing: city_id as! Int), district_id: String(describing: district_id as! Int), area: area, area_type: String(describing: area_type as! Int), price: price, price_type: String(describing: price_type as! Int), description: content, images: images, completion: {
            response in DispatchQueue.main.async {
                let status = response.json()?["status"].int
                let message = response.json()?["message"].string
                if status == 200{
                    onSuccess(message)
                }else{
                    onFail(message)
                }
            }
        })
    }
    
    
    func updateManager(onSuccess : @escaping (String?) -> Void ,onFail : @escaping (String?) -> Void) -> Void {
        Api.consignmentApi.updateConsignment(id: id, fullname: fullname, phone: phone, email: email, title: title, product_type: product_type, land_type: land_type, address: address, city_id: city_id, district_id: district_id, area: (area as! NSString).floatValue , area_type: area_type, price: (price as! NSString).floatValue, price_type: price_type, description: content, images: images, completion: { response in DispatchQueue.main.async {
                let status = response.json()?["status"].int
                let message = response.json()?["message"].string
                if status == 200{
                    onSuccess(message)
                }else{
                    onFail(message)
                }
            }
            
        })
    }
    
    func updateImage(_ image: UIImage, onSuccess : @escaping () -> Void ,onFail : @escaping (String?) -> Void) -> Void {
//        DgmWaiting.sharedInstance().show()
        Api.uploadImageApi.uploadImage(image, completion: {
            response in DispatchQueue.main.async {
                let status = response.json()?["status"].bool
                let message = response.json()?["message"].string
                if status == true {
                    if let data = response.json()?["data"] {
                        var response = LinkResponse.init()
                        response.url = data["url"].string
                        self.itemUrl = response
                    }
                    onSuccess()
                }else{
                    onFail(message)
                }
            }
            
            
        })
    }
    
}


