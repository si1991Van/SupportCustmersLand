//
//  HistoryViewController.swift
//  App-Spport-Customers-Land
//
//  Created by apple on 1/14/19.
//  Copyright © 2019 haiphat. All rights reserved.
//

import UIKit

class HistoryViewController: BaseViewController {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var txtTitle: UILabel!
    @IBOutlet weak var historyTableView: UITableView!
    var vm = HistoryViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        historyTableView.delegate = self
        historyTableView.dataSource = self
        avatar.setCornerRadius()
        avatar.fromUrl(UserService.userInfo?.avatar, placeholder: #imageLiteral(resourceName: "ic_avatar_default"))
        getItemHistory()
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
    
    private func getItemHistory(){
        vm.getHistory(onSuccess: {
            self.historyTableView.reloadData()
        }, onFail: {errorMessage in
            Toast.error(errorMessage)
        })
    }
}

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.itemHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = historyTableView.dequeueReusableCell(withIdentifier: "TabHistoryTableViewCell") as! TabHistoryTableViewCell
        let item = vm.itemHistory[indexPath.row]

            cell.labType.text = item.name
            cell.labDateTime.text = item.date_payment
            cell.img.image = #imageLiteral(resourceName: "ic-arrowAltCircleRight")


        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return vm.histTitleResponse.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return vm.histTitleResponse[section].name
    }
    
}
extension HistoryViewController{
    func viewHistory(id: Int?){
        vm.id = id
    }
}

