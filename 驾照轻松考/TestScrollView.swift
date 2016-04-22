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



class TestScrollView: UIView {

    //初始化模型
    var model = Answer()

    weak var delegate: TestScrollViewDelegate?

    //数据数组
    var dataArray = [AnyObject]()
    var scrollView : UIScrollView?
    //底部视图
    var footview: UIView?
    var footBtn: UIButton?
    
    var leftTableView : UITableView?
    var centerTableView : UITableView?
    var rightTableView : UITableView?
    var tableFooterView : UIView?
    //进度条长度
    var progressWidth: Double = 0.0
    //记录是否选择了答案
    var didSelected:Bool = false
    //上次的偏移量
    var lastOffset:CGFloat = 0
    
    
    //构造方法
    init(frame: CGRect,data: [AnyObject]) {
        super.init(frame: frame)
       
        
        
        
        dataArray = data
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
     
        scrollView = UIScrollView(frame: CGRectMake(0, 64, frame.width, frame.height - 64))
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
     footview!.backgroundColor = bgGrayColor
     let width = frame.width - 100
    footBtn = UIButton(frame: CGRectMake( 50 , 10, width, 40))
     footBtn!.backgroundColor = bgcolor
     footBtn!.setTitle("查看答案", forState: .Normal)
     footBtn!.setTitleColor(UIColor.whiteColor(), forState: .Normal)
     footBtn!.addTarget(self, action: #selector(TestScrollView.footButtonClick), forControlEvents: UIControlEvents.TouchUpInside)
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
         footview?.hidden = true
        didSelected = false
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
        
        
        
        //WARNING 判断题没有做
        
        //如果已经选择 不能再次选择
        if didSelected
        {
         return
        }
        
        //保存正确答案的位置
        var answerIndexpath = 0

        model = getFitModel(tableView)
        if Int(model.mtype!) == 1
        {
        
               switch model.manswer! {
        case "A":
            answerIndexpath = 0
        case "B":
            answerIndexpath = 1
        case "C":
            answerIndexpath = 2
        case "D":
            answerIndexpath = 3
        default:
            print("见鬼了")
        }
            
        }
        else
        {
            answerIndexpath = model.manswer! == "对" ? 0 : 1
        }
        
        let chooseCell = (tableView.cellForRowAtIndexPath(indexPath) as! UIChooseAnswerTableViewCell)
        let rightCell =  tableView.visibleCells[answerIndexpath] as! UIChooseAnswerTableViewCell
        
        //计算做题数
        finishedNum += 1
        finishedNumInExam += 1
        //出现按钮
        self.footview?.hidden = false
        //已选择答案
        didSelected = true
        //显示图片
        chooseCell.answerStatusImage.hidden = false
        rightCell.answerStatusImage.hidden = false
        if answerIndexpath == indexPath.row
        {
         chooseCell.answerStatusImage.image = UIImage(named: "right")
        //正确加一
        rightNum += 1
        rightNumInExam += 1
        footBtn!.setTitle("答对！☞滑动进入下一题", forState: .Selected)
        }
        else
        {
        //错误加一
            wrongNum += 1
            wrongNumInExam += 1
         chooseCell.answerStatusImage.image = UIImage(named: "wrong")
         rightCell.answerStatusImage.image = UIImage(named: "right")
         footBtn!.setTitle("错了哦~ ☞滑动进入下一题", forState: .Selected)
        }

        

    }
    
    // MARK: tableView delegate
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    

    
    //设置题目
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
        
        let view = UIView(frame: CGRectMake(0, 0, self.frame.width - 8 , 100))
        
        //进度条
        let progressLabel = UILabel(frame: CGRectMake(8, 8, self.frame.width - 16 , 20))
        progressLabel.backgroundColor = UIColor.whiteColor()
        let progress = dataArray.count - currentPage
        progressLabel.text = "\(progress)"
        progressLabel.font = UIFont.systemFontOfSize(11)
        progressLabel.textAlignment = NSTextAlignment.Center
        //暂时设定为0.194
        let backView = UIView(frame: CGRectMake(0, 0, CGFloat(progressWidth) , 20))
        progressWidth += 0.194
        backView.backgroundColor = bgcolor
        let pageLabel = UILabel(frame: CGRectMake(2, 0, 20 , 20))
        pageLabel.hidden = true
        pageLabel.textColor = UIColor.whiteColor()
        pageLabel.font = UIFont.systemFontOfSize(11)
        pageLabel.text = "\(currentPage + 1)"
        if currentPage >= 14
        {
            pageLabel.hidden = false
        }
        progressLabel.addSubview(pageLabel)
        progressLabel.insertSubview(backView, atIndex: 0)



        
        
        //题目
        let label = UILabel(frame: CGRectMake(10, 30, self.frame.width - 8 , 80))
        label.text = String(getQuestionNum(tableView, currentPage: currentPage)) + "."  + str
        label.font = UIFont(name: "AmericanTypewriter-Bold", size: 18)
   
        label.numberOfLines = 0
        label.lineBreakMode = .ByCharWrapping
        view.addSubview(progressLabel)
        view.addSubview(label)
        return view
    }
    //设置答案
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        //选中按钮才出现
        if !footBtn!.selected
        {
         return nil
        }
       
        model = getFitModel(tableView)
       tableFooterView = UIView(frame: CGRectMake(0, 100, self.frame.width - 10 , 200))
        let footLabel = UILabel(frame: CGRectMake(10, 20, self.frame.width - 10 , 20))
        footLabel.text = "答案解析"
        footLabel.textColor = UIColor.blackColor()
        footLabel.font = UIFont(name: "AmericanTypewriter-Bold", size: 18)
        let label = UILabel(frame: CGRectMake(10, 60, self.frame.width - 10 , 160))
        label.textColor = bgcolor
        label.backgroundColor = UIColor.whiteColor()
        label.text = "\n" + model.mdesc!
        label.font = UIFont(name: "AmericanTypewriter-Bold", size: 18)
        label.numberOfLines = 0
        label.lineBreakMode = .ByCharWrapping
        tableFooterView!.addSubview(footLabel)
        tableFooterView!.addSubview(label)
        return tableFooterView

    }
    
    // MARK: TestScrollViewDelegate
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset
        let page = Int((currentOffset.x) / self.frame.width)

        if currentOffset.x > lastOffset
        {
       
      
        if page < dataArray.count - 1 && page > 0
        {
              delegate?.scrollViewDidEndDecelerating(page + 1)
            scrollView.contentSize = CGSizeMake(currentOffset.x + self.frame.width * 2, 0)
            
            leftTableView?.frame = CGRectMake(currentOffset.x - self.frame.width , 0, self.frame.width, self.frame.height)
            centerTableView?.frame = CGRectMake(currentOffset.x , 0, self.frame.width, self.frame.height)
            rightTableView?.frame = CGRectMake(currentOffset.x + self.frame.width, 0, self.frame.width, self.frame.height)
            
            //处理多加了一次page的错误
            if page != 1
            {
                currentPage += 1
            }
      
            //
            reloadData()
            
        }

        }
        
        
        
        else
        {

        }
    
        //保存偏移量
        lastOffset = currentOffset.x
        

        
    }
    
    //拖动隐藏答案 重刷数据
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
  
             resetStatus()
             reloadData()
    }
    
    //让scrollview不能上下滚动
    func scrollViewDidScroll(scrollView: UIScrollView) {
        var offSet = scrollView.contentOffset
        offSet.y = 0
        scrollView.contentOffset = offSet
        
        
    }
    
}
