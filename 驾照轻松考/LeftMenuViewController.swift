//
//  LeftMenuViewController.swift
//  驾照轻松考
//
//  Created by 卢良潇 on 16/4/17.
//  Copyright © 2016年 卢良潇. All rights reserved.
//

import UIKit

class LeftMenuViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    
     let sectionOneData = ["徽章","打卡"]
     let sectionTwoData = ["意见反馈","关于","给我们评价"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableview.delegate = self
        tableview.dataSource = self
        let view = UIView()
        view.backgroundColor = bgGrayColor
        tableview.tableFooterView = view
        tableview.separatorStyle = UITableViewCellSeparatorStyle.None
        // Do any additional setup after loading the view.
    }

    

 }

extension LeftMenuViewController: UITableViewDelegate, UITableViewDataSource

{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 2 : 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       
        let cell = UITableViewCell()
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        cell.textLabel?.text = indexPath.section == 0 ? sectionOneData[indexPath.row] : sectionTwoData[indexPath.row]
        return cell
    }
    
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRectMake(0, 0, self.view.frame.width, 150))
        view.backgroundColor = bgGrayColor
        let imageview = UIImageView(frame: CGRectMake(70, 45, 60, 60))
        imageview.image = UIImage(named: "settings_icon_account")
        imageview.layer.cornerRadius = 30
        let label = UILabel(frame: CGRectMake(50, 110, 100, 20))
        label.font = UIFont.systemFontOfSize(13)
        label.text = "用户名"
        label.textAlignment = NSTextAlignment.Center
        view.addSubview(label)
        view.addSubview(imageview)
        return  section == 0 ? view : nil
        
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ?  150 : 20
    }
}