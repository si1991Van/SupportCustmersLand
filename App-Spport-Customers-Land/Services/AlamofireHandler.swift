//
//  AlamofireHandler.swift
//  App-Spport-Customers-Land
//
//  Created by apple on 12/29/18.
//  Copyright © 2018 haiphat. All rights reserved.
//

import Foundation
import Alamofire

class AlamofireHandler {
    fileprivate static var instance : AlamofireHandler?
    
    static var sharedInstance: AlamofireHandler{
        if (instance == nil) {
            instance = AlamofireHandler()
        }
        return instance!
    }
    
    fileprivate let sessionManager : SessionManager
    init() {
        let oauthHandler = OAuthHandler()
        sessionManager = SessionManager()
        sessionManager.adapter = oauthHandler
        sessionManager.retrier = oauthHandler
    }
    
    public func request(
        _ url: URLConvertible,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = URLEncoding.default,
        headers: HTTPHeaders? = nil)
        -> DataRequest {
            return self.sessionManager.request( url,
                                                method: method,
                                                parameters: parameters,
                                                encoding: encoding,
                                                headers: headers).validate()
    }
    
    public func request(
        urlRequest: URLRequest)
        -> DataRequest {
            return self.sessionManager.request(urlRequest).validate()
    }
    
    public func upload(
        multipartFormData: @escaping (MultipartFormData) -> Void,
        usingThreshold encodingMemoryThreshold: UInt64 = SessionManager.multipartFormDataEncodingMemoryThreshold,
        to url: URLConvertible,
        method: HTTPMethod = .post,
        headers: HTTPHeaders? = nil,
        encodingCompletion: ((SessionManager.MultipartFormDataEncodingResult) -> Void)?){
        return self.sessionManager.upload(
            multipartFormData: multipartFormData,
            usingThreshold: encodingMemoryThreshold,
            to: url,
            method: method,
            headers: headers,
            encodingCompletion: encodingCompletion
        )
    }
    
    public func download(
        _ url: URLConvertible,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = URLEncoding.default,
        headers: HTTPHeaders? = nil,
        to destination: DownloadRequest.DownloadFileDestination? = nil)
        -> DownloadRequest
    {
        return Alamofire.download(url, method: method, parameters: parameters, encoding: encoding, headers: headers, to: destination)
    }
}
