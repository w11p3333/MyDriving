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

   
        self.view.backgroundColor = UIColor(white: 0.99, alpha: 0.95)

        self.startBtn.clipsToBounds = true
        self.startBtn.layer.cornerRadius = 40
        //设置轮播
        let scrollImageData = ["scroll1","scroll2","scroll3"]
        cycleScrollView.imageURLStringsGroup = scrollImageData
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
  
 
}
