//
//  SettingViewController.swift
//  Mood
//
//  Created by Hys on 2017/7/31.
//  Copyright © 2017年 Hys. All rights reserved.
//

import UIKit
import Material

class SettingViewController: UIViewController {
    
    //MARK: Properties

    @IBOutlet weak var showLatestDataSwitch: UISwitch!
    @IBOutlet weak var timeSortSwitch: UISwitch!
    @IBOutlet weak var showAllDataSwitch: UISwitch!
    
    //MARK: Override functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showLatestDataSwitch.transform = CGAffineTransform(scaleX: 0.65, y: 0.65)
        timeSortSwitch.transform = CGAffineTransform(scaleX: 0.65, y: 0.65)
        showAllDataSwitch.transform = CGAffineTransform(scaleX: 0.65, y: 0.65)
        
        showLatestDataSwitch.addTarget(self, action: .switchChanged, for: .valueChanged)
        timeSortSwitch.addTarget(self, action: .switchChanged, for: .valueChanged)
        showAllDataSwitch.addTarget(self, action: .switchChanged, for: .valueChanged)
    }
    
    //MARK: Methods
    
    func switchChanged() {
        let prevSatuc = [showLatestDataSwitch.isOn, timeSortSwitch.isOn, showAllDataSwitch.isOn]
        let setting = Setting(showLatestData: showLatestDataSwitch.isOn, timeSort: timeSortSwitch.isOn, showAllData: showAllDataSwitch.isOn)
        
        if !setting.update() {
            
            showLatestDataSwitch.setOn(prevSatuc[0], animated: true)
            timeSortSwitch.setOn(prevSatuc[1], animated: true)
            showAllDataSwitch.setOn(prevSatuc[2], animated: true)
        }
    }
}

private extension Selector {
    static let switchChanged = #selector(SettingViewController.switchChanged)
}
