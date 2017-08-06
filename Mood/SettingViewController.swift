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
    
    //MARK: Override Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let x = CGFloat(0.7)
        let y = CGFloat(0.7)
        
        //更改Switch大小
        showLatestDataSwitch.transform = CGAffineTransform(scaleX: x, y: y)
        timeSortSwitch.transform = CGAffineTransform(scaleX: x, y: y)
        showAllDataSwitch.transform = CGAffineTransform(scaleX: x, y: y)
        
        showLatestDataSwitch.addTarget(self, action: .switchChanged, for: .valueChanged)
        timeSortSwitch.addTarget(self, action: .switchChanged, for: .valueChanged)
        showAllDataSwitch.addTarget(self, action: .switchChanged, for: .valueChanged)
        
        //根据设置更改Switch的状态
        if let setting = Setting.getSetting() {
            showLatestDataSwitch.setOn(setting.0, animated: true)
            timeSortSwitch.setOn(setting.1, animated: true)
            showAllDataSwitch.setOn(setting.2, animated: true)
        }
    }
    
    //MARK: Methods
    
    func switchChanged() {
        let setting = Setting(showLatestData: showLatestDataSwitch.isOn, timeSort: timeSortSwitch.isOn, showAllData: showAllDataSwitch.isOn)
        
        setting.update()
    }
    
    //MARK: Actions
    
    @IBAction func signOut(_ sender: ButtonExtension) {
        User.signOut()
        
        performSegue(withIdentifier: "signOut", sender: nil)
    }
}

private extension Selector {
    static let switchChanged = #selector(SettingViewController.switchChanged)
}
