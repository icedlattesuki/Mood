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
    
    //MARK: Public Methods
    
    //用户注册
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
    
    //用户登录
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
    
    //将当前用户的用户名和密码保存至数据库
    func save() {
        do {
            //检测
            try User.checkout()
            
            //获取当前用户的记录
            let currentUser = User.users.filter(User.userNameAttribute == userName)
            
            //检测当前用户是否有记录
            if try User.db.scalar(currentUser.count) == 0 {
                //没有记录，则需要向数据库插入一条记录
                let insert = User.users.insert(User.userNameAttribute <- userName, User.passwordAttribute <- password, User.countAttribute <- 0)
                
                try User.db.run(insert)
            } else {
                var count = 0
                
                for row in try User.db.prepare(currentUser) {
                    count = row[User.countAttribute]
                }
                
                //有记录，则需要更新其count
                try User.db.run(currentUser.update(User.countAttribute <- count + 1))
            }
        } catch {
            
        }
    }
    
    
    //MARK: Static Methods
    
    //用户等出
    static func signOut() {
        LCUser.current = nil
    }
    
    //获取最常登录的用户的用户名和密码，执行过程中如产生错误则返回nil
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
    
    //检测，有错误会向上抛出
    static func checkout() throws {
        do {
            //检测数据库连接
            if db == nil {
                db = try Connection("\(documentPath)/db.sqlite3")
            }

            //检测表
            try db.execute("create table if not exists Users(userName text primary key, password text, count int)")
        } catch {
            throw error
        }
    }
}
