//
//  SpotCell.swift
//  TabBarSample
//
//  Created by 田中康介 on 2019/10/13.
//  Copyright © 2019 田中康介. All rights reserved.
//

import UIKit

class SpotCell: UITableViewCell {
    @IBOutlet weak var imageview: UIImageView!
    
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
