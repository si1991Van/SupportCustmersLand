//
//  SettingViewController.swift
//  App-Spport-Customers-Land
//
//  Created by apple on 1/11/19.
//  Copyright © 2019 haiphat. All rights reserved.
//

import UIKit

class SettingViewController: BaseViewController {

    @IBOutlet weak var tabSetting: UITableView!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var txtTitle: UILabel!
    private var vm = SettingViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        tabSetting.delegate = self
        tabSetting.dataSource = self
        avatar.setCornerRadius()
        avatar.fromUrl(UserService.userInfo?.avatar, placeholder: #imageLiteral(resourceName: "ic_avatar_default"))
        getSetting()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func getSetting(){
        vm.getSetting(onSuccess: {
            self.tabSetting.reloadData()
        }, onFail: {errorMessage in
            Toast.error(errorMessage)
        })
    }
    
    @IBAction func onClickProfile(_ sender: Any) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate{
            appDelegate.goToProfile()
        }
    }
    @IBAction func onClickBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
extension SettingViewController : UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.settingResponse.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tabSetting.dequeueReusableCell(withIdentifier: "SettingTableViewCell") as! SettingTableViewCell
        if let action = vm.getActionForCell(section: indexPath.section, index: indexPath.item) {
            cell.vm = action
            return cell
        }
        
        
        return cell
    }
    
    
}

