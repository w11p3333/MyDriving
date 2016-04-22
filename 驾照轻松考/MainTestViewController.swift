//
//  MainTestViewController.swift
//  驾照轻松考
//
//  Created by 卢良潇 on 16/4/18.
//  Copyright © 2016年 卢良潇. All rights reserved.
//

import UIKit


var finishedNumInExam:Int = 0
var wrongNumInExam:Int = 0
var rightNumInExam:Int = 0

class MainTestViewController: UIViewController {

    
    var testScrollView : TestScrollView?
    //题目数据
    var questionArray = [AnyObject]()
    //type=1 章节练习 type=2 顺序练习 type=3 随机练习 type=4 专项练习 type=5 模拟考试（全真） type = 6 模拟考试(先考未答) type = 7 我的错题 type =8 我的收藏
    var type:Int = 0
    
    
    var number:Int = 0
    
  var alert:UIAlertController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if type == 5
        {
        setupNavigation()
        }
        else
        {
        self.title = "练习模式"
        }
        
        loadDataByType()

        //改变按钮
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon_home_up"), style: .Plain, target: self, action: #selector(MainTestViewController.back))

       

        self.view.addSubview(testScrollView!)
        // Do any additional setup after loading the view.
    }
    
    func setupNavigation()
    {
    
        self.navigationController?.title = "全真考试"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "交卷", style: .Plain, target: self, action: "handExam")
       
        let label = UILabel(frame:  CGRectMake(0, 10, 80, 30))
        label.text = "60:00"
        label.textColor = UIColor.redColor()
        self.navigationItem.titleView = label
        testScrollView?.footview?.hidden = true
    
    }

    
    func loadDataByType()
    {
        switch type {
        case 1:
            let array = DataBaseManager.shareManager().getData(.answer)
           
            for i in 0...array.count - 1
            {
            let model = array[i] as! Answer
            if Int(model.pid!)! == number + 1
            {
                questionArray.append(model)
              
                }
            }
        case 2:
            questionArray = DataBaseManager.shareManager().getData(.answer)
            
        case 3:
            questionArray = DataBaseManager.shareManager().getData(.answer)

        case 4:
            let array = DataBaseManager.shareManager().getData(.answer)
            for i in 0...array.count - 1
            {
                let model = array[i] as! Answer
                if Int(model.sid!)! == number + 1
                {
                    questionArray.append(model)
                }
            }
        case 5:

            var examArr = [AnyObject]()
            let arr = DataBaseManager.shareManager().getData(.answer)
            examArr.appendContentsOf(arr)
            for _ in 0...99
            {
             let index = Int(arc4random())%(examArr.count)
             questionArray.append(examArr[index])
             examArr.removeAtIndex(index)
            }

            print("等等再说")
        case 6:

             print("等等再说")
        case 7:

             print("等等再说")
        case 8:

            print("等等再说")
        default:
            print("等等再说")
        }
       
        testScrollView = TestScrollView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height), data: questionArray)
        
    }

  
    func back()
    {
        //保存数据
        NSUserDefaults.standardUserDefaults().setInteger(finishedNum, forKey: "finishedNum")
        NSUserDefaults.standardUserDefaults().setInteger(rightNum, forKey: "rightNum")
        NSUserDefaults.standardUserDefaults().setInteger(wrongNum, forKey: "wrongNum")
        NSUserDefaults.standardUserDefaults().setInteger(currentPage, forKey: "currentPage")
        print("保存数据成功")
        
        
        if type == 5
        {
            alert = UIAlertController(title: "还在考试中,你确定要退出吗？", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
            let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil)
            let okAction = UIAlertAction(title: "确定", style: UIAlertActionStyle.Default) { (action) in
                
                self.dismissViewControllerAnimated(true, completion: nil)
                }
        
            alert.addAction(cancelAction)
            alert.addAction(okAction)
             self.presentViewController(alert, animated: true, completion: nil)
        }
        
        else
        {
        self.navigationController?.popViewControllerAnimated(true)
        }
    }
    //交卷
    func handExam()
    {
      
        if finishedNumInExam == 100
        { alert = UIAlertController(title: "已作答完毕！你确定要交卷吗", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        }
        else
        {
            
            alert = UIAlertController(title: "还有\(100 - finishedNumInExam)题未完成,你确定要交卷吗", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
         
        }
        
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil)
        let okAction = UIAlertAction(title: "确定", style: UIAlertActionStyle.Default) { (action) in
            //交卷
//            wrongNumInExam
//            rightNumInExam
            print(wrongNumInExam)
            print(rightNumInExam)
        }
        
            alert.addAction(cancelAction)
            alert.addAction(okAction)
            self.presentViewController(alert, animated: true, completion: nil)
        
 
    
        
    }

}
