//
//  ChangePasswordViewController.swift
//  App-Spport-Customers-Land
//
//  Created by apple on 1/11/19.
//  Copyright © 2019 haiphat. All rights reserved.
//

import UIKit

class ChangePasswordViewController: BaseViewController {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var txtTitle: UILabel!
    
    @IBOutlet weak var txtOldPassword: RoundTextField!
    @IBOutlet weak var txtNewPassword: RoundTextField!
    @IBOutlet weak var txtNewConfirmationPassword: RoundTextField!
    
    var vm = ChangeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        avatar.setCornerRadius()
        avatar.fromUrl(UserService.userInfo?.avatar, placeholder: #imageLiteral(resourceName: "ic_avatar_default"))
    }

    override func localization() {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func onClickSave(_ sender: Any) {
        view.endEditing(true)
        vm.currentPassword = txtOldPassword.text
        vm.newPassword = txtNewPassword.text
        vm.confirmPassword = txtNewConfirmationPassword.text
        if let errorMessage = vm.validate() {
            Toast.error(errorMessage)
        } else {
            DgmWaiting.sharedInstance().show()
            vm.changePassword(onSuccess: {message in
                DgmWaiting.sharedInstance().dismiss()
                DgmAlert.success(title: Loc("alert-title-success"),
                                 text: message)?.setDismissBlock {
                                    self.dismiss(animated: true, completion: nil)
                }
            }, onFail: {errorMessage in
                DgmWaiting.sharedInstance().dismiss()
                Toast.error(errorMessage)
            })
        }
    }
    @IBAction func onClickProfile(_ sender: Any) {
        if let appdelegate = UIApplication.shared.delegate as? AppDelegate{
            appdelegate.goToProfile()
        }
        
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
