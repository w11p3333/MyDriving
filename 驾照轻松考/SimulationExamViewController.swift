//
//  SimulationExamViewController.swift
//  驾照轻松考
//
//  Created by 卢良潇 on 16/4/22.
//  Copyright © 2016年 卢良潇. All rights reserved.
//

import UIKit

class SimulationExamViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var startBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = bgcolor
    //    startBtn.clipsToBounds = true
        startBtn.layer.cornerRadius = 100
        // Do any additional setup after loading the view.
    }



    @IBAction func startClick(sender: AnyObject) {


        startBtn.layer.shadowColor = UIColor.blackColor().CGColor
        startBtn.layer.shadowOffset = CGSizeMake(1, 1)
        startBtn.layer.shadowOpacity = 0.8
        startBtn.layer.shadowRadius = 10
        startBtn.clipsToBounds = false

       UIView.animateWithDuration(0.3, delay: 0.5, options: UIViewAnimationOptions.TransitionNone, animations: {

        
            self.startBtn.layer.setAffineTransform(CGAffineTransformMakeRotation(CGFloat(M_PI)))
        }) { (true) in
          
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewControllerWithIdentifier("MainTestVc") as! MainTestViewController
            vc.type = 5
            let nav = UINavigationController(rootViewController: vc)
         //   self.presentViewController(vc, animated: true, completion: nil)
            self.navigationController?.presentViewController(nav, animated: true, completion: nil)
        
   
        }
        
//            let sb = UIStoryboard(name: "Main", bundle: nil)
//            let vc = sb.instantiateViewControllerWithIdentifier("MainTestVc") as! MainTestViewController
//            vc.type = 5

        
    }
    



}
