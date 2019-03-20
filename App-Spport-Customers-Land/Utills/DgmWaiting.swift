//
//  DgmWaiting.swift
//  App-Spport-Customers-Land
//
//  Created by apple on 12/29/18.
//  Copyright © 2018 haiphat. All rights reserved.
//

import Foundation
import UIKit

class DgmWaiting : NSObject {
    static internal var dgmWaiting: DgmWaiting? = nil
    var loadingOverlay: LoadingOverlay?
    static func sharedInstance() -> DgmWaiting {
        if(dgmWaiting == nil){
            dgmWaiting = DgmWaiting()
        }
        return dgmWaiting!
    }
    
    func show(title: String? = Loc("alert-title-loading"), text: String? = Loc("alert-text-please-wait")) ->Void{
        self.dismiss()
        let rv = UIApplication.shared.keyWindow! as UIWindow
        self.loadingOverlay = LoadingOverlay.init(frame: rv.bounds)
        self.loadingOverlay?.initialView()
        self.loadingOverlay?.setTitle(title: title)
        rv.addSubview(loadingOverlay!)
        //        if let view = rv.rootViewController?.view {
        //            self.loadingOverlay = LoadingOverlay.init(frame: rv.bounds)
        //            if let loadingView = self.loadingOverlay {
        //                view.addSubview(loadingView)
        //            }
        //
        //            loadingOverlay?.translatesAutoresizingMaskIntoConstraints = false
        //            self.loadingOverlay?.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        //            self.loadingOverlay?.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        //            self.loadingOverlay?.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        //            self.loadingOverlay?.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        //            self.loadingOverlay?.initialView()
        //            self.loadingOverlay?.setTitle(title: title)
        //        }
    }
    
    func dismiss() -> Void {
        if let loadingView = self.loadingOverlay {
            loadingView.destroy()
            loadingView.removeFromSuperview()
            self.loadingOverlay = nil
        }
    }
}

class LoadingOverlay : UIView{
    var activityIndicator: UIActivityIndicatorView!
    var loadingBackground: UIView!
    var lbLoading: UILabel!
    
    open func initialView(){
        self.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.loadingBackground = UIView()
        self.addSubview(loadingBackground)
        self.loadingBackground?.translatesAutoresizingMaskIntoConstraints = false
        self.loadingBackground?.layer.cornerRadius = 3
        self.loadingBackground?.backgroundColor = UIColor.white
        self.loadingBackground.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        self.loadingBackground.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        // add loding indicator
        self.activityIndicator = UIActivityIndicatorView()
        self.activityIndicator?.translatesAutoresizingMaskIntoConstraints = false
        self.activityIndicator.tintColor = UIColor.black
        self.loadingBackground?.addSubview(activityIndicator)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        activityIndicator.startAnimating();
        activityIndicator.leftAnchor.constraint(equalTo: self.loadingBackground.leftAnchor, constant: 30).isActive = true
        activityIndicator.topAnchor.constraint(equalTo: self.loadingBackground.topAnchor, constant: 15).isActive = true
        activityIndicator.bottomAnchor.constraint(equalTo: self.loadingBackground.bottomAnchor, constant: -15).isActive = true
        self.lbLoading = UILabel()
        self.lbLoading?.translatesAutoresizingMaskIntoConstraints = false
        self.loadingBackground?.addSubview(lbLoading)
        self.lbLoading.font = UIFont.systemFont(ofSize: 14)
        self.lbLoading.textColor = UIColor.defaultTextColor
        lbLoading.leftAnchor.constraint(equalTo: self.activityIndicator.rightAnchor, constant: 10).isActive = true
        lbLoading.rightAnchor.constraint(equalTo: self.loadingBackground.rightAnchor, constant: -30).isActive = true
        lbLoading.centerYAnchor.constraint(equalTo: self.loadingBackground.centerYAnchor, constant: 0).isActive = true
    }
    func setTitle(title: String? = Loc("alert-title-loading")){
        self.lbLoading?.text = title
    }
    func destroy(){
        activityIndicator = nil
        loadingBackground = nil
        lbLoading = nil
    }
}
