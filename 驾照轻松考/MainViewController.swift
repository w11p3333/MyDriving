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
       
    }

    /**
     设置标题样式
     */
    func setupTitle()
    {
        
        title = "驾照轻松考"
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
        titleScrollViewColor = UIColor.whiteColor()
      
        
        
       
    }
    /**
     添加子控制器
     */
    func setupAllControllers()
    {

        let sb = UIStoryboard(name: "Main", bundle: nil)
        let one = sb.instantiateViewControllerWithIdentifier("HomeViewController")
        one.title = "科目一"
        addChildViewController(one)
        let sb2 = UIStoryboard(name: "Main", bundle: nil)
        let two = sb2.instantiateViewControllerWithIdentifier("SubjectTwoVc")
        two.title = "科目二"
        addChildViewController(two)
        let sb3 = UIStoryboard(name: "Main", bundle: nil)
        let three = sb3.instantiateViewControllerWithIdentifier("SubjectThreeVc")
        three.title = "科目三"
        addChildViewController(three)
        let sb4 = UIStoryboard(name: "Main", bundle: nil)
        let chart = sb4.instantiateViewControllerWithIdentifier("MyChartsVc")
        chart.title = "图表"
        addChildViewController(chart)

    }
  
    func LeftMenuClick()
    {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.drawerViewController.toggleDrawer(KGDrawerSide.Left, animated: true) { (finished) -> Void  in
            
        }
    }


}
