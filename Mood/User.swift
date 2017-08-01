//
//  User.swift
//  Mood
//
//  Created by Hys on 2017/7/23.
//  Copyright © 2017年 Hys. All rights reserved.
//

import UIKit
import LeanCloud
import SQLite

//用户类
class User {
    
    //MARK: Properties
    
    var userName: String!
    var email: String!
    var password: String!
    static let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    static var db: Connection!
    static let users = Table("Users")
    static let userNameAttribute = Expression<String>("userName")
    static let passwordAttribute = Expression<String>("password")
    static let countAttribute = Expression<Int>("count")
    
    //MARK: Initialization
    
    init(userName: String, email: String, password: String) {
        self.userName = userName
        self.email = email
        self.password = password
    }
    
    init(userName: String, password: String) {
        self.userName = userName
        self.password = password
    }
    
    //MARK: Methods
    
    func signUp() -> Result{
        //调用LeanCloudAPI进行注册
        let user = LCUser()
        
        user.username = LCString(userName)
        user.email = LCString(email)
        user.password = LCString(password)
        
        let LCResult = user.signUp()
        var result = Result()
        
        //对注册结果进行处理，重新包装后返回
        if LCResult.isSuccess {
            result.success = true
        } else {
            result.success = false
            switch LCResult.error!.code {
            case 202:
                result.error = .userNameDuplicate
            case 203:
                result.error = .emailDuplicate
            case 125:
                result.error = .unvalidEmail
            default:
                result.success = true
            }
        }
        
        return result
    }
    
    func signIn() -> Result {
        //调用LeanCloudAPI进行登录
        let LCResult = LCUser.logIn(username: userName, password: password)
        var result = Result()
        
        //对登录结果重新包装后返回
        if LCResult.isSuccess {
            result.success = true
        } else {
            result.success = false
            switch LCResult.error!.code {
            case 211:
                result.error = .userNotExist
            case 210:
                result.error = .userNameAndPasswordMismatch
            case 216:
                result.error = .emailUnverified
            default:
                break
            }
        }
        
        return result
    }
    
    static func signOut() {
        LCUser.current = nil
    }
    
    func save() {
        do {
            try User.checkout()

            let currentUser = User.users.filter(User.userNameAttribute == userName)
            
            if try User.db.scalar(currentUser.count) == 0 {
                let insert = User.users.insert(User.userNameAttribute <- userName, User.passwordAttribute <- password, User.countAttribute <- 0)
                
                try User.db.run(insert)
            } else {
                var count = 0
                
                for row in try User.db.prepare(currentUser) {
                    count = row[User.countAttribute]
                }
                
                try User.db.run(currentUser.update(User.countAttribute <- count + 1))
            }
        } catch {
            
        }
    }
    
    static func getUser() -> (String,String)? {
        do {
            try checkout()
            
            let max = try db.scalar(users.select(countAttribute.max))
            
            if max == nil {
                return nil
            }
            
            let currentUser = users.filter(countAttribute == max!)
            
            for row in try db.prepare(currentUser) {
                return (row[userNameAttribute],row[passwordAttribute])
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

            try db.execute("create table if not exists Users(userName text primary key, password text, count int)")
        } catch {
            throw error
        }
    }
}
