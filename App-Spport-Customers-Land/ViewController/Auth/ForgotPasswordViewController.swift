//
//  ForgotPasswordViewController.swift
//  App-Spport-Customers-Land
//
//  Created by apple on 1/8/19.
//  Copyright © 2019 haiphat. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: BaseViewController {

    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    var vm = ForgotPasswordViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func localization() {

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onClickForgotPassword(_ sender: Any) {
        view.endEditing(true)
        vm.phone = txtPhone.text
        if let errorMessage = vm.validate() {
            Toast.error(errorMessage)
        } else {
            DgmWaiting.sharedInstance().show()
            vm.forgotPassword(onSuccess: { message in
                DgmWaiting.sharedInstance().dismiss()
                
                DgmAlert.success(title: Loc("alert-title-success"),
                                 text: message)?.setDismissBlock {
                                    self.dismiss(animated: true, completion: nil)
                }
            }, onFail: { errorMessage in
                DgmWaiting.sharedInstance().dismiss()
                Toast.error(errorMessage)
            })
        }
        
    }
        
        
    
    @IBAction func onBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
