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
    case all    = 9
}


public class LogUtil: NSObject {
    
    //MARK: - color
    static let ESCAPE = "\u{001b}["
    static let RESET_FG = ESCAPE + "fg;" // Clear any foreground color
    static let RESET_BG = ESCAPE + "bg;" // Clear any background color
    static let RESET = ESCAPE + ";"   // Clear any foreground or background color
    
    static func red<T>(object:T) {
        print("\(ESCAPE)fg255,0,0;\(object)\(RESET)")
    }
    
    static func green<T>(object:T) {
        print("\(ESCAPE)fg0,255,0;\(object)\(RESET)")
    }
    
    static func blue<T>(object:T) {
        print("\(ESCAPE)fg0,0,255;\(object)\(RESET)")
    }
    
    static func yellow<T>(object:T) {
        print("\(ESCAPE)fg255,255,0;\(object)\(RESET)")
    }
    
    static func purple<T>(object:T) {
        print("\(ESCAPE)fg255,0,255;\(object)\(RESET)")
    }
    
    static func cyan<T>(object:T) {
        print("\(ESCAPE)fg0,255,255;\(object)\(RESET)")
    }
    
    
    
    
    
    //MARK: - basic
    
    /**
    *  @brief  系统日志显示的等级
    */
    static let SYS_LOG_LEVEL:LogLevel = LogLevel.debug
    
    public class func info(info:String , title:String){
        if SYS_LOG_LEVEL.rawValue >= LogLevel.info.rawValue {
            if (!title.isEmpty) {
                print("\(ESCAPE)fg255,255,0;----\(DateUtil.getTimesnapWithoutDate())---- \(title)\(RESET)")
            }
            print("\(info)")
        }
    }
    
    public class func info(info:String) {
        let title = ""
        LogUtil.info(info, title: title)
    }
    
    
    public class func debug(info:String , title:String){
        if (SYS_LOG_LEVEL.rawValue >= LogLevel.debug.rawValue ) {
            if (!title.isEmpty) {
                print("\(ESCAPE)fg255,0,255;====\(DateUtil.getTimesnapWithoutDate())==== \(title)\(RESET)")
            }
            print("\(info)")
        }
    }
    
    public class func debug(info:String) {
        LogUtil.debug(info, title:"")
    }
    
    
    public class func error(info:String , title:String){
        if (SYS_LOG_LEVEL.rawValue >= LogLevel.error.rawValue){
            if (!title.isEmpty) {
                print("\(ESCAPE)fg255,0,0;****\(DateUtil.getTimesnapWithoutDate())**** \(title)\(RESET)")
            }
            
            print("\(info)")
        }
    }
    
    public class func error(info:String) {
        let title = ""
        LogUtil.error(info, title: title)
    }
    
    //MARK: - others
    
    public class func printError(error:NSErrorPointer ,title:String){
        if (SYS_LOG_LEVEL.rawValue >= LogLevel.error.rawValue){
            LogUtil.error("error code:\(error.memory?.code)  \nmsg:\(error.memory?.userInfo)" ,title: title)
        }
    }
    
    public class func printError(error:NSErrorPointer ){
        let title = ""
        LogUtil.printError(error ,title: title)
    }
    
   
}
