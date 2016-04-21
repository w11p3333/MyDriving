//
//  MyChartsViewController.swift
//  驾照轻松考
//
//  Created by 卢良潇 on 16/4/18.
//  Copyright © 2016年 卢良潇. All rights reserved.
//

import UIKit
import Charts

class MyChartsViewController: UIViewController {

    
    //饼状图数据
    var pieDataKey = ["做错了","做对了"]
    var pieDataValue = [Double(wrongNum),Double(rightNum)]
    //柱状图数据
    var day = ["5","10","15","20","25","30"]
    var daytime = [5.0,10.50,30.0,20.0,10.0,5.0]
    
    @IBOutlet weak var pieChartView: PieChartView!
    @IBOutlet weak var barChartView: BarChartView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        //建立图表
        setbarChart(day, values: daytime)
        
        
        setpieChart(pieDataKey, values: pieDataValue)
        // Do any additional setup after loading the view.
    }

    //设置柱形图
    func setbarChart(dataPoints: [String], values: [Double]) {
        //设置数据
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(yVals: dataEntries, label: "单位/分钟")
        let chartData = BarChartData(xVals: dataPoints, dataSet: chartDataSet)
        chartDataSet.barShadowColor = UIColor.whiteColor()
        //设置样式
        var colors: [UIColor] = []
        
        for _ in 0...12 {
            
            colors.append(UIColor.randomColor())
        }
        
        chartDataSet.colors = colors
        chartDataSet.valueColors = [UIColor.whiteColor()]
        
        
        barChartView.data = chartData
        barChartView.descriptionText = "学习曲线"
        barChartView.noDataText = "You need to provide data for the chart."
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
        let attribute: NSDictionary = NSDictionary(object: bgcolor, forKey: NSForegroundColorAttributeName)
        //正确率
        let precent =  String(format: "%.1f",(Double(rightNum) / Double(rightNum + wrongNum)) * 100)

        
        pieChartView.centerAttributedText = NSAttributedString(string: "正确率\(precent)%", attributes: attribute as? [String : AnyObject])
     //   pieChartView.description.text = "请继续努力哦"
        
      
        
        //设置样式
    
        
        pieChartDataSet.colors = [UIColor.redColor(),UIColor.greenColor()]
    
    }
    


}
