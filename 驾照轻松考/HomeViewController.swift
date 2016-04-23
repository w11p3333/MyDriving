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

 
    @IBOutlet weak var teamView: UIView!
    
    @IBOutlet weak var totalNumLabel: UILabel!
    
    @IBOutlet weak var unfinishedLabel: UILabel!
    
    @IBOutlet weak var finishedLabel: UILabel!
    
    @IBOutlet weak var threeConstraint: NSLayoutConstraint!
    @IBOutlet weak var twoConstraint: NSLayoutConstraint!
    @IBOutlet weak var oneConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var cycleScrollView: SDCycleScrollView!
    @IBOutlet weak var startBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        //小组按钮
        teamView.userInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.teamViewClick))
        teamView.addGestureRecognizer(tap)
        //label数据
        let totalNum = DataBaseManager.shareManager().getData(.answer).count
        totalNumLabel.text = String(totalNum)
        finishedLabel.text = String(finishedNum)
        unfinishedLabel.text = String(totalNum - finishedNum)
        //计算四个按钮等距
        let constraint = (self.view.frame.width - 40 - 20 - 4 * 64 ) / 3
        threeConstraint.constant = constraint
        twoConstraint.constant = constraint
        oneConstraint.constant = constraint
        //背景颜色
        self.view.backgroundColor = bgGrayColor
        //设置按钮
        self.startBtn.clipsToBounds = true
        self.startBtn.layer.cornerRadius = 40
        //设置轮播
        let scrollImageData = ["scroll1","scroll2","scroll3"]
        cycleScrollView.imageURLStringsGroup = scrollImageData
        // Do any additional setup after loading the view.
    }

    @IBAction func oneBtnClick(sender: AnyObject) {
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("DetailVc") as! BookTipsDetailViewController
        vc.type = 3
        self.navigationController?.pushViewController(vc, animated: true)
    }
 
    @IBAction func twoBtnClick(sender: AnyObject) {
        let vc = RxWebViewController(url: NSURL(string: "http://jiaxiao.jxedt.com/"))
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func threeBtnClick(sender: AnyObject) {
        let vc = RxWebViewController(url: NSURL(string: "http://zhinan.jxedt.com/index_33_1.htm"))
        self.navigationController?.pushViewController(vc, animated: true)

    }

    @IBAction func fourBtnClick(sender: AnyObject) {
        let vc = RxWebViewController(url: NSURL(string: "http://info.jxedt.com/"))
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    
    func teamViewClick()
    {
    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("teamVc") as! TeamViewController
        self.navigationController?.pushViewController(vc, animated: true)
     
    }
}
