//
//  DgmAlert.swift
//  App-Spport-Customers-Land
//
//  Created by apple on 12/29/18.
//  Copyright © 2018 haiphat. All rights reserved.
//

import Foundation
import SCLAlertView

class DgmAlert: NSObject {
    
    @discardableResult class func success(title: String? = Loc("alert-title-success"), text: String? = Loc("alert-text-action-successful")) -> SCLAlertViewResponder? {
        guard let title = title, let text = text else {
            return nil
        }
        let appearance = SCLAlertView.SCLAppearance(
            //            kTitleFont: UIFont.semiboldAppFont(ofSize: 17),
            //            kTextFont: UIFont.appFont(ofSize: 15)
        )
        return SCLAlertView(appearance: appearance).showSuccess(title, subTitle: text, closeButtonTitle: Loc("alert-btn-close"), animationStyle: .noAnimation)
    }
    
    @discardableResult class func error(title: String? = Loc("alert-title-error"), text: String? = Loc("alert-text-action-fail"), textFontSize: CGFloat = 15) -> SCLAlertViewResponder? {
        guard let title = title, let text = text else {
            return nil
        }
        let appearance = SCLAlertView.SCLAppearance(
            kWindowWidth: 300
            //            kTitleFont: UIFont.semiboldAppFont(ofSize: 17),
            //            kTextFont: UIFont.appFont(ofSize: textFontSize)
        )
        return SCLAlertView(appearance: appearance).showError(title, subTitle: text, closeButtonTitle: Loc("alert-btn-close"), colorStyle: UIColor.hex("#DF4A32").colorCode(), animationStyle: .noAnimation)
    }
    
    class func errorGeneric() {
        self.error(text: Loc("error-code-unknown"))
    }
    
    @discardableResult class func confirm(title: String? = Loc("alert-title-confirmation"), text: String?, textFontSize: CGFloat = 15, textConfirmBtn: String = Loc("alert-confirm-ok"),  textCancelBtn: String = Loc("alert-confirm-cancel"), onConfirm: @escaping () -> Void, onCancel: (() -> Void)? = nil) -> SCLAlertViewResponder? {
        guard let title = title, let text = text else {
            return nil
        }
        let appearance = SCLAlertView.SCLAppearance(
            kWindowWidth: 300,
            //            kTitleFont: UIFont.semiboldAppFont(ofSize: 17),
            //            kTextFont: UIFont.appFont(ofSize: textFontSize),
            showCloseButton: false
        )
        let alertView = SCLAlertView(appearance: appearance)
        alertView.iconTintColor = UIColor.white
        alertView.addButton(textConfirmBtn, action: onConfirm)
        alertView.addButton(textCancelBtn, backgroundColor: UIColor.hex("#eeeeee"), textColor: UIColor.hex("#333333"), action: {
            alertView.hideView()
        })
        return alertView.showWarning(title, subTitle: text, closeButtonTitle: Loc("alert-btn-cancel"), colorStyle: UIColor.primary.colorCode(), colorTextButton: UIColor.white.colorCode(), animationStyle: SCLAnimationStyle.noAnimation)
    }
}
extension UIAlertController {
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    open override var shouldAutorotate: Bool {
        return false
    }
}
