//
//  SettingTableViewCell.swift
//  App-Spport-Customers-Land
//
//  Created by apple on 1/11/19.
//  Copyright © 2019 haiphat. All rights reserved.
//

import UIKit

class SettingTableViewCell: UITableViewCell {

    @IBOutlet weak var switchName: UISwitch!
    @IBOutlet weak var labName: UILabel!
    
    var vm: SettingResponse? {
        didSet {
            updateView()
        }
    }
    
    func updateView(){
        if let vm = self.vm {
            self.labName.text = vm.name
            self.switchName.setOn(vm.status ?? false, animated: false)
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func switchChanged(_ sender: Any) {
        
        SettingViewModel().postSetting(id: vm?.id, status: switchName.isOn, onSuccess: {
        }, onFail: {errorMessage in
            Toast.error(errorMessage)
        })
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
