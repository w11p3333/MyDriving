//
//  TestScrollView.swift
//  驾照轻松考
//
//  Created by 卢良潇 on 16/4/18.
//  Copyright © 2016年 卢良潇. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol TestScrollViewDelegate:NSObjectProtocol {
    func scrollViewDidEndDecelerating(index:Int)
    func answerQuestion(array:[AnyObject])
}

struct AnswerType {
    
    static let A:String = "A"
    static let B:String = "B"
    static let C:String = "C"
    static let D:String = "D"
    static let True:String = "T"
    static let False:String = "F"
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
    var footview: UIView?
    var footBtn: UIButton?
    
    var leftTableView : UITableView?
    var centerTableView : UITableView?
    var rightTableView : UITableView?
    var tableFooterView : UIView?
    
    //初始化答案类型
    var answerType = AnswerType.A
    //记录是否选择
    var didSelected:Bool = false

    
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
        creatFootViewWithFrame(frame)
        createView()
        resetStatus()
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
    
    func creatFootViewWithFrame(frame:CGRect)
    {
     footview = UIView(frame: CGRectMake(0, frame.height - 60, frame.width, 60))
     footview!.backgroundColor = UIColor(white: 0.99, alpha: 0.95)
     let width = frame.width - 100
    footBtn = UIButton(frame: CGRectMake( 50 , 10, width, 40))
     footBtn!.backgroundColor = bgcolor
     footBtn!.setTitle("查看答案", forState: .Normal)
     footBtn!.setTitle("下一个", forState: .Selected)
     footBtn!.setTitleColor(UIColor.whiteColor(), forState: .Normal)
     footBtn!.addTarget(self, action: "footButtonClick", forControlEvents: UIControlEvents.TouchUpInside)
     footview?.addSubview(footBtn!)
    }
    
    func createView()
    {
        
    scrollView!.addSubview(leftTableView!)
    scrollView!.addSubview(centerTableView!)
    scrollView!.addSubview(rightTableView!)
    
    self.addSubview(scrollView!)
    self.addSubview(footview!)
        
    self.footview?.hidden = true
    footBtn?.selected = false
    
    
    }
    

    // MARK: 获取方法
    /**
     获取当前模型类型
     */
    
    func getFitModel(tableview:UITableView) -> Answer
    {
     
        
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
        else if tableview == centerTableView && currentPage > 0 && currentPage < dataArray.count - 1
        {
            return currentPage + 1
        }
        else if tableview == centerTableView && currentPage == 0
        {
            return 2
        }
        else if tableview == centerTableView && currentPage == dataArray.count - 1
        {
            return currentPage
        }
        else if tableview == rightTableView && currentPage < dataArray.count - 1
        {
            return currentPage + 2
        }
        else if tableview == rightTableView && currentPage == dataArray.count - 1
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
    
    func resetStatus()
    {
        //设置状态
        didSelected = false
        footview?.hidden = true
        tableFooterView?.hidden = true
        footBtn?.selected = false
    }
   
    
    //按钮点击
    func footButtonClick()
    {
     if footBtn!.selected
     {
      //下一个
      footBtn?.selected = false
        
     }
    else
     {
        //出现答案
     footBtn!.selected = true
     reloadData()
        }
    
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
        //获取数据
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

        
  
        
        return cell
        
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
       
        //如果已经选择 不能再次选择
        if didSelected
        {
         didSelected = true
         return
        }
        
        //出现按钮
        self.footview?.hidden = false
        
        
        
        model = getFitModel(tableView)

       //获取用户的选择
       
        if  Int(model.mtype!)! == 1
        {
        switch indexPath.row {
        case 0:
             answerType = AnswerType.A
        case 1:
             answerType = AnswerType.B
        case 2:
            answerType = AnswerType.C
        case 3:
            answerType = AnswerType.D
        default:
            print("见鬼了")
        }
        }
        else if Int(model.mtype!)! == 2
        {
            switch indexPath.row {
            case 0:
                 answerType = AnswerType.True
            case 1:
                 answerType = AnswerType.False
            default:
                print("见鬼了")
        }
        }
        //判断答案是否正确
        let cell = tableView.dequeueReusableCellWithIdentifier("AnswerCell", forIndexPath: indexPath) as! UIChooseAnswerTableViewCell
        if answerType == model.manswer!
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
        
        didSelected = true
    }
    
    // MARK: tableView delegate
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 80
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       
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
     //   print(String(getQuestionNum(tableView, currentPage: currentPage)))
        label.text = String(getQuestionNum(tableView, currentPage: currentPage)) + "."  + str
        label.font = UIFont.systemFontOfSize(16)
        label.numberOfLines = 0
        label.lineBreakMode = .ByCharWrapping
        view.addSubview(label)
        return view
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        //选中按钮才出现
        if !footBtn!.selected
        {
         return nil
        }
        
        model = getFitModel(tableView)
       tableFooterView = UIView(frame: CGRectMake(0, 60, self.frame.width - 10 , 80))
        let label = UILabel(frame: CGRectMake(10, 60, self.frame.width - 10 , 60))
        label.textColor = UIColor.redColor()
        label.text = "答案解析:\n" + model.mdesc!
        label.font = UIFont.systemFontOfSize(16)
        label.numberOfLines = 0
        label.lineBreakMode = .ByCharWrapping
        tableFooterView!.addSubview(label)
        return tableFooterView

    }
    
    // MARK: TestScrollViewDelegate
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        let currentOffset = scrollView.contentOffset
     
      
        
        if !didSelected
        {
            SVProgressHUD.showErrorWithStatus("你没有回答上一题哦")
        }

        
        
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
    
    
    
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
             resetStatus()
    }
    
    
}
