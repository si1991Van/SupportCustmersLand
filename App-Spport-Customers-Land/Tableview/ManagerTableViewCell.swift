//
//  ManagerTableViewCell.swift
//  App-Spport-Customers-Land
//
//  Created by apple on 2/12/19.
//  Copyright © 2019 haiphat. All rights reserved.
//

import UIKit

class ManagerTableViewCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var labName: UILabel!
    @IBOutlet weak var labDate: UILabel!
    @IBOutlet weak var labStatus: UILabel!
    
    var vm : ManagerResponse?{
        didSet{
            updateView()
        }
    }
    
    func updateView() {
        if let vm = self.vm{
            self.img.image = #imageLiteral(resourceName: "ic-arrowAltCircleRight")
            self.labName.text = vm.title
            self.labDate.text = vm.create_at
            switch(vm.status){
            case 1?:
                self.labStatus.text = "Đang xử lý"
                break
            case 2?:
                self.labStatus.text = "Tiếp nhận"
                break
            case 3?:
                self.labStatus.text = "Hoàn thành"
                break
            case 4?:
                self.labStatus.text = "Đã huỷ"
                break
            default:
                break
            }
            
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    

}
