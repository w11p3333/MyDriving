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

let bgcolor = UIColor(red: 41/255, green: 157/255, blue: 133/255, alpha: 1.0)

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
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.rootViewController = drawerViewController
        window?.makeKeyAndVisible()
        setupUI()
         
        // Override point for customization after application launch.
        return true
        
    }
    
    
    func  setupUI()
    {
        
        let navigationTitleAttribute : NSDictionary = NSDictionary(object: UIColor.whiteColor(),forKey: NSForegroundColorAttributeName)
        
        UINavigationBar.appearance().titleTextAttributes = navigationTitleAttribute as? [String : AnyObject]
        
        //返回键颜色
        UINavigationBar.appearance().barStyle = UIBarStyle.Default
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        //背景颜色
        UINavigationBar.appearance().barTintColor = bgcolor
        
       
        

    }
    
    func prepareDrawerViewController() ->     KGDrawerViewController {
        let drawerViewController = KGDrawerViewController()
        drawerViewController.centerViewController = UINavigationController(rootViewController: MainViewController())
        
        drawerViewController.leftViewController = viewControllerForStoryboardId("LeftMenuViewController")
        
        drawerViewController.leftDrawerWidth = CGFloat(150)
        //背景图片
        _drawerViewController = drawerViewController
        return drawerViewController
    }
    
    
    private func drawerStoryboard() -> UIStoryboard {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard
    }
    
    private func viewControllerForStoryboardId(storyboardId: String) -> UIViewController {
        let viewController: UIViewController = drawerStoryboard().instantiateViewControllerWithIdentifier(storyboardId) as! UIViewController
        return viewController
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

