//
//  Record.swift
//  Mood
//
//  Created by Hys on 2017/7/24.
//  Copyright © 2017年 Hys. All rights reserved.
//

import UIKit
import LeanCloud

class Record {
    
    //MARK: Properties
    
    var objId: String!
    var moodScore: Int
    var sentence: String
    var createdAt: Date!
    
    //MARK: Initialization
    
    init(moodScore: Int, sentence: String) {
        self.moodScore = moodScore
        self.sentence = sentence
    }
    
    private init(objId: String, moodScore: Int, sentence: String, createdAt: Date) {
        self.objId = objId
        self.moodScore = moodScore
        self.sentence = sentence
        self.createdAt = createdAt
    }
    
    //MARK: Public Methods
    
    //保存记录至远端数据库
    func save() -> Result {
        var result = Result()
        
        if let currentUser = LCUser.current {
            let email = currentUser.email
            let moodRecords = LCObject(className: "MoodRecords")
            
            moodRecords.set("email", value: email)
            moodRecords.set("moodScore", value: moodScore)
            moodRecords.set("sentence", value: sentence)
            
            let LCRsult = moodRecords.save()
            
            if LCRsult.isSuccess {
                result.success = true
            }
        }
        
        return result
    }
    
    //从远端数据库删除记录
    func remove() -> Result {
        var result = Result()
        let object = LCObject(className: "MoodRecords", objectId: objId)
        let LCResult = object.delete()
        
        if LCResult.isSuccess {
            result.success = true
        }
        
        return result
    }
    
    //MARK: Static Methods
    
    //获取当前用户的所有记录
    static func getAllRecords() -> [Record] {
        var result = [Record]()
        let query = LCQuery(className: "MoodRecords")
        
        if let currentUser = LCUser.current {
            query.whereKey("email", .equalTo(currentUser.email!))
        } else {
            fatalError("错误！未登录")
        }
        
        query.whereKey("objectId", .selected)
        query.whereKey("moodScore", .selected)
        query.whereKey("createdAt", .selected)
        query.whereKey("sentence", .selected)
        query.whereKey("createdAt", .ascending)
        
        let queryResult = query.find().objects
        
        if queryResult != nil {
            for object in queryResult! {
                let objectId = object.objectId!.stringValue!
                let objectMoodScore = object.get("moodScore")!.intValue!
                let objectSentence = object.get("sentence")!.stringValue!
                let objectCreatedAt = object.createdAt!.dateValue!
                let record = Record(objId: objectId, moodScore: objectMoodScore, sentence: objectSentence, createdAt: objectCreatedAt)
                
                result.append(record)
            }
        }
        
        return result
    }
    
    //判断今天是否已经记录过了
    static func isAdded() -> Bool {
        let currentDate = Date()
        var dateCompenents = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second], from: currentDate)
        
        dateCompenents.hour = 0
        dateCompenents.minute = 0
        dateCompenents.second = 0
        
        let resDate = Calendar.current.date(from: dateCompenents)
        let query = LCQuery(className: "MoodRecords")
        
        if let currentUser = LCUser.current {
            query.whereKey("email", .equalTo(currentUser.email!))
        } else {
            fatalError("错误！未登录")
        }
        
        query.whereKey("createdAt", .greaterThanOrEqualTo(resDate!))
        
        let queryResult = query.find().objects
        
        if queryResult != nil && !queryResult!.isEmpty{
            return true
        } else {
            return false
        }
    }
}
