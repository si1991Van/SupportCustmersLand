//
//  TabInfoViewModel.swift
//  App-Spport-Customers-Land
//
//  Created by apple on 3/4/19.
//  Copyright © 2019 haiphat. All rights reserved.
//

import Foundation
class TabInforViewModel: NSObject {
    var id: Int?
    var categoryId: Int?
    var page: Int?
    var current: Int?
    var categoryItem : [CategoryNewsResponse]  = []
    var item : [NewsResponse] = []
}
extension TabInforViewModel{
    func getCategory(onSuccess : @escaping () -> Void,onFail : @escaping (String?) -> Void) -> Void {
        Api.news.getCategory(completion: { response in DispatchQueue.main.async {
            let status = response.json()?["status"].int
            let message = response.json()?["message"].string
            if status == 200{
               let data = Convertor.convertArray(response.json()!["data"]){
                    json -> CategoryNewsResponse in
                    var categoryResponse = CategoryNewsResponse()
                    categoryResponse.id = json["id"].int
                    categoryResponse.name = json["name"].string
                    
                    return categoryResponse
                }
                self.categoryItem.append(contentsOf: data)
                onSuccess()
            }else{
                onFail(message)
            }
            }
        })
    }
    
    func getNewsItems(onSuccess : @escaping () -> Void,onFail : @escaping (String?) -> Void) -> Void {
        Api.news.postItemCategroy(id, categoryId, page, current, completion: {
            response in DispatchQueue.main.async {
                let status = response.json()?["status"].int
                let message = response.json()?["message"].string
                if status == 200{
                    let data = Convertor.convertArray(response.json()!["data"]){
                        json -> NewsResponse in
                        var newsResponse = NewsResponse()
                        newsResponse.id = json["id"].int
                        newsResponse.category_id = json["category_id"].int
                        newsResponse.content = json["content"].string
                        newsResponse.description = json["description"].string
                        newsResponse.image_url = json["image_url"].string
                        newsResponse.project_id = json["project_id"].int
                        newsResponse.title = json["title"].string
                        newsResponse.created_at = json["created_at"].string
                        newsResponse.slug = json["slug"].string
                        return newsResponse
                    }
                    self.item.append(contentsOf: data)
                    onSuccess()
                }else{
                    onFail(message)
                }
            }
        })
    }
}
