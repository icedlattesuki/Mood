//
//  ThirdViewController.swift
//  Mood
//
//  Created by Hys on 2017/7/27.
//  Copyright © 2017年 Hys. All rights reserved.
//

import UIKit
import Charts

class ThirdViewController: UIViewController {
    
    //MARK: Properties
    
    @IBOutlet weak var totalScoreLabel: UILabel!
    @IBOutlet weak var lineChartView: LineChartView!
    var records = [Record]()
    
    //MARK: override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        records = Record.getAllRecords()
        
        showScore()
        setupchart()
    }
    
    //MARK: Methods
    
    func showScore() {
        var totalScore = 0
        
        for record in records {
            totalScore += record.moodScore
        }
        
        totalScoreLabel.text = String(totalScore)
    }
    
    func setupchart() {
        var dataEntries = [ChartDataEntry]()
        var dates = [String]()
        
        let num = records.count > 7 ? 7 : records.count
        for index in 0..<num {
            let record = records[records.count - num + index]
            let dataEntry = ChartDataEntry(x: Double(index), y: Double(record.moodScore))
            
            dataEntries.append(dataEntry)
            
            let formatter = DateFormatter()
            
            formatter.dateFormat = "MM-dd"
            dates.append(formatter.string(from: record.createdAt!))
        }
        
        let dataSet = LineChartDataSet(values: dataEntries, label: nil)
        
        //不显示圆圈
        dataSet.drawCirclesEnabled = false
        //不显示值
        dataSet.drawValuesEnabled = false
        //曲线设置为贝塞尔曲线
        dataSet.mode = .cubicBezier
        //允许填充色
        dataSet.drawFilledEnabled = true
        
        let color1 = UIColor(red: 52/255, green: 152/255, blue: 219/255, alpha: 0.2)
        let color2 = UIColor(red: 52/255, green: 152/255, blue: 219/255, alpha: 0.8)
        
        //设置填充色
        dataSet.fillColor = (color1)
        //设置线条颜色
        dataSet.setColor(color2)
        
        let data = LineChartData(dataSet: dataSet)
        
        lineChartView.data = data
        
        //不可拖动
        lineChartView.dragEnabled = false
        //不可按X轴缩放
        lineChartView.scaleXEnabled = false
        //不可按Y轴缩放
        lineChartView.scaleYEnabled = false
        //没有description
        lineChartView.chartDescription = nil
        //设置padding使得X轴的数据能显示完全
        lineChartView.minOffset = 30
        //不显示图例
        lineChartView.legend.enabled = false
        //更改X轴的显示数据为对应的日期
        lineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: dates)
        //X轴在下方
        lineChartView.xAxis.labelPosition = .bottom
        //X轴的网格不显示
        lineChartView.xAxis.drawGridLinesEnabled = false
        //Y轴网格不显示
        lineChartView.leftAxis.drawGridLinesEnabled = false
        //右边的Y轴不显示
        lineChartView.rightAxis.enabled = false
        //左边的Y轴不显示
        lineChartView.leftAxis.enabled = false

    }
}
