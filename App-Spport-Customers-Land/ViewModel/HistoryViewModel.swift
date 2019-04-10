//
//  HistoryViewModel.swift
//  App-Spport-Customers-Land
//
//  Created by apple on 1/30/19.
//  Copyright © 2019 haiphat. All rights reserved.
//

import Foundation


class HistoryViewModel: NSObject{
    var id: Int?
    var histTitleResponse: [HistoryTitleResponse] = []
    var itemHistory: [HistoryItemResponse] = []
    var items : [[HistoryItemResponse]] = [[]]
}

extension HistoryViewModel{
    
    func getHistory(onSuccess : @escaping () -> Void,onFail : @escaping (String?) -> Void) -> Void {
        Api.Project.postHistory(id, completion: {
            response in DispatchQueue.main.async {
                let status = response.json()?["status"].int
                let message = response.json()?["message"].string
                if status == 200{
                    let data = Convertor.convertArray(response.json()!["data"]) {
                        json -> HistoryTitleResponse in
                        var historyTitle = HistoryTitleResponse()
                        historyTitle.id = json["id"].int
                        historyTitle.name = json["name"].string
                        
                        let children = Convertor.convertArray(json["children"]){
                            itemJson -> HistoryItemResponse in
                            var item = HistoryItemResponse()
                            item.id = itemJson["id"].int
                            item.name = itemJson["name"].string
                            item.date_payment = itemJson["date_payment"].string
                            item.status = itemJson["status"].int
                            return item
                        }
                        self.itemHistory.append(contentsOf: children)
                        self.items.append(self.itemHistory)
                        return historyTitle
                    }
                    self.histTitleResponse.append(contentsOf: data)
                    
                    onSuccess()
                }else{
                    onFail(message)
                }
            }
        })
    }
}

extension HistoryViewModel{
    
    func getActionForCell(section: Int,index: Int)-> HistoryTitleResponse?{
        if histTitleResponse.count > index {
            return self.histTitleResponse[index]
        }
        return nil
    }
}
