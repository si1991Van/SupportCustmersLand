//
//  DgmResponse.swift
//  App-Spport-Customers-Land
//
//  Created by apple on 12/29/18.
//  Copyright © 2018 haiphat. All rights reserved.
//

import Foundation
import SwiftyJSON

class DgmResponse {
    var data: Data?
    var error: Error?
    var response: HTTPURLResponse?
    var statusCode: Int? {
        get {
            return response?.statusCode
        }
    }
    
    init(_ data: Data?, _ response: URLResponse? , _ error: Error?) {
        self.data = data
        self.error = error
        if let httpResponse = response as? HTTPURLResponse {
            self.response = httpResponse
        }
        
    }
    
    var hasConnectionErrors: Bool {
        if (error as? URLError) != nil {
            return true
        }
        return false
    }
    
    var hasNoNetworkError: Bool {
        if let error = error as? URLError {
            if error.code == .notConnectedToInternet {
                return true
            }
        }
        return false
    }
    
    var hasNoResponseError: Bool {
        if let error = error as? URLError {
            if error.code != .notConnectedToInternet {
                return true
            }
        }
        return false
    }
    
    var errorMessage: String? {
        if statusCode == 401 {
            return nil
        }
        if hasConnectionErrors {
            if self.hasNoNetworkError {
                return Loc("no-internet-connection")
            } else if self.hasNoResponseError {
                return Loc("cannot-connect-to-server")
            } else {
                return Loc("cannot-connect-to-server")
            }
        }
        let arrayError =  json()?["message"].array
        var errors: [String] = []
        if arrayError != nil {
            for item in (arrayError)!{
                errors.append(item.string!)
            }
        }
        return errors.joined(separator: "/")
    }
    
    func json() -> JSON?{
        guard let data = data else {
            return nil
        }
        return try! JSON(data: data)
        
    }
    
    func isSuccess() -> Bool {
        return statusCode == 200
    }
    
    
    /*
     logout when got 401 error
     */
    func check401Error() {
        if statusCode == 401 {
            UserService.sharedInstance.logout()
        }
    }
}
