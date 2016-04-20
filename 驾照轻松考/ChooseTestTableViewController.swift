//
//  ChooseTestTableViewController.swift
//  驾照轻松考
//
//  Created by 卢良潇 on 16/4/17.
//  Copyright © 2016年 卢良潇. All rights reserved.
//

import UIKit
import FMDB


//选择考试类型
class ChooseTestTableViewController: UITableViewController {

    
    let chooseTestImageData = ["7","10","8","11"]
    let chooseTestNameData = ["章节练习","专项练习","顺序练习","仿真模拟考试"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

 
        self.tableView.tableFooterView = UIView()
        self.tableView.rowHeight = 100
    }
    // MARK: - Table view data source

 

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
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
            let vc = sb.instantiateViewControllerWithIdentifier("ChooseChapterVc") as! ChooseChapterTableViewController
            vc.chapterType = 1
            self.navigationController?.pushViewController(vc, animated: true)
        //专项
        case 1:
            
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewControllerWithIdentifier("ChooseChapterVc") as! ChooseChapterTableViewController
            vc.chapterType = 2
            self.navigationController?.pushViewController(vc, animated: true)
           
        //顺序
        case 2:
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewControllerWithIdentifier("MainTestVc") as! MainTestViewController
            vc.type = 2
            self.navigationController?.pushViewController(vc, animated: true)


        //考试
        case 3:
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewControllerWithIdentifier("MainTestVc") as! MainTestViewController
            vc.type = 5
            self.navigationController?.pushViewController(vc, animated: true)

     
        default:
            print("见鬼了")
        }
    }
    
    
    func addAlert()
    {
        
        if currentPage != 0
        {
            
            let alert = UIAlertController(title: "上次已做到第\(currentPage + 1)题,要继续开始吗？", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
            
            
            let cancelAction = UIAlertAction(title: "从头开始", style: UIAlertActionStyle.Default) { (action) in
                
                //将page清空
                currentPage = 0
                
              
                
                
            }
            
            
            let okAction = UIAlertAction(title: "继续", style: UIAlertActionStyle.Default) { (action) in
                
                
                //currentPage从0开始的 所以加1
                currentPage += 1
           
                
            }
            
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            self.presentViewController(alert, animated: true, completion: nil)
        }
            
 
    }
    
}
