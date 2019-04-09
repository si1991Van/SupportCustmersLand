//
//  SaleViewModel.swift
//  App-Spport-Customers-Land
//
//  Created by apple on 1/30/19.
//  Copyright © 2019 haiphat. All rights reserved.
//

import Foundation

class SaleViewModel: NSObject{
    var transactionId: Int?
    var note: String?
    var rank: Int?
    var saleId: Int?
    var id: Int?
    var item: [SaleResponse] = []
}
extension SaleViewModel{
    
    func getSale(onSuccess : @escaping () -> Void,onFail : @escaping (String?) -> Void) -> Void {
        Api.Project.postSaleProject(id, completion: {
            response in DispatchQueue.main.async {
                let status = response.json()?["status"].int
                let message = response.json()?["message"].string
                if status == 200{
                    let data = Convertor.convertArray(response.json()!["data"]) {
                        json -> SaleResponse in
                        var saleResponse = SaleResponse()
                        saleResponse.id = json["id"].int
                        saleResponse.name = json["name"].string
                        saleResponse.fullname = json["fullname"].string
                        saleResponse.project_name = json["project_name"].string
                        saleResponse.transaction_id = json["transaction_id"].int
                        saleResponse.avatar = json["avatar"].string
                        saleResponse.rank = json["rank"].int
                        return saleResponse
                    }
                    self.item.append(contentsOf: data)
                    onSuccess()
                }else{
                    onFail(message)
                }
            }
        })
    }
    
    func postFeedback(onSuccess : @escaping (String?) -> Void,onFail : @escaping (String?) -> Void) -> Void {
        Api.Project.postFeedback(id, transactionId, saleId, rank, note, completion: {
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
    
    
}
extension SaleViewModel{
    
    func getActionForCell(section: Int,index: Int, position: Int)-> SaleResponse?{
        if item.count > index {
            self.saleId = self.item[position].id
            self.transactionId = self.item[position].transaction_id
            return self.item[index]
        }
        return nil
    }

}

