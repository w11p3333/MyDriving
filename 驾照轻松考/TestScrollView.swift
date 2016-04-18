//
//  TestScrollView.swift
//  驾照轻松考
//
//  Created by 卢良潇 on 16/4/18.
//  Copyright © 2016年 卢良潇. All rights reserved.
//

import UIKit

protocol TestScrollViewDelegate:NSObjectProtocol {
    func scrollViewDidEndDecelerating(index:Int)
    func answerQuestion(array:[AnyObject])
}

class TestScrollView: UIView {

    
    var model = Answer()

    weak var delegate: TestScrollViewDelegate?
    //当前页
    var currentPage:Int = 0
    //数据数组
    var dataArray = [AnyObject]()
    var hadAnswerArray = [AnyObject]()
    var scrollView : UIScrollView?
    
    var leftTableView : UITableView?
    var centerTableView : UITableView?
    var rightTableView : UITableView?
    
    
    init(frame: CGRect,data: [AnyObject]) {
        super.init(frame: frame)
        currentPage = 0
        dataArray = data
        for _ in 0...data.count
        {
         hadAnswerArray.append("0")
        }
        creatScrollViewWithFrame(frame)
        creatTableViewWithFrame(frame)
        createView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: 创建方法
    
    func creatScrollViewWithFrame(frame:CGRect)
    {
        
        scrollView = UIScrollView(frame: frame)
        scrollView?.delegate = self
        scrollView?.showsHorizontalScrollIndicator = false
        scrollView?.showsVerticalScrollIndicator = false
        scrollView?.bounces = false
        scrollView?.pagingEnabled = true
        if dataArray.count > 1
        {
         scrollView?.contentSize = CGSizeMake(self.frame.width * 2, 0)
        }
        
        
    }
    
    func creatTableViewWithFrame(frame:CGRect)
    {


        leftTableView = UITableView(frame: CGRectMake(0, 0, self.frame.width, self.frame.height), style: .Grouped)
        centerTableView = UITableView(frame: CGRectMake(self.frame.width, 0, self.frame.width, self.frame.height), style: .Grouped)
        rightTableView = UITableView(frame: CGRectMake(self.frame.width * 2, 0, self.frame.width, self.frame.height), style: .Grouped)
        leftTableView?.separatorStyle = .None
        centerTableView?.separatorStyle = .None
        rightTableView?.separatorStyle = .None
        leftTableView?.delegate = self
        centerTableView?.delegate = self
        rightTableView?.delegate = self
        leftTableView?.dataSource = self
        centerTableView?.dataSource = self
        rightTableView?.dataSource = self
        
    }
    
    func createView()
    {
        
    scrollView!.addSubview(leftTableView!)
    scrollView!.addSubview(centerTableView!)
    scrollView!.addSubview(rightTableView!)
    self.addSubview(scrollView!)
   
    
    }
    

    // MARK: 获取方法
    /**
     获取当前模型类型
     */
    
    func getFitModel(tableview:UITableView) -> Answer
    {
     
        var model = Answer()
        if tableview == leftTableView && currentPage == 0
        {
            model = dataArray[currentPage] as! Answer
        }
        else if tableview == leftTableView && currentPage > 0
        {
            model = dataArray[currentPage - 1] as! Answer
        }
        else if tableview == centerTableView && currentPage == 0
        {
            model = dataArray[currentPage + 1] as! Answer
        }
        else if tableview == centerTableView && currentPage > 0 && currentPage < dataArray.count - 1
        {
            model = dataArray[currentPage] as! Answer
        }
        else if tableview == centerTableView && currentPage == dataArray.count - 1
        {
            model = dataArray[currentPage - 1] as! Answer
        }
        else if tableview == rightTableView && currentPage == dataArray.count - 1
        {
            model = dataArray[currentPage] as! Answer
        }
        else if tableview == rightTableView && currentPage < dataArray.count - 1
        {
            model = dataArray[currentPage + 1] as! Answer
        }
        return model
    }
    
    /**
     获取当前题目编号
     */
    
    func getQuestionNum(tableview:UITableView, currentPage:Int) -> Int
    {
     
        if tableview == leftTableView && currentPage == 0
        {
           return 1
        }
        else if tableview == leftTableView && currentPage > 0
        {
            return currentPage
        }
        else if tableview == centerTableView && currentPage == 0
        {
            return currentPage + 1
        }
        else if tableview == centerTableView && currentPage > 0 && currentPage < dataArray.count - 1
        {
            return 2
        }
        else if tableview == centerTableView && currentPage == dataArray.count - 1
        {
            return currentPage
        }
        else if tableview == rightTableView && currentPage == dataArray.count - 1
        {
            return currentPage + 2
        }
        else if tableview == rightTableView && currentPage < dataArray.count - 1
        {
            return currentPage + 1
        }
        return 0
    }

    /**
     重刷所有数据
     */
    func reloadData()
    {
     leftTableView?.reloadData()
     centerTableView?.reloadData()
     rightTableView?.reloadData()
    }
    
   
}


extension TestScrollView:UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource
{
    
