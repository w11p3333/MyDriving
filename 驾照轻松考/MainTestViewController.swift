//
//  MainTestViewController.swift
//  驾照轻松考
//
//  Created by 卢良潇 on 16/4/18.
//  Copyright © 2016年 卢良潇. All rights reserved.
//

import UIKit




class MainTestViewController: UIViewController {

    
    var testScrollView : TestScrollView?
    //题目数据
    var questionArray = [AnyObject]()
    //type=1 章节练习 type=2 顺序练习 type=3 随机练习 type=4 专项练习 type=5 模拟考试（全真） type = 6 模拟考试(先考未答) type = 7 我的错题 type =8 我的收藏
    var type:Int = 0
    
    
    var number:Int = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()

        if type == 5
        {
         self.title = "全真考试"
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
//            let array = DataBaseManager.shareManager().getData(.answer)
//            for i in 0...array.count - 1
//            {
//                let model = array[i] as! Answer
//                if Int(model.pid!)! == number + 1
//                {
//                    questionArray.append(model)
//                }
//            }
            print("等等再说")
        case 6:
//            let array = DataBaseManager.shareManager().getData(.answer)
//            for i in 0...array.count - 1
//            {
//                let model = array[i] as! Answer
//                if Int(model.pid!)! == number + 1
//                {
//                    questionArray.append(model)
//                }
//            }
             print("等等再说")
        case 7:
//            let array = DataBaseManager.shareManager().getData(.answer)
//            for i in 0...array.count - 1
//            {
//                let model = array[i] as! Answer
//                if Int(model.pid!)! == number + 1
//                {
//                    questionArray.append(model)
//                }
//            }
             print("等等再说")
        case 8:
//            let array = DataBaseManager.shareManager().getData(.answer)
//            for i in 0...array.count - 1
//            {
//                let model = array[i] as! Answer
//                if Int(model.pid!)! == number + 1
//                {
//                    questionArray.append(model)
//                }
//            }
            print("等等再说")
        default:
            print("等等再说")
        }
       
        testScrollView = TestScrollView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height), data: questionArray)
        
    }

  
    func back()
    {
        self.navigationController?.popViewControllerAnimated(true)

    }

}
