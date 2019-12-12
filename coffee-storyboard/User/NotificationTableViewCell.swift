//
//  NotificationTableViewCell.swift
//  coffee-storyboard
//
//  Created by Do Thai Bao on 12/12/19.
//  Copyright © 2019 Do Thai Bao. All rights reserved.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {

    @IBOutlet weak var notificationLabel: UILabel!
    @IBOutlet weak var notificationSwitch: UISwitch!
    override func awakeFromNib() {
        super.awakeFromNib()
        notificationSwitch.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
