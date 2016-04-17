//
//  ChooseTestTableViewController.swift
//  驾照轻松考
//
//  Created by 卢良潇 on 16/4/17.
//  Copyright © 2016年 卢良潇. All rights reserved.
//

import UIKit
import FMDB

class ChooseTestTableViewController: UITableViewController {

    
    let chooseTestImageData = ["7","8","9","10","11"]
    let chooseTestNameData = ["章节练习","顺序练习","随机练习","专项练习","仿真模拟考试"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

 
        self.tableView.tableFooterView = UIView()
        self.tableView.rowHeight = 100
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

 

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ChooseTestCell", forIndexPath: indexPath)

        cell.imageView?.image = UIImage(named: chooseTestImageData[indexPath.row])
        cell.textLabel?.text = chooseTestNameData[indexPath.row]
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        // Configure the cell...

        return cell
    }
    

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.row {
        case 0:
            //章节练习
            
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewControllerWithIdentifier("ChooseChapterVc")
            self.navigationController?.pushViewController(vc, animated: true)
        case 1:
            print("0")
        case 2:
            print("0")
        case 3:
            print("0")
        case 4:
            print("0")
        case 5:
            print("0")
        default:
            print("见鬼了")
        }
    }
    
    
}
