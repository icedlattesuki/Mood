//
//  SideMenuNavigationController.swift
//  Mood
//
//  Created by Hys on 2017/7/30.
//  Copyright © 2017年 Hys. All rights reserved.
//

import UIKit
import Material
import SideMenu

class SideMenuNavigationController: UISideMenuNavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationBar.barTintColor = UIColor(red: ThemeColor.red, green: ThemeColor.green, blue: ThemeColor.blue, alpha: ThemeColor.alpha)
        self.navigationBar.isTranslucent = true
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: Color.white]
        
        SideMenuManager.menuWidth = 280
        SideMenuManager.menuPresentMode = .viewSlideInOut
        SideMenuManager.menuFadeStatusBar = false
    }
}
