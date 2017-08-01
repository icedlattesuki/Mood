//
//  File.swift
//  Mood
//
//  Created by Hys on 2017/7/31.
//  Copyright © 2017年 Hys. All rights reserved.
//

import UIKit
import LeanCloud
import SQLite

class Setting {
    
    //MARK: Properties
    
    var showLatestData: Bool
    var timeSort: Bool
    var showAllData: Bool
    static var db: Connection!
    static let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    static let email = LCUser.current!.email!.stringValue!
    static let emailAttribute = Expression<String>("email")
    static let showLatestDataAttribute = Expression<Bool>("showLatestData")
    static let timeSortAttribute = Expression<Bool>("timeSort")
    static let showAllDataAttribute = Expression<Bool>("showAllData")
    static let setting = Table("Setting")
    static let currentSetting = setting.filter(emailAttribute == email)
    
    //MARK: Initialization
    
    init(showLatestData: Bool, timeSort: Bool, showAllData: Bool) {
        self.showLatestData = showLatestData
        self.timeSort = timeSort
        self.showAllData = showAllData
    }
    
    //MARK: Methods
    
    func update() {
        do {
            try Setting.checkout()

            try Setting.db.run(Setting.currentSetting.update(Setting.showLatestDataAttribute <- showLatestData, Setting.timeSortAttribute <- timeSort, Setting.showAllDataAttribute <- showAllData))
        } catch {
            
        }
    }
    
    //MARK: Static Methods
    
    static func getSetting() -> (Bool,Bool,Bool)? {
        do {
            try checkout()
            
            for record in try db.prepare(currentSetting) {
                return (record[showLatestDataAttribute],record[timeSortAttribute],record[showAllDataAttribute])
            }
        } catch {
            
        }
        return nil
    }
    
    static func checkout() throws {
        do {
            if db == nil {
                db = try Connection("\(documentPath)/db.sqlite3")
            }

            try db.execute("create table if not exists Setting(email text primary key, showLatestData bool, timeSort bool, showAllData bool)")

            if try db.scalar(currentSetting.count) == 0 {
                let insert = setting.insert(emailAttribute <- email, showLatestDataAttribute <- false, timeSortAttribute <- false, showAllDataAttribute <- false)
                
                try db.run(insert)
            }
        } catch {
            throw error
        }
    }
}
