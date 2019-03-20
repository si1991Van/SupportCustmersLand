//
//  SignInViewController.swift
//  App-Spport-Customers-Land
//
//  Created by apple on 12/31/18.
//  Copyright © 2018 haiphat. All rights reserved.
//

import UIKit

class SignInViewController: BaseViewController, UITextFieldDelegate{
    @IBOutlet weak var txtEmail: RoundTextField!
    @IBOutlet weak var txtPassword: RoundTextField!
    
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var btnForgotPassword: UIButton!
    var vm = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtPassword.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFileldShouldReturn(_ textFiled: UITextField) -> Bool{
        self.txtPassword.resignFirstResponder()
        return true
    }
   
    override func localization() {
            self.txtEmail.placeholder = Loc("place_holder_email")
            self.txtPassword.placeholder = Loc("place_holder_password")
            self.btnSignIn.setTitle(Loc("btn_sign_in"), for: .normal)
            
                    self.btnForgotPassword.setTitle(Loc("btn_forgot_password"), for: .normal)
    }
    
    @IBAction func onClickLogin(_ sender: Any) {
        view.endEditing(true)
        vm.email = txtEmail.text
        vm.password = txtPassword.text
        if let errorMessage = vm.validate() {
            Toast.error(errorMessage)
        } else {
            DgmWaiting.sharedInstance().show()
            vm.login(onSuccess: onLoginSuccessful, onFail: onLoginFailed)
        }
    }
    
    private func onLoginSuccessful(){
        DgmWaiting.sharedInstance().dismiss()
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.goToMain()
            appDelegate.updateFCMToken()
        }
    }
    
    private func onLoginFailed(errorMessage : String?) {
        DgmWaiting.sharedInstance().dismiss()
        Toast.error(errorMessage)
    }
}
