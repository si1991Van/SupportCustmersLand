//
//  Toast.swift
//  App-Spport-Customers-Land
//
//  Created by apple on 12/29/18.
//  Copyright © 2018 haiphat. All rights reserved.
//

import Foundation
import SwiftMessages

class Toast {
    
    static var config: SwiftMessages.Config {
        get {
            var c = SwiftMessages.Config()
            c.presentationContext = .window(windowLevel: UIWindowLevelStatusBar)
            return c
        }
    }
    
    class func error(_ errorMsg: String?) {
        guard var errorMsg = errorMsg else {
            return
        }
        errorMsg = errorMsg.trimmingCharacters(in: .whitespacesAndNewlines)
        if errorMsg.isEmpty {
            return
        }
        let view = MessageView.viewFromNib(layout: .messageView)
        view.configureTheme(backgroundColor: UIColor.hex("#DF4A32"), foregroundColor: UIColor.white, iconImage: IconStyle.default.image(theme: .error))
        view.configureDropShadow()
        view.configureContent(body: errorMsg)
        view.button?.isHidden = true
        view.titleLabel?.isHidden = true
        view.tapHandler = {
            _ in
            SwiftMessages.hide()
        }
        SwiftMessages.show(config: config, view: view)
    }
    
    class func warning(_ warningMessage: String?) {
        guard var warningMessage = warningMessage else {
            return
        }
        warningMessage = warningMessage.trimmingCharacters(in: .whitespacesAndNewlines)
        if warningMessage.isEmpty {
            return
        }
        let view = MessageView.viewFromNib(layout: .messageView)
        view.configureTheme(backgroundColor: UIColor.hex("#ff9900"), foregroundColor: UIColor.white, iconImage: IconStyle.default.image(theme: .warning))
        view.configureDropShadow()
        view.configureContent(body: warningMessage)
        view.button?.isHidden = true
        view.titleLabel?.isHidden = true
        view.tapHandler = {
            _ in
            SwiftMessages.hide()
        }
        SwiftMessages.show(config: config, view: view)
    }
    
    
    class func success(_ message: String) {
        let view = MessageView.viewFromNib(layout: .messageView)
        view.configureTheme(backgroundColor: UIColor.hex("#22B573"), foregroundColor: UIColor.white, iconImage: IconStyle.default.image(theme: .success))
        view.configureDropShadow()
        view.configureContent(title: Loc("alert-title-success"), body: message)
        view.button?.isHidden = true
        view.tapHandler = {
            _ in
            SwiftMessages.hide()
        }
        SwiftMessages.show(config: config, view: view)
    }
}
