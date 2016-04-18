//
//  ChooseChapterTableViewController.swift
//  驾照轻松考
//
//  Created by 卢良潇 on 16/4/17.
//  Copyright © 2016年 卢良潇. All rights reserved.
//

import UIKit

class ChooseChapterTableViewController: UITableViewController {

    var chapterData = [SubjectName]()
    override func viewDidLoad() {
        super.viewDidLoad()

        //从数据库获取数据
       chapterData =  DataBaseManager.shareManager().getData(SubjectType.chapter) as! [SubjectName]
       
       tableView.tableFooterView = UIView()
       tableView.rowHeight = 80
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

   

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return chapterData.count
        
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ChooseChatperCell", forIndexPath: indexPath) as! ChooseChapterTableViewCell


        cell.chapterName.text = chapterData[indexPath.row].pname
        cell.chapterName.numberOfLines = 0
        cell.chapterName.lineBreakMode = NSLineBreakMode.ByCharWrapping
        
        let num = ["1","2","3","4","5","6","7"]
        cell.chapterNum.text = num[indexPath.row]
        cell.chapterNum.backgroundColor = UIColor.randomColor()
        cell.chapterNum.clipsToBounds = true
        cell.chapterNum.layer.cornerRadius = 10
       

        
        return cell
    }
    
   
 
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewControllerWithIdentifier("MainTestVc") as! MainTestViewController
        vc.type = 1
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
