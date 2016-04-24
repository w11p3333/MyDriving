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

    //关于倒计时
    var countDownLabel:UILabel?
    var countDownTime:Int = 60 * 60
    var timer:NSTimer?
    //主视图
    var testScrollView : TestScrollView?
    //题目数据
    var questionArray = [AnyObject]()
    /// 1: 章节练习 2: 顺序练习 3: 专项练习 4: 模拟考试 5: 我的错题 6: 我的收藏
    var type:Int = 0
    var number:Int = 0
    
  var alert:UIAlertController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        if type == 4
        {
        setupNavigation()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "didFinishedTest:", name: DidFinishedTest, object: nil)
    
        }
        else
        {
        self.title = "练习模式"
        }
        
        loadDataByType()
        //改变按钮
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon_home_up"), style: .Plain, target: self, action: #selector(MainTestViewController.back))
        //加载主界面
        self.view.addSubview(testScrollView!)
        // Do any additional setup after loading the view.
    }
    
    deinit
    {
    NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func setupNavigation()
    {
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(MainTestViewController.countDown), userInfo: nil, repeats: true)
        self.navigationController?.title = "全真考试"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "交卷", style: .Plain, target: self, action: #selector(MainTestViewController.handExam))
       
        countDownLabel = UILabel(frame:  CGRectMake(0, 20, 50, 20))
      
        countDownLabel!.textColor = UIColor.redColor()
        self.navigationItem.titleView = countDownLabel
        testScrollView?.footview?.hidden = true
    
    }

    /**
     根据类型加载数据
     */
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
            let array = DataBaseManager.shareManager().getData(.answer)
            for i in 0...array.count - 1
            {
                let model = array[i] as! Answer
                if Int(model.sid!)! == number + 1
                {
                    questionArray.append(model)
                }
            }
        case 4:
            var examArr = [AnyObject]()
            let arr = DataBaseManager.shareManager().getData(.answer)
            examArr.appendContentsOf(arr)
            for _ in 0...99
            {
             let index = Int(arc4random())%(examArr.count)
             questionArray.append(examArr[index])
             examArr.removeAtIndex(index)
            }

        case 5:
             print("等等再说")
        default:
            print("等等再说")
        }
       
        testScrollView = TestScrollView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height), data: questionArray)
        
    }

    
    // MARK: 时间方法
    /**
     计算倒数计时
     */
    func countDown()
    {
        
        countDownLabel?.text = formatTime(countDownTime)
        countDownTime -= 1
     
    }
    
    //格式化时间
    func formatTime(time:Int) -> String
    {
        let min = time / 60
        let second = time % 60
        let time = String(format: "%02d:%02d", arguments: [min,second])
        return time
    }

    //MARK: 点击方法
  
    func back()
    {
        //保存数据
        NSUserDefaults.standardUserDefaults().setInteger(finishedNum, forKey: "finishedNum")
        NSUserDefaults.standardUserDefaults().setInteger(rightNum, forKey: "rightNum")
        NSUserDefaults.standardUserDefaults().setInteger(wrongNum, forKey: "wrongNum")
        NSUserDefaults.standardUserDefaults().setInteger(currentPage, forKey: "currentPage")
        print("保存数据成功")
        
        
        if type == 4
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
        {
            alert = UIAlertController(title: "已作答完毕！你确定要交卷吗", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        }
        else
        {
            
            alert = UIAlertController(title: "还有\(100 - finishedNumInExam)题未完成,你确定要交卷吗", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
         
        }
        
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil)
        let okAction = UIAlertAction(title: "确定", style: UIAlertActionStyle.Default) { (action) in
            //交卷
            
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ExamScoreVc") as! ExamScoreViewController
            vc.score = rightNumInExam
            self.navigationController?.pushViewController(vc, animated: true)
          
        }
        
            alert.addAction(cancelAction)
            alert.addAction(okAction)
            self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    
    func didFinishedTest(notification:NSNotification)
    {
     handExam()
    
    }


}
