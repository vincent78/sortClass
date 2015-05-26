//
//  LogUtil.swift
//  sortClass
//
//  Created by vincent on 15/5/18.
//  Copyright (c) 2015年 Fruit. All rights reserved.
//

enum LogLevel:Int
{
    case info   = 1
    case debug   = 4
    case error  = 7
}

class LogUtil: NSObject
{
    
    //MARK: - basic
    
    /**
    *  @brief  系统日志显示的等级
    */
    static let SYS_LOG_LEVEL:LogLevel = LogLevel.info
    
    class func info(title:String, info:String)
    {
        if SYS_LOG_LEVEL.rawValue >= LogLevel.info.rawValue {
            println("-- \(title)\n\(info)")
        }
    }
    
    class func debug(title:String, info:String)
    {
        if (SYS_LOG_LEVEL.rawValue >= LogLevel.debug.rawValue ) {
            println("== \(title)\n\(info)")
        }
    }
    
    class func error(title:String, info:String)
    {
        if (SYS_LOG_LEVEL.rawValue >= LogLevel.error.rawValue){
            println("** \(title)\n\(info)")
        }
    }
    
    //MARK: - others
    
    class func printError(title:String, error:NSErrorPointer)
    {
        if (SYS_LOG_LEVEL.rawValue >= LogLevel.error.rawValue){
            LogUtil.error(title, info: "error code:\(error.memory?.code)  \nmsg:\(error.memory?.userInfo)")
        }
        
    }
}
