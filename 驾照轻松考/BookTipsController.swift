//
//  SubjectThreeViewController.swift
//  驾照轻松考
//
//  Created by 卢良潇 on 16/4/18.
//  Copyright © 2016年 卢良潇. All rights reserved.
//

import UIKit

class BookTipsController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    //数据
    var borderColors = [ UIColor(red: 253/255, green: 143/255, blue: 157/255, alpha: 1.0),UIColor(red: 135/255, green: 206/255, blue: 235/255, alpha: 1.0),UIColor(red: 124/255, green: 205/255, blue: 124/255, alpha: 1.0)]
    var textData = ["驾照年审","驾照换证","驾照遗失"]
    var imageData = ["icon_applet_collins","icon_applet_roots","icon_applet_affixes"]
    var descData = ["年审太麻烦？不知道流程？我们帮你总结","过期、户籍更换、年龄增长,换证轻松办","驾照丢了怎么办？莫慌抱紧我"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = bgGrayColor
        tableView.rowHeight = 180
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        // Do any additional setup after loading the view.
    }

  
}
extension BookTipsController :UITableViewDelegate, UITableViewDataSource
{
 
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
 
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TipsCell", forIndexPath: indexPath) as! BookTipsTableViewCell
        //文字
        cell.titleLabel.text = textData[indexPath.row]
        cell.titleLabel.textColor = borderColors[indexPath.row]
        cell.descLabel.text = descData[indexPath.row]
        //图片
        cell.imageBgView.backgroundColor = borderColors[indexPath.row]
        cell.imageBgView.layer.cornerRadius = 30
        cell.imageBgView.clipsToBounds = true
        cell.image_view.image = UIImage(named: (imageData[indexPath.row]))
        cell.image_view.clipsToBounds = true
        cell.image_view.layer.cornerRadius = 25
        //边框颜色
        cell.BgView.layer.cornerRadius = 8
        cell.BgView.layer.borderWidth = 2
        cell.BgView.layer.borderColor = borderColors[indexPath.row].CGColor
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("DetailVc") as! BookTipsDetailViewController
        vc.type = indexPath.row 
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
