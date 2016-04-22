//
//  MainViewController.swift
//  驾照轻松考
//
//  Created by 卢良潇 on 16/4/18.
//  Copyright © 2016年 卢良潇. All rights reserved.
//

import UIKit
import KGFloatingDrawer

class MainViewController: YZDisplayViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupAllControllers()
        setupTitle()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "settings_icon_account"), style: .Plain, target: self, action: #selector(MainViewController.LeftMenuClick))
        let label = UILabel(frame: CGRectMake(0,0,80,20))
        label.text = "驾照轻松考"
        label.textColor = UIColor.whiteColor()
        label.font = UIFont.systemFontOfSize(17, weight: UIFontWeightThin)
        self.navigationItem.titleView = label
    }

    /**
     设置标题样式
     */
    func setupTitle()
    {
        isShowUnderLine = true
        underLineColor = bgcolor
        isShowTitleGradient = true
        isShowTitleCover = false
        
        titleHeight = 38
        
        startR = 170 / 255
        startG = 170 / 255
        startB = 170 / 255
        
        endR = 32 / 255.0
        endG = 142 / 255.0
        endB = 115 / 255.0
        titleScrollViewColor = UIColor(white: 0.91, alpha: 0.99)
    
    }
    /**
     添加子控制器
     */
    func setupAllControllers()
    {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let one = sb.instantiateViewControllerWithIdentifier("HomeViewController")
        one.title = "做题"
        addChildViewController(one)
        let sb2 = UIStoryboard(name: "Main", bundle: nil)
        let chart = sb2.instantiateViewControllerWithIdentifier("MyChartsVc")
        chart.title = "统计"
           addChildViewController(chart)
        let sb3 = UIStoryboard(name: "Main", bundle: nil)
        let video = sb3.instantiateViewControllerWithIdentifier("videoVc")
        video.title = "视频"
        addChildViewController(video)
        let sb4 = UIStoryboard(name: "Main", bundle: nil)
        let book = sb4.instantiateViewControllerWithIdentifier("bookTipsVc")
        book.title = "拿本"
        addChildViewController(book)
    }
  
    func LeftMenuClick()
    {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.drawerViewController.toggleDrawer(KGDrawerSide.Left, animated: true) { (finished) -> Void  in
            
        }
    }


}