    // MARK: tableView dataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        //数据源
        model = getFitModel(tableView)
        //选择题
        if Int(model.mtype!)! == 1
        {
         return 4
        }
        //判断题
        else if Int(model.mtype!)! == 2
        {
         return 2
        }
        return  0

    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        tableView.registerNib(UINib(nibName: "UIChooseAnswerTableViewCell",bundle: nil), forCellReuseIdentifier: "AnswerCell")
        let cell = tableView.dequeueReusableCellWithIdentifier("AnswerCell", forIndexPath: indexPath) as! UIChooseAnswerTableViewCell
        cell.answerStatusImage.hidden = true
        
        model = getFitModel(tableView)
        
        //选择题
        if Int(model.mtype!)! == 1
        {
        cell.title.text = ["A.","B.","C.","D."][indexPath.row]
    
        //indexpath.row需要加1 因为错位了 第一位是题目
        cell.answerLabel.text = AnswerManager.shareManager().formatAnswerToString(model.mquestion!)[indexPath.row + 1] as? String
           
        }
            //判断题
        else if Int(model.mtype!)! == 2
        {
        cell.title.text = ["1.","2."][indexPath.row]
        cell.answerLabel.text = ["对","错"][indexPath.row]
        }
        //判断是否已答题
        let page = getQuestionNum(tableView, currentPage: currentPage)
        
//        if Int(hadAnswerArray[page - 1] as! String) != 0
//        {
//            //选择题
//            if Int(model.mtype!)! == 1
//            {
//             //还没有写
//            }
//            //判断题
//            else if Int(model.mtype!)! == 2
//            {
//             if model.manswer == cell.answerLabel.text
//             {
//                cell.answerStatusImage?.image = nil
//                cell.answerStatusImage.hidden = false
//                cell.answerStatusImage.image = UIImage(named: "right")
//             }
//            else
//             {
//                cell.answerStatusImage?.image = nil
//                cell.answerStatusImage.hidden = false
//                cell.answerStatusImage.image = UIImage(named: "wrong")
//                }
//            }
//         
//        }
//        else
//        {
//        cell.answerStatusImage.hidden = true
//        }
//        
        
        return cell
        
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        model = getFitModel(tableView)

       //获取用户的选择
        var chooseAnswer = ""
        if  Int(model.mtype!)! == 1
        {
        switch indexPath.row {
        case 0:
             chooseAnswer = "A"
        case 1:
             chooseAnswer = "B"
        case 2:
             chooseAnswer = "C"
        case 3:
             chooseAnswer = "D"
        default:
            print("见鬼了")
        }
        }
        else if Int(model.mtype!)! == 2
        {
            switch indexPath.row {
            case 0:
                 chooseAnswer = "1"
            case 1:
                 chooseAnswer = "2"
            default:
                print("见鬼了")
        }
        }
        //判断答案是否正确
        let cell = tableView.dequeueReusableCellWithIdentifier("AnswerCell", forIndexPath: indexPath) as! UIChooseAnswerTableViewCell
        if chooseAnswer == model.manswer!
        {
            cell.answerStatusImage?.image = nil
            cell.answerStatusImage.hidden = false
            cell.answerStatusImage.image = UIImage(named: "right")
        }
        else
        {
            cell.answerStatusImage?.image = nil
            cell.answerStatusImage.hidden = false
            cell.answerStatusImage.image = UIImage(named: "wrong")
        }
            
    }
    
    // MARK: tableView delegate
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 80
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var model = Answer()
        model = getFitModel(tableView)
        
        var str = ""
        if  Int(model.mtype!)! == 1
        {
        str = AnswerManager.shareManager().formatAnswerToString(model.mquestion!)[0] as! String
        
        }
        else
        {
         str = model.mquestion!
        }
        let view = UIView(frame: CGRectMake(0, 0, self.frame.width - 8 , 80))
        let label = UILabel(frame: CGRectMake(10, 10, self.frame.width - 8 , 60))

        label.text = String(getQuestionNum(tableView, currentPage: currentPage)) + "."  + str
        label.font = UIFont.systemFontOfSize(16)
        label.numberOfLines = 0
        label.lineBreakMode = .ByCharWrapping
        view.addSubview(label)
        return view
    }
    
    
    // MARK: TestScrollViewDelegate
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        

        let currentOffset = scrollView.contentOffset
        let page = Int((currentOffset.x) / self.frame.width)
        delegate?.scrollViewDidEndDecelerating(page + 1)
        if page < dataArray.count - 1 && page > 0
        {
         scrollView.contentSize = CGSizeMake(currentOffset.x + self.frame.width * 2, 0)
         leftTableView?.frame = CGRectMake(currentOffset.x - self.frame.width , 0, self.frame.width, self.frame.height)
         centerTableView?.frame = CGRectMake(currentOffset.x , 0, self.frame.width, self.frame.height)
         rightTableView?.frame = CGRectMake(currentOffset.x + self.frame.width, 0, self.frame.width, self.frame.height)
         currentPage = page
         reloadData()
        }

        
    }
    
    
}
