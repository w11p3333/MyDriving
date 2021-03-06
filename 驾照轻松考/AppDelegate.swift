//
//  AppDelegate.swift
//  驾照轻松考
//
//  Created by 卢良潇 on 16/4/17.
//  Copyright © 2016年 卢良潇. All rights reserved.
//

import UIKit
import KGFloatingDrawer
import FMDB


//全局背景色
let bgGrayColor = UIColor(white: 0.99, alpha: 0.95)
//全局主题绿色
let bgcolor = UIColor(red: 41/255, green: 157/255, blue: 133/255, alpha: 1.0)
//总做题数
var finishedNum:Int = 0
//总答对数
var rightNum:Int = 0
//总答错数
var wrongNum:Int = 0

//当前页
var currentPage:Int = 0


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    
    var _drawerViewController: KGDrawerViewController?
    
    var drawerViewController: KGDrawerViewController {
        get {
            if let viewController = _drawerViewController {
                return viewController
            }
            
            return prepareDrawerViewController()
        }
    }
    
    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        loadDefault()
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.rootViewController = drawerViewController
        window?.makeKeyAndVisible()
        setupUI()
       
        return true
        
    }
    
    //加载用户保存数据
    func loadDefault()
    {
     if NSUserDefaults.standardUserDefaults().boolForKey("firstLaunch")
     {
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "firstLaunch")
        //初始化数据
        finishedNum = 0
        rightNum = 0
        wrongNum = 0
        currentPage = 0
        }
        else
     {
        finishedNum = NSUserDefaults.standardUserDefaults().integerForKey("finishedNum")
        wrongNum = NSUserDefaults.standardUserDefaults().integerForKey("wrongNum")
        rightNum = NSUserDefaults.standardUserDefaults().integerForKey("rightNum")
        currentPage = NSUserDefaults.standardUserDefaults().integerForKey("currentPage")
        }
     
    }
    
    
    /**
     设置UI
     */
    func  setupUI()
    {
        
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        let navigationTitleAttribute : NSDictionary = NSDictionary(object: UIColor.whiteColor(),forKey: NSForegroundColorAttributeName)
        
        UINavigationBar.appearance().titleTextAttributes = navigationTitleAttribute as? [String : AnyObject]
        //返回键颜色
        UINavigationBar.appearance().barStyle = UIBarStyle.Default
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        //背景颜色
        UINavigationBar.appearance().barTintColor = bgcolor
    }
    
    
    
    
    
    // MARK: 创建侧边视图
    
    func prepareDrawerViewController() ->     KGDrawerViewController {
        let drawerViewController = KGDrawerViewController()
        drawerViewController.centerViewController = UINavigationController(rootViewController: MainViewController())
        
        drawerViewController.leftViewController = viewControllerForStoryboardId("LeftMenuViewController")
        
        drawerViewController.leftDrawerWidth = CGFloat(200)
        //背景图片
        _drawerViewController = drawerViewController
        return drawerViewController
    }
    
    
    private func drawerStoryboard() -> UIStoryboard {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard
    }
    
    private func viewControllerForStoryboardId(storyboardId: String) -> UIViewController {
        let viewController: UIViewController = drawerStoryboard().instantiateViewControllerWithIdentifier(storyboardId) 
        return viewController
    }

    
    /**
     保存数据

     */
    func applicationWillResignActive(application: UIApplication) {
        //进入后台之前保存数据
        
        NSUserDefaults.standardUserDefaults().setInteger(finishedNum, forKey: "finishedNum")
        NSUserDefaults.standardUserDefaults().setInteger(rightNum, forKey: "rightNum")
        NSUserDefaults.standardUserDefaults().setInteger(wrongNum, forKey: "wrongNum")
        NSUserDefaults.standardUserDefaults().setInteger(currentPage, forKey: "currentPage")
        print("保存数据成功")
    }

 
}

