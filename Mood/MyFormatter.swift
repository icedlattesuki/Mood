//
//  MyFormatter.swift
//  Mood
//
//  Created by Hys on 2017/7/28.
//  Copyright © 2017年 Hys. All rights reserved.
//

import UIKit
import Charts

class MyFormatter: NSObject, IValueFormatter {
    var formatter: NumberFormatter
    
    init(formatter: NumberFormatter) {
        self.formatter = formatter
    }
    
    func stringForValue(_ value: Double,
                        entry: ChartDataEntry,
                        dataSetIndex: Int,
                        viewPortHandler: ViewPortHandler?) -> String {
        return formatter.string(for: value/100)!
    }
}
