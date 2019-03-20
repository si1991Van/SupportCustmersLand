//
//  ManageViewController.swift
//  App-Spport-Customers-Land
//
//  Created by apple on 1/14/19.
//  Copyright © 2019 haiphat. All rights reserved.
//

import UIKit

class ManageViewController: BaseViewController {

    @IBOutlet weak var txtTitle: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var btnCreateManager: UIButton!
    @IBOutlet weak var managerTableview: UITableView!
    var vm = ManagerViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        managerTableview.delegate = self
        managerTableview.dataSource = self
        avatar.setCornerRadius()
        avatar.fromUrl(UserService.userInfo?.avatar, placeholder: #imageLiteral(resourceName: "ic_avatar_default"))
        btnCreateManager.layer.cornerRadius = btnCreateManager.bounds.size.width / 2
        btnCreateManager.clipsToBounds = true
        
        getItem()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getItem()
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
    
    private func getItem(){
        vm.getItem(onSuccess: {
            self.managerTableview.reloadData()
        }, onFail: {errorMessage in
            Toast.error(errorMessage)
        })
    }
    
    private func destroy(){
        DgmWaiting.sharedInstance().show()
        vm.destroy(onSuccess: { message in
            DgmWaiting.sharedInstance().dismiss()
            DgmAlert.success(title: Loc("alert-title-success"),
                             text: message)?.setDismissBlock {
                                self.dismiss(animated: true, completion: nil)
            }
            self.getItem()
        }, onFail: {errorMessage in
            DgmWaiting.sharedInstance().dismiss()
            Toast.error(errorMessage)
        })
    }
    
    @IBAction func onClickCreateManager(_ sender: Any) {
        
    }
}

extension ManageViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.managerResponse.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = managerTableview.dequeueReusableCell(withIdentifier: "ManagerTableViewCell") as! ManagerTableViewCell
        if let action = vm.getActionForCell(section: indexPath.section, indext: indexPath.item) {
            cell.vm = action
            return cell
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        if vm.managerResponse[indexPath.row].status == 4 || vm.managerResponse[indexPath.row].status == 3{
            return []
        }else{
            let more = UITableViewRowAction(style: .normal, title: "Chỉnh sửa") { action, index in
                
                if let vc = UIStoryboard.initViewController(storyboard: "Home", viewController: "CreateManagerViewController") as? CreateManagerViewController {
                    vc.viewPushDataManager(managerResponse: self.vm.managerResponse[index.row], type: self.vm.type)
                    self.present(vc, animated: true, completion: nil)
                }
            }
            more.backgroundColor = UIColor.blue
            
            let share = UITableViewRowAction(style: .normal, title: "Huỷ") { action, index in
                self.vm.id = self.vm.managerResponse[indexPath.row].id
                self.destroy()
            }
            share.backgroundColor = UIColor.red
            return [share, more]
            
        }
    }
    
    
}
