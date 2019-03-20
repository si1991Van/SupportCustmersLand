//
//  TabHistoryTableViewCell.swift
//  App-Spport-Customers-Land
//
//  Created by apple on 1/12/19.
//  Copyright © 2019 haiphat. All rights reserved.
//

import UIKit

class TabHistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var labType: UILabel!
    @IBOutlet weak var labDateTime: UILabel!
    @IBOutlet weak var labStatus: UILabel!
    @IBOutlet weak var img: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
