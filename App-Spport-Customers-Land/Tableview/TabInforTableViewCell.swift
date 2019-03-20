//
//  TabInforTableViewCell.swift
//  App-Spport-Customers-Land
//
//  Created by apple on 3/4/19.
//  Copyright © 2019 haiphat. All rights reserved.
//

import UIKit

class TabInforTableViewCell: UITableViewCell {

    @IBOutlet weak var labTitle: UILabel!
    @IBOutlet weak var labTime: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
