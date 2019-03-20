//
//  BookingViewModel.swift
//  App-Spport-Customers-Land
//
//  Created by apple on 2/26/19.
//  Copyright © 2019 haiphat. All rights reserved.
//

import Foundation
class BookingViewModel: NSObject{
    var fullName: String?
    var phone: String?
    var email: String?
    var timeView: String?
    var note: String?
}
extension BookingViewModel{
    func postBooking(onSuccess : @escaping (String?) -> Void,onFail : @escaping (String?) -> Void) -> Void {
        Api.Auth.postBooked(fullName, phone, email, timeView, note, completion: {
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

