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

    
    //launchScreen淡入效果
    private func launchAnimation()
    {
        
        let vc = UIStoryboard(name: "LaunchScreen", bundle: nil).instantiateViewControllerWithIdentifier("Launch")
        let launchview = vc.view
        let delegate = UIApplication.sharedApplication().delegate
        let mainWindow = delegate?.window
        mainWindow!!.addSubview(launchview)
        
        
        UIView.animateWithDuration(1, delay: 0.5, options: UIViewAnimationOptions.BeginFromCurrentState, animations: {
            launchview.alpha = 0.0
            launchview.layer.transform = CATransform3DScale(CATransform3DIdentity, 1.5, 1.5, 1.0)
        }) { (finished) in
            launchview.removeFromSuperview()
        }
        
        
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupAllControllers()
        setupTitle()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "settings_icon_account"), style: .Plain, target: self, action: #selector(MainViewController.LeftMenuClick))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "settings_icon_notification"), style: .Plain, target: self, action: "notificationClick")
        let label = UILabel(frame: CGRectMake(0,0,80,20))
        label.text = "驾照轻松考"
        label.textColor = UIColor.whiteColor()
        label.font = UIFont.systemFontOfSize(17, weight: UIFontWeightThin)
        self.navigationItem.titleView = label
    }
    
    static var once:dispatch_once_t = 0

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        dispatch_once(&MainViewController.once) {
            self.launchAnimation()
        }
        
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


    func notificationClick()
    {
    
        let vc = UIStoryboard(name:"Main", bundle: nil).instantiateViewControllerWithIdentifier("notificationVc")
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}
