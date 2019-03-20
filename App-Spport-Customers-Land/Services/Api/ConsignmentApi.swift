//
//  ConsignmentApi.swift
//  App-Spport-Customers-Land
//
//  Created by apple on 3/2/19.
//  Copyright © 2019 haiphat. All rights reserved.
//

import Foundation
class ConsignmentApi: DgmApi {
    
    var apiUrl: String {
        get {
            return Config.API_URL
        }
    }
    
    var apiEndpoint: String {
        get {
            return "consignment/"
        }
    }
    
    func getOption(completion: @escaping (DgmResponse) -> Void) -> Void {
        self.get(queryString: "get-option", completion: completion)
    }
    
    func getListManager(completion: @escaping (DgmResponse) -> Void) -> Void {
        self.get(queryString: "list-consignment", completion: completion)
    }
    func destroy(id: Int?, completion: @escaping (DgmResponse) -> Void) -> Void{
        self.post(method: "destroy-consignment", params: [
            "id": id ?? ""
            ], completion: completion)
    }
    
    func addConsignment(fullname: String?, phone: String?, email: String?, title: String?, product_type: String?, land_type: String?, address: String?, city_id: String?, district_id: String?, area: String?,
                        area_type: String?, price: String?, price_type: String?, description: String?, images: String?, completion: @escaping (DgmResponse) -> Void) -> Void {
        var params = ["title": title ?? "",
                      "product_type": product_type ?? "",
                      "land_type": land_type ?? ""]
        
        params["address"] = address ?? ""
        params["city_id"] = city_id ?? ""
        params["district_id"] = district_id ?? ""
        params["area"] = area ?? ""
        params["area_type"] = area_type ?? ""
        params["price"] = price ?? ""
        params["price_type"] = price_type ?? ""
        params["description"] = description ?? ""
        params["images"] = images ?? ""
        params["fullname"] = fullname ?? ""
        params["phone"] = phone ?? ""
        params["email"] = email ?? ""
        self.post(method: "add-consignment", params: params, completion: completion)
    }

    func updateConsignment(id: Int?, fullname: String?, phone: String?, email: String?, title: String?, product_type: Int?, land_type: Int?, address: String?, city_id: Int?, district_id: Int?, area: Float?,
                        area_type: Int?, price: Float?, price_type: Int?, description: String?, images: String?, completion: @escaping (DgmResponse) -> Void) -> Void {
        var params = ["id" : id ?? 0,
                      "title": title ?? "",
                      "product_type": product_type ?? 0,
                      "land_type": land_type ?? 0] as [String : Any]
        params["address"] = address ?? ""
        params["city_id"] = city_id ?? 0
        params["district_id"] = district_id ?? 0
        params["area"] = area ?? ""
        params["area_type"] = area_type ?? 0
        params["price"] = price ?? ""
        params["price_type"] = price_type ?? 0
        params["description"] = description ?? ""
        params["images"] = images ?? ""
        params["fullname"] = fullname ?? ""
        params["phone"] = phone ?? ""
        params["email"] = email ?? ""
        
        self.post(method: "update-consignment", params: params, completion: completion)
    }
}
