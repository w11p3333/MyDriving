//
//  DataBaseManager.swift
//  驾照轻松考
//
//  Created by 卢良潇 on 16/4/17.
//  Copyright © 2016年 卢良潇. All rights reserved.
//

import UIKit
import FMDB

enum SubjectType {
    case chapter //章节练习
    case answer //答案
    case subChapter //专项练习
}
var dataBase: FMDatabase?
class DataBaseManager: NSObject {
    

 //   static var dataBase: FMDatabase
    private static let manager: DataBaseManager = DataBaseManager()
    /// 单例
    class func shareManager() -> DataBaseManager {
        return manager
    }
    
    
    func getData(type:SubjectType) -> [AnyObject]
    {
        var array = [AnyObject]()
        if dataBase == nil
        {
            let path =  NSBundle.mainBundle().pathForResource("data", ofType: "sqlite")
            dataBase = FMDatabase(path: path)
            if dataBase!.open()
            {
             
            }
            else
            {
                return array
            }
            
            switch type {
            case .chapter:
            let sql = "select pid,pname,pcount from firstlevel"
           let result = dataBase!.executeQuery(sql, withArgumentsInArray: nil)
            while result!.next() {
                let model = SubjectName()
                model.pid = String(result!.intForColumn("pid"))
                model.pname = result!.stringForColumn("pname")
                model.pcount = String(result!.intForColumn("pcount"))
                array.append(model)
               
            }
              
            case .answer:
            let sql = "select mquestion,mdesc,mid,manswer,mimage,pid,sid,sname,mtype from leaflevel"
            let result = dataBase!.executeQuery(sql, withArgumentsInArray: nil)
            while result!.next() {
                let model = Answer()
                model.mquestion = result!.stringForColumn("mquestion")
                model.mdesc = result!.stringForColumn("mdesc")
                model.mid = String(result!.intForColumn("mid"))
                model.manswer = result!.stringForColumn("manswer")
                model.mimage = result!.stringForColumn("mimage")
                model.pid = String(result!.intForColumn("pid"))
                model.sid = String(result!.intForColumn("sid"))
                model.sname = result!.stringForColumn("sname")
                model.mtype = String(result!.intForColumn("mtype"))
                print(model.mquestion)
                array.append(model)
                }
            case .subChapter:
                let sql = "select serial,sid,sname,pid,scount from secondlevel"
                let result = dataBase!.executeQuery(sql, withArgumentsInArray: nil)
                while result!.next() {
                    let model = SubChapter()
                    model.serial = result!.stringForColumn("serial")
                    model.sid = String(format: "%.2f", result!.doubleForColumn("sid"))
                    model.pid = String(result!.intForColumn("pid"))
                    model.sname = result!.stringForColumn("sname")
                    model.scount = String(result!.intForColumn("scount"))
                    array.append(model)
                }
  
            }
       }
        
        
       return array
        
    }
    
    
    
    
}