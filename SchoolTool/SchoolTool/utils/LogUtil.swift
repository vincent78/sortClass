//
//  LogUtil.swift
//  SchoolTool
//
//  Created by vincent on 15/6/29.
//  Copyright (c) 2015年 fruit. All rights reserved.
//

import UIKit

enum LogLevel:UInt
{
    case info   = 1
    case error   = 4
    case debug  = 7
}


public class LogUtil: NSObject {
    
    //MARK: - basic
    
    /**
    *  @brief  系统日志显示的等级
    */
    static let SYS_LOG_LEVEL:LogLevel = LogLevel.debug
    
    public class func info(info:String , title:String = "default title")
    {
        if SYS_LOG_LEVEL.rawValue >= LogLevel.info.rawValue {
            println("-- \(title)\n\(info)")
        }
    }
    
    public class func debug(info:String , title:String = "default title")
    {
        if (SYS_LOG_LEVEL.rawValue >= LogLevel.debug.rawValue ) {
            println("== \(title)\n\(info)")
        }
    }
    
    public class func error(info:String , title:String = "default title")
    {
        if (SYS_LOG_LEVEL.rawValue >= LogLevel.error.rawValue){
            println("** \(title)\n\(info)")
        }
    }
    
    //MARK: - others
    
    public class func printError(error:NSErrorPointer ,title:String = "default title")
    {
        if (SYS_LOG_LEVEL.rawValue >= LogLevel.error.rawValue){
            LogUtil.error("error code:\(error.memory?.code)  \nmsg:\(error.memory?.userInfo)" ,title: title)
        }
        
    }
   
}
