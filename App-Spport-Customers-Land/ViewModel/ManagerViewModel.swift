//
//  ManagerViewModel.swift
//  App-Spport-Customers-Land
//
//  Created by apple on 2/12/19.
//  Copyright © 2019 haiphat. All rights reserved.
//

import Foundation
class ManagerViewModel: NSObject {
    var id : Int?
    var type: Int = 111
    
    var managerResponse: [ManagerResponse] = []
}
extension ManagerViewModel{
    func getItem(onSuccess: @escaping () -> Void, onFail: @escaping (String?) ->Void) -> Void{
        Api.consignmentApi.getListManager(completion: {response in DispatchQueue.main.async {
            self.managerResponse.removeAll()
            let status = response.json()?["status"].int
            let message = response.json()?["message"].string
            if status == 200{
                let data = Convertor.convertArray(response.json()!["data"]){
                    json -> ManagerResponse in
                    var managerResponse = ManagerResponse()
                    managerResponse.id = json["id"].int
                    managerResponse.title = json["title"].string
                    managerResponse.product_type = json["product_type"].int
                    managerResponse.land_type = json["land_type"].int
                    managerResponse.address = json["address"].string
                    managerResponse.city_id = json["city_id"].int
                    managerResponse.district_id = json["district_id"].int
                    managerResponse.area = json["area"].float
                    managerResponse.area_type = json["area_type"].int
                    managerResponse.price = json["price"].float
                    managerResponse.price_type = json["price_type"].int
                    managerResponse.discription = json["description"].string
                    managerResponse.fullname = json["fullname"].string
                    managerResponse.phone = json["phone"].string
                    managerResponse.email = json["email"].string
                    managerResponse.status = json["status"].int
                    managerResponse.create_at = json["created_at"].string
                    managerResponse.images = json["images"].string
                    
                    return managerResponse
                }
                self.managerResponse.append(contentsOf: data)
                onSuccess()
            }else{
                onFail(message)
            }
            
        }})
    }
    
    func destroy(onSuccess: @escaping (String?) -> Void, onFail: @escaping (String?) ->Void) -> Void {
        Api.consignmentApi.destroy(id: id, completion: {response in DispatchQueue.main.async {
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
    
}

extension ManagerViewModel{
    func getActionForCell(section: Int, indext: Int) -> ManagerResponse? {
        if managerResponse.count > indext{
            return self.managerResponse[indext]
        }
        return nil
    }
}
