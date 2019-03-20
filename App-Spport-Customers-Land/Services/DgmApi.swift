//
//  DgmApi.swift
//  App-Spport-Customers-Land
//
//  Created by apple on 12/29/18.
//  Copyright © 2018 haiphat. All rights reserved.
//

import Foundation
import Alamofire

protocol DgmApi {
    var apiEndpoint: String { get }
    var apiUrl: String { get }
}

extension DgmApi {
    
    
    
    func post(method : String ,params: [String: Any]?, headers: [String: String]? = nil ,completion: @escaping (DgmResponse) -> Void){
        self.request(url: "/" + apiEndpoint + "/" + method, method: .post,params: params, headers: headers, completion: completion)
    }
    
    func post(method : String ,rawStringJson: String?, headers: [String: String]? = nil ,completion: @escaping (DgmResponse) -> Void){
        self.request(url: "/" + apiEndpoint + "/" + method, method: .post, params: rawStringJson ?? "", headers: headers, completion: completion)
    }
    
    func postUrlEncoded(method : String ,params: [String: Any]?, headers: [String: String]? = nil ,completion: @escaping (DgmResponse) -> Void){
        self.request(url: "/" + apiEndpoint + "/" + method, method: .post,params: params,encoding:URLEncoding.default
            , headers: headers, completion: completion)
    }
    
    func get(queryString: String,  headers: [String: String]? = nil ,completion: @escaping (DgmResponse) -> Void){
        self.request(url: "/" + apiEndpoint + "/" + queryString , method: .get, headers: headers, completion: completion)
    }
    
    func put(method: String,  params: [String: Any]?, headers: [String: String]? = nil ,completion: @escaping (DgmResponse) -> Void){
        self.request(url: "/" + apiEndpoint + "/" + method, method: .put,params: params, headers: headers, completion: completion)
    }
    func put(method: String,  rawStringJson: String?, headers: [String: String]? = nil ,completion: @escaping (DgmResponse) -> Void){
        self.request(url: "/" + apiEndpoint + "/" + method, method: .put, params: rawStringJson ?? "", headers: headers, completion: completion)
    }
    
    func delete(itemId: String,  headers: [String: String]? = nil ,completion: @escaping (DgmResponse) -> Void){
        self.request(url: "/" + apiEndpoint + "/" + itemId, method: .delete, headers: headers, completion: completion)
    }
    
    private func request(url: String, method:HTTPMethod, params: [String: Any]? = nil, encoding: ParameterEncoding = JSONEncoding.default, headers: [String: String]?, completion: @escaping (DgmResponse) -> Void){
        AlamofireHandler.sharedInstance.request(self.apiUrl + url.replacingOccurrences(of: "/+", with: "/", options: .regularExpression, range: nil),
                                                method:method, parameters: params, encoding: encoding, headers: headers).response {
                                                    response in
                                                    completion(DgmResponse(response.data, response.response, response.error))
        }
    }
    
    private func request(url: String, method:HTTPMethod, params: String, headers: [String: String]?, completion: @escaping (DgmResponse) -> Void){
        var urlRequest = URLRequest.init(url: URL.init(string: self.apiUrl + url.replacingOccurrences(of: "/+", with: "/", options: .regularExpression, range: nil))!)
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        urlRequest.httpBody = params.data(using: .utf8)
        AlamofireHandler.sharedInstance.request(urlRequest: urlRequest).response {
            response in
            completion(DgmResponse(response.data, response.response, response.error))
        }
    }
    
    func upload(method: String,multipartFormData: @escaping (MultipartFormData) -> Void,headers: [String: String]? = nil, completion: @escaping (DgmResponse) -> Void) -> Void {
        let subUrl = "/" + apiEndpoint + "/" + method
        AlamofireHandler.sharedInstance.upload(multipartFormData: multipartFormData,
                                               to: apiUrl + subUrl.replacingOccurrences(of: "/+", with: "/", options: .regularExpression, range: nil),
                                               method:.post,  headers: headers, encodingCompletion: { encodingResult in
                                                switch encodingResult {
                                                case .success(let upload, _, _):
                                                    upload.response { response in
                                                        completion(DgmResponse(response.data, response.response, response.error))
                                                    }
                                                    break
                                                case .failure(let encodingError):
                                                    completion(DgmResponse(nil, nil, encodingError))
                                                    break
                                                }
        })
    }
    
    func parseUrlWithParams(_ url: String, params: [String: Any?]?) -> String {
        var fragments: [String] = []
        if params == nil {
            return url
        }
        let urlParams = url.components(separatedBy: ["/"])
        for p in urlParams {
            if p.hasPrefix("{") && p.hasSuffix("}") {
                let paramName = p.replacingOccurrences(of: "{", with: "").replacingOccurrences(of: "}", with: "")
                if let value = params?[paramName] {
                    if value != nil {
                        if let appendedValue = "\(value!)".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed) {
                            fragments.append(appendedValue)
                        }
                    }
                }
            }
            else {
                fragments.append(p)
            }
        }
        return fragments.joined(separator: "/")
    }
    
    func parseUrlQueryStringWithParams(_ url: String, params: [String: Any?]?) -> String {
        var ret = url
        if let params = params {
            let urlParams = url.components(separatedBy: ["&", "?", "/"])
            for p in urlParams {
                if p.hasPrefix("{") && p.hasSuffix("}") {
                    let paramName = p.replacingOccurrences(of: "{", with: "").replacingOccurrences(of: "}", with: "")
                    if let value = params[paramName] {
                        if let array = value as? [AnyObject] {
                            var fragments: [String] = []
                            array.forEach({ (t) in
                                if let appendedValue = "\(t)".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed) {
                                    fragments.append(paramName + "=" + appendedValue)
                                }
                            })
                            ret = ret.replacingOccurrences(of: p, with: fragments.joined(separator: "&"))
                        } else {
                            if value != nil {
                                if let appendedValue = "\(value!)".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed) {
                                    ret = ret.replacingOccurrences(of: p, with: paramName + "=" + appendedValue)
                                    
                                }
                            }
                        }
                    } else {
                        ret = ret.replacingOccurrences(of: p, with: "")
                    }
                }
            }
        }
        return ret
    }
    
    private var authorizationString: String? {
        get {
            if let accessToken = UserService.sharedInstance.accessToken {
                return "Bearer \(accessToken)"
            }
            return nil
        }
    }
    
}
