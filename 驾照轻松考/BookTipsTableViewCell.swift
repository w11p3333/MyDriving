//
//  BookTipsTableViewCell.swift
//  驾照轻松考
//
//  Created by 卢良潇 on 16/4/22.
//  Copyright © 2016年 卢良潇. All rights reserved.
//

import UIKit

class BookTipsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var BgView: UIView!
   
    @IBOutlet weak var imageBgView: UIView!

    @IBOutlet weak var image_view: UIImageView!

    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
