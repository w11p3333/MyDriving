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

    @IBOutlet weak var threeConstraint: NSLayoutConstraint!
    @IBOutlet weak var twoConstraint: NSLayoutConstraint!
    @IBOutlet weak var oneConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var cycleScrollView: SDCycleScrollView!
    @IBOutlet weak var startBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        //计算四个按钮等距
        let constraint = (self.view.frame.width - 40 - 20 - 4 * 64 ) / 3
        threeConstraint.constant = constraint
        twoConstraint.constant = constraint
        oneConstraint.constant = constraint
        
        self.view.backgroundColor = UIColor(white: 0.99, alpha: 0.95)

        self.startBtn.clipsToBounds = true
        self.startBtn.layer.cornerRadius = 40
        //设置轮播
        let scrollImageData = ["scroll1","scroll2","scroll3"]
        cycleScrollView.imageURLStringsGroup = scrollImageData
        // Do any additional setup after loading the view.
    }

    @IBAction func oneBtnClick(sender: AnyObject) {
        
        let vc = RxWebViewController(url: NSURL(string: "http://mnks.jxedt.com/ckm4/"))
        self.navigationController?.pushViewController(vc, animated: true)
    }
 
    @IBAction func twoBtnClick(sender: AnyObject) {
        let vc = RxWebViewController(url: NSURL(string: "http://mnks.jxedt.com/ckm4/"))
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func threeBtnClick(sender: AnyObject) {
        let vc = RxWebViewController(url: NSURL(string: "http://mnks.jxedt.com/ckm4/"))
        self.navigationController?.pushViewController(vc, animated: true)

    }

    @IBAction func fourBtnClick(sender: AnyObject) {
        let vc = RxWebViewController(url: NSURL(string: "http://mnks.jxedt.com/ckm4/"))
        self.navigationController?.pushViewController(vc, animated: true)

    }
}
