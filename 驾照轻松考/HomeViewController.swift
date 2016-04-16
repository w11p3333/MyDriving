//
//  HomeViewController.swift
//  驾照轻松考
//
//  Created by 卢良潇 on 16/4/17.
//  Copyright © 2016年 卢良潇. All rights reserved.
//

import UIKit
import KGFloatingDrawer

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "轻松考驾照"
        
        //后期改成image
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "菜单", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(HomeViewController.LeftMenuClick))
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    func LeftMenuClick()
    {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.drawerViewController.toggleDrawer(KGDrawerSide.Left, animated: true) { (finished) -> Void  in
            
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
