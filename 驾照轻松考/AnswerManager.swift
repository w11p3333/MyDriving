//
//  AnswerManager.swift
//  驾照轻松考
//
//  Created by 卢良潇 on 16/4/18.
//  Copyright © 2016年 卢良潇. All rights reserved.
//

import UIKit

class AnswerManager: NSObject {

    
    private static let manager: AnswerManager = AnswerManager()
    /// 单例
    class func shareManager() -> AnswerManager {
        return manager
    }
    
    //转化成答案数组
    func formatAnswerToString(str:String) -> [AnyObject]
    {
     var array = [AnyObject]()
     let answerStr = str as NSString
     let arr = answerStr.componentsSeparatedByString("<BR>") as [NSString]
        print(arr)
     array.append(arr[0])
     for i in 0...3
     {
        array.append(arr[i + 1].substringFromIndex(2))
        }
    return array
    }
    
//    func formatSizeToString(str:String,font:UIFont,size:CGSize) -> CGSize
//    {
//     let answerStr = str as NSString
//     let newsize = answerStr.boundingRectWithSize(<#T##size: CGSize##CGSize#>, options: <#T##NSStringDrawingOptions#>, attributes: <#T##[String : AnyObject]?#>, context: <#T##NSStringDrawingContext?#>)
//        return newsize
//        
//    }
}
