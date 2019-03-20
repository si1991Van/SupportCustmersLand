//
//  OAuthHandler.swift
//  App-Spport-Customers-Land
//
//  Created by apple on 12/29/18.
//  Copyright © 2018 haiphat. All rights reserved.
//

import Foundation
import Alamofire

class OAuthHandler: RequestAdapter, RequestRetrier {
    private typealias RefreshCompletion = (_ succeeded: Bool) -> Void
    
    private let sessionManager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        return SessionManager(configuration: configuration)
    }()
    
    private let lock = NSLock()
    private var isRefreshing = false
    private var requestsToRetry: [RequestRetryCompletion] = []
    // MARK: - RequestAdapter
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        urlRequest.timeoutInterval = 10
        urlRequest.setValue(DgmLocalizeService.currentLangCode == DgmLocalizeService.English ? "en-US" : "vi-VN" , forHTTPHeaderField: "Accept-Language")
        if let url = urlRequest.url?.absoluteString,let accessToken = UserService.sharedInstance.accessToken {
            print("adapt "+url)
            urlRequest.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
            return urlRequest
        }
        return urlRequest
    }
    
    
    // MARK: - RequestRetrier
    
    func should(_ manager: SessionManager, retry request: Request, with error: Error, completion: @escaping RequestRetryCompletion) {
        lock.lock() ; defer { lock.unlock() }
        if let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 {
            requestsToRetry.append(completion)
            //            if !isRefreshing {
            //                refreshTokens { [weak self] succeeded in
            //                    guard let strongSelf = self else { return }
            //                    strongSelf.lock.lock() ; defer { strongSelf.lock.unlock() }
            //                    strongSelf.requestsToRetry.forEach { $0(succeeded, 0.0) }
            //                    strongSelf.requestsToRetry.removeAll()
            //                }
            //            }
        } else {
            completion(false, 0.0)
        }
        
    }
    
    // MARK: - Private - Refresh Tokens
    //    private func refreshTokens(completion: @escaping RefreshCompletion) {
    //        guard !isRefreshing else { return }
    //        isRefreshing = true
    //        Api.Auth.refreshToken(completion: {
    //            [weak self] response in
    //            guard let strongSelf = self else { return }
    //            completion(response.isSuccess())
    //            if !response.isSuccess() && !response.hasConnectionErrors{
    //                DispatchQueue.main.async {
    //                    UserService.sharedInstance.logout()
    //                }
    //            }
    //            strongSelf.isRefreshing = false
    //        })
    //    }
}
