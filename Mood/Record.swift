//
//  Record.swift
//  Mood
//
//  Created by Hys on 2017/7/24.
//  Copyright © 2017年 Hys. All rights reserved.
//

import UIKit
import LeanCloud

//记录类
class Record {
    
    //MARK: Properties
    
    var moodScore: Int
    var sentence: String
    var createdAt: Date!
    
    //MARK: Initialization
    
    init(moodScore: Int, sentence: String) {
        self.moodScore = moodScore
        self.sentence = sentence
    }
    
    private init(moodScore: Int, sentence: String, createdAt: Date) {
        self.moodScore = moodScore
        self.sentence = sentence
        self.createdAt = createdAt
    }
    
    //MARK: Public Methods
    
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
    
    //MARK: Static methods
    
    static func getAllRecords() -> [Record] {
        var result = [Record]()
        let query = LCQuery(className: "MoodRecords")
        
        if let currentUser = LCUser.current {
            query.whereKey("email", .equalTo(currentUser.email!))
        } else {
            fatalError("错误！未登录")
        }
        query.whereKey("moodScore", .selected)
        query.whereKey("createdAt", .selected)
        query.whereKey("sentence", .selected)
        query.whereKey("createdAt", .ascending)
        
        let queryResult = query.find().objects
        
        if queryResult != nil {
            for object in queryResult! {
                let objectMoodScore = object.get("moodScore")!.intValue!
                let objectSentence = object.get("sentence")!.stringValue!
                let objectCreatedAt = object.createdAt!.dateValue!
                
                let record = Record(moodScore: objectMoodScore, sentence: objectSentence, createdAt: objectCreatedAt)
                
                result.append(record)
            }
        }
        
        return result
    }
}
