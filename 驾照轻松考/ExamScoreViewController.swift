//
//  ExamScoreViewController.swift
//  驾照轻松考
//
//  Created by 卢良潇 on 16/4/23.
//  Copyright © 2016年 卢良潇. All rights reserved.
//

import UIKit

class ExamScoreViewController: UIViewController {

    
    var score:Int = 0
    
    @IBOutlet weak var bgView: UIView!
    
    
    @IBOutlet weak var secondView: UIView!
    
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var scoreDescLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.title = "发表成绩"
        scoreLabel.text = String(score)
        scoreDescLabel.text = score > 90 ? "欢迎老司机的诞生。" : ":前面的老司机带带我..."
        
        
        //添加阴影效果
        addShadow(bgView)
        addShadow(secondView)
        
        let date = NSDate()
        let dayFormatter = NSDateFormatter()
        dayFormatter.dateFormat = "yyy-MM-dd"
        let dayTime = dayFormatter.stringFromDate(date) as String
        timeLabel.text =  "驾照轻松考" +   dayTime
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "分享", style: .Plain, target: self, action: #selector(ExamScoreViewController.shareClick))
        
        // Do any additional setup after loading the view.
    }
    
    
    func addShadow(view:UIView)
    {
      view.layer.shadowColor = UIColor.blackColor().CGColor
        view.layer.shadowOffset = CGSizeMake(1, 1)
        view.layer.shadowOpacity = 0.8
        view.layer.shadowRadius = 10
        view.clipsToBounds = false
    }
    
    
    func shareClick()
    {
    
    }

   
}
