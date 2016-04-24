//
//  BookTipsDetailViewController.swift
//  驾照轻松考
//
//  Created by 卢良潇 on 16/4/22.
//  Copyright © 2016年 卢良潇. All rights reserved.
//

import UIKit

class BookTipsDetailViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    //传入的上个界面选择  0是年审 1是换证 2是遗失  3是报名须知
    var type:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

          setTextView()
        // Do any additional setup after loading the view.
    }

    
    func setTextView()
    {
        //从JSON读取数据
        let path = NSBundle.mainBundle().pathForResource("TipsText.json", ofType: nil)
        let jsonData = NSData(contentsOfFile: path!)
        let dictarr = try! NSJSONSerialization.JSONObjectWithData(jsonData!, options: NSJSONReadingOptions.MutableContainers)
        as! [[String:String]]
        var arr = [String]()
        for i in dictarr {
            
            arr.append(i["type0"]!)
            arr.append(i["type1"]!)
            arr.append(i["type2"]!)
            arr.append(i["type3"]!)
        }
        
        var addtext = ""
        var attrText = NSMutableAttributedString()
        switch type {
        case 0:
             addtext = "驾照年审"
            self.title = addtext
            attrText = NSMutableAttributedString(string: arr[0])
            let range =  (arr[0] as NSString).rangeOfString(addtext + "时间")
            let range2 = (arr[0] as NSString).rangeOfString(addtext + "查询")
            let range3 = (arr[0] as NSString).rangeOfString(addtext + "流程")
            let range4 = (arr[0] as NSString).rangeOfString(addtext + "体检")
            let range5 = (arr[0] as NSString).rangeOfString(addtext + "费用")
            let dict = [range,range2,range3,range4,range5]
            let attrs = [NSForegroundColorAttributeName:bgcolor,NSFontAttributeName:UIFont.boldSystemFontOfSize(20)]
            for i in 0...4
            {
             attrText.addAttributes(attrs, range: dict[i])
            }
        case 1:
  
             addtext = "驾照换证"
            self.title = addtext
             attrText = NSMutableAttributedString(string: arr[1])
            let range =  (arr[1] as NSString).rangeOfString("驾照过期换证")
            let range2 = (arr[1] as NSString).rangeOfString("户籍更换换证")
            let range3 = (arr[1] as NSString).rangeOfString("年龄增长换证")
            let range4 = (arr[1] as NSString).rangeOfString("其它情况换证")
            let dict = [range,range2,range3,range4]
            let attrs = [NSForegroundColorAttributeName:bgcolor,NSFontAttributeName:UIFont.boldSystemFontOfSize(20)]
            for i in 0...3
            {
                attrText.addAttributes(attrs, range: dict[i])
            }

        case 2:
     
            addtext = "驾照遗失"
            self.title = addtext
            attrText = NSMutableAttributedString(string: arr[2])
            let range =  (arr[2] as NSString).rangeOfString("驾照遗失补办")
            let range2 = (arr[2] as NSString).rangeOfString("补办需要的资料")
            let range3 = (arr[2] as NSString).rangeOfString("补办要填写的内容")
            let range4 = (arr[2] as NSString).rangeOfString("补办的方法")
            let dict = [range,range2,range3,range4]
            let attrs = [NSForegroundColorAttributeName:bgcolor,NSFontAttributeName:UIFont.boldSystemFontOfSize(20)]
            for i in 0...3
            {
                attrText.addAttributes(attrs, range: dict[i])
            }
        default:
            addtext = "报名须知"
            self.title = addtext
            attrText = NSMutableAttributedString(string: arr[3])
            let range =  (arr[3] as NSString).rangeOfString("1、费用")
            let range2 = (arr[3] as NSString).rangeOfString("2、时间")
            let range3 = (arr[3] as NSString).rangeOfString("3、接送及班车")
            let range4 = (arr[3] as NSString).rangeOfString("4、教练")
            let range5 = (arr[3] as NSString).rangeOfString("5、投诉")
            let range6 = (arr[3] as NSString).rangeOfString("6、退学与转学")
            let range7 = (arr[3] as NSString).rangeOfString("7、合同与发票")
            let range8 = (arr[3] as NSString).rangeOfString("报名须知")
            let dict = [range,range2,range3,range4,range5,range6,range7,range8]
            let attrs = [NSForegroundColorAttributeName:bgcolor,NSFontAttributeName:UIFont.boldSystemFontOfSize(20)]
            for i in 0...7
            {
                attrText.addAttributes(attrs, range: dict[i])
            }

        }
        
        self.title = addtext
        self.textView.attributedText = attrText
        self.textView.editable = false
        
        
    }
    
   
}
