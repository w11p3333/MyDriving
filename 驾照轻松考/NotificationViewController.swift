//
//  NotificationViewController.swift
//  驾照轻松考
//
//  Created by 卢良潇 on 16/4/23.
//  Copyright © 2016年 卢良潇. All rights reserved.
//

import UIKit

class NotificationViewController: UIViewController {

    @IBOutlet weak var userNotificationView: UIView!
    @IBOutlet weak var systemNotificaitonView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.title = "通知"
        userNotificationView.backgroundColor = UIColor(white: 0.95, alpha: 0.95)
        systemNotificaitonView.backgroundColor = UIColor(white: 0.95, alpha: 0.95)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
