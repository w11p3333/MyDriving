//
//  UIChooseAnswerTableViewCell.swift
//  驾照轻松考
//
//  Created by 卢良潇 on 16/4/18.
//  Copyright © 2016年 卢良潇. All rights reserved.
//

import UIKit

class UIChooseAnswerTableViewCell: UITableViewCell {

    @IBOutlet weak var answerStatusImage: UIImageView!
   
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
