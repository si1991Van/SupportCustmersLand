//
//  UserViewController.swift
//  App-Spport-Customers-Land
//
//  Created by apple on 1/14/19.
//  Copyright © 2019 haiphat. All rights reserved.
//

import UIKit
import Cosmos

class UserViewController: BaseViewController ,UITextFieldDelegate {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var txtTitle: UILabel!
    @IBOutlet weak var scronllVIewChat: UIScrollView!
    @IBOutlet weak var txtContent: UITextField!
    @IBOutlet weak var collectionSale: UICollectionView!
    
    private var vm = SaleViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        avatar.setCornerRadius()
        avatar.fromUrl(UserService.userInfo?.avatar, placeholder: #imageLiteral(resourceName: "ic_avatar_default"))
            txtContent.delegate = self
        collectionSale.delegate = self
        collectionSale.dataSource = self
        getSale()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

    @objc func keyboardWillShow(note: Notification) {
        let userInfo = note.userInfo
        let keyboardFrame = userInfo?[UIKeyboardFrameEndUserInfoKey] as! CGRect
        let contentInset = UIEdgeInsetsMake(0.0, 0.0, keyboardFrame.height, 0.0)
        self.scronllVIewChat.contentInset = contentInset
        self.scronllVIewChat.scrollIndicatorInsets = contentInset
        self.scronllVIewChat.scrollRectToVisible(txtContent.frame, animated: true)
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        let contentInset = UIEdgeInsets.zero
        self.scronllVIewChat.contentInset = contentInset
        self.scronllVIewChat.scrollIndicatorInsets = contentInset
    }
    
    func textFieldShouldReturn(_ txtNote: UITextField) -> Bool {
        self.view.endEditing(true)
        
        return false
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onClickProfile(_ sender: Any) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate{
            appDelegate.goToProfile()
        }
    }
    @IBAction func onClickBack(_ sender: Any) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate{
            appDelegate.goToMain()
        }
    }
    
    @IBAction func onClickSend(_ sender: Any) {
        self.postFeedback()
    }
    
    
}

extension UserViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm.item.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionSale", for: indexPath) as! SaleCollectionViewCell
        vm.saleId = cell.saleId
        vm.transactionId = cell.transactionId
        vm.rank = Int(cell.rating)
        if let action = vm.getActionForCell(section: indexPath.section, index: indexPath.item, position : indexPath.row) {
            cell.vm = action
            
            return cell
        }
        
        
        return cell
    }
    
   
}

extension UserViewController {
    
    func viewTabUserProjectId(id : Int?){
        self.vm.id = id
    }
    
    private func getSale(){
        self.vm.getSale(onSuccess: {
            self.collectionSale.reloadData()
        }, onFail: {errorMessage in
            Toast.error(errorMessage)
        })
    }
    
    private func postFeedback(){
        vm.note = txtContent.text
        DgmWaiting.sharedInstance().show()
        self.vm.postFeedback(onSuccess: { message in
            DgmWaiting.sharedInstance().dismiss()
            Toast.success(message!)
        }, onFail: { errorMessage in
            DgmWaiting.sharedInstance().dismiss()
            Toast.error(errorMessage)
        })
    }
    
}
