//
//  MyChartsViewController.swift
//  驾照轻松考
//
//  Created by 卢良潇 on 16/4/18.
//  Copyright © 2016年 卢良潇. All rights reserved.
//

import UIKit
import Charts


//设置样式
var colors: [UIColor] = [ UIColor(red: 198/255, green: 253/255, blue: 145/255, alpha: 1.0), UIColor(red: 255/255, green: 245/255, blue: 145/255, alpha: 1.0), UIColor(red: 254/255, green: 209/255, blue: 145/255, alpha: 1.0), UIColor(red: 144/255, green: 235/255, blue: 254/255, alpha: 1.0), UIColor(red: 253/255, green: 143/255, blue: 157/255, alpha: 1.0)]

class MyChartsViewController: UIViewController {

  
    //线形图数据
    var lineDataKey = ["Apr 16","Apr 17","Apr 18", "Apr 19"]
    var lineDataValue = [10.0,20.0,50.0,30.0]
    //饼状图数据
    var pieDataKey = ["做错了","做对了"]
    var pieDataValue = [Double(wrongNum),Double(rightNum)]
    //柱状图数据
    var day = ["5","10","15","20","25","30"]
    var daytime = [5.0,10.50,30.0,20.0,10.0,5.0]
    
    @IBOutlet weak var lineChartView: LineChartView!
    
    @IBOutlet weak var pieChartView: PieChartView!
    @IBOutlet weak var barChartView: BarChartView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = bgGrayColor
          //建立图表
            setLineChart(lineDataKey, values: lineDataValue)
            setbarChart(day, values: daytime)
            setpieChart(pieDataKey, values: pieDataValue)
        // Do any additional setup after loading the view.
    }
    
    //设置线形图
    func setLineChart(dataPoints: [String], values: [Double])
    {
  
    
        var dataEtries: [ChartDataEntry] = []
        for i in 0..<dataPoints.count
        {
         let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
         dataEtries.append(dataEntry)
        }
      
          let i = LineChartDataSet(yVals: dataEtries, label: "进步指数")
        i.valueColors = [bgcolor]
        i.circleColors = colors
        i.highlightColor = bgcolor
        i.valueTextColor = bgcolor
        let lineChartData = LineChartData(xVals: dataPoints, dataSet: i)
        
        lineChartView.data = lineChartData
        lineChartView.descriptionTextColor = UIColor.lightGrayColor()
        lineChartView.descriptionText  = "学习曲线"
        lineChartView.tintColor = bgGrayColor
     
    }
    

    //设置柱形图
    func setbarChart(dataPoints: [String], values: [Double]) {
        //设置数据
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(yVals: dataEntries, label: "单位/做题量")
        let chartData = BarChartData(xVals: dataPoints, dataSet: chartDataSet)
        chartDataSet.setColor(UIColor.lightGrayColor())
        chartDataSet.barShadowColor = UIColor.whiteColor()
       

        chartDataSet.colors = colors
        chartDataSet.valueColors = [bgcolor]
        
        
        barChartView.data = chartData
        barChartView.descriptionText = "学习曲线"
        barChartView.noDataText = "You need to provide data for the chart."
        barChartView.descriptionTextColor = bgGrayColor
        barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .EaseInBounce)
        
        
        
    }
    
    
    
    //设置饼状图
    func setpieChart(dataPoints: [String], values: [Double]) {
        
        
        //设置数据
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let pieChartDataSet = PieChartDataSet(yVals: dataEntries, label: "单位/题数")
        let pieChartData = PieChartData(xVals: dataPoints, dataSet: pieChartDataSet)
        pieChartView.data = pieChartData
     //   let attribute: NSDictionary = NSDictionary(object: bgcolor, forKey: NSForegroundColorAttributeName)
        let attribute: NSDictionary = [NSForegroundColorAttributeName:bgcolor]
        //正确率
        let precent =  String(format: "%.1f",(Double(rightNum) / Double(rightNum + wrongNum)) * 100)

        
        pieChartView.centerAttributedText = NSAttributedString(string: "正确率\(precent)%", attributes: attribute as? [String : AnyObject])
        
        //设置样式
        pieChartView.descriptionText = "正确率"
        pieChartView.descriptionTextColor = bgGrayColor
        pieChartDataSet.colors = [UIColor(red: 253/255, green: 143/255, blue: 157/255, alpha: 1.0), UIColor(red: 198/255, green: 253/255, blue: 145/255, alpha: 1.0), ]
    
    }
    


}
