//
//  HomeViewController.swift
//  驾照轻松考
//
//  Created by 卢良潇 on 16/4/17.
//  Copyright © 2016年 卢良潇. All rights reserved.
//

import UIKit
import KGFloatingDrawer
import SDCycleScrollView

class HomeViewController: UIViewController {

    @IBOutlet weak var cycleScrollView: SDCycleScrollView!
    @IBOutlet weak var startBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "轻松考驾照"
        self.view.backgroundColor = UIColor(white: 0.95, alpha: 0.9)
        //后期改成image
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "菜单", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(HomeViewController.LeftMenuClick))
        self.startBtn.clipsToBounds = true
        self.startBtn.layer.cornerRadius = 50
        //设置轮播
        let scrollImageData = ["scroll1","scroll2","scroll3"]
        cycleScrollView.imageURLStringsGroup = scrollImageData
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

 
}
