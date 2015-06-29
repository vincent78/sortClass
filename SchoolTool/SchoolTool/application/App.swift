//
//  Application.swift
//  SchoolTool
//
//  Created by vincent on 15/6/29.
//  Copyright (c) 2015年 fruit. All rights reserved.
//

import UIKit

class App: NSObject {
    
    private var _info:Dictionary<String,AnyObject> = [:]
    
    override init(){
    }
    
    var info:Dictionary<String,AnyObject> {
        get {
            if (_info.isEmpty){
                genInfo()
            }
            return _info;
        }
    }
    
    
    //MARK: - Singleton
    
    class func shareInstance()->App{
        struct Singleton{
            static var predicate:dispatch_once_t = 0
            static var instance:App? = nil
        }
        dispatch_once(&Singleton.predicate,{
            
            Singleton.instance = App()
            
        })
        return Singleton.instance!
    }
    
    
    
    
    
    //MARK: - 提供的信息
    
    /**
    获取系统的信息
    */
    private func genInfo(){
        
        _info = DeviceUtil.getInfo()
        
        let mainBundleInfoDict = NSBundle.mainBundle().infoDictionary
        if let info = mainBundleInfoDict {
            // app名称
            _info["CFBundleName"] = info["CFBundleName"] as! String!
            // app版本
            _info["CFBundleShortVersionString"] = info["CFBundleShortVersionString"] as! String!
            // app build版本
            _info["CFBundleVersion"] = info["CFBundleVersion"]as! String!
            // app path
            _info["CFBundlePath"] = App.getAppPath()
        }
    }
    /**
    重设系统的信息
    */
    func resetInfo(){
        _info.removeAll(keepCapacity: false)
    }
    
    
    
    /**
    获取当前系统信息
    
    :returns: <#return value description#>
    */
    class func getInfoStr() -> Dictionary<String,AnyObject>{
        return App.shareInstance().info;
    }
    
    /**
    打印系统信息
    */
    class func printSysInfo() {
        LogUtil.info("\(JsonUtil.toJSONStr(App.shareInstance().info))", title: "system info")
    }
    
    
    /**
    获取当前APP的版本
    
    :returns: <#return value description#>
    */
    class func getVersion() -> String{
        return App.shareInstance().info["CFBundleVersion"] as! String
    }
    
    //MARK: - 路径相关
    
    class func getAppPath() ->String{
        if var homePath = NSHomeDirectory(){
            return homePath
        } else {
            return getDocPath().stringByDeletingLastPathComponent
        }
    }
    
    class func getDocPath() -> String{
        var pathInfo = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory
            ,NSSearchPathDomainMask.UserDomainMask,true) as Array
        
        return pathInfo[0] as! String
    }
    
    class func getCachePath() -> String{
        var pathInfo = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory
            ,NSSearchPathDomainMask.UserDomainMask,true) as Array
        
        return pathInfo[0] as! String
    }
    
    class func getTmpPath() -> String{
        return NSTemporaryDirectory();
    }
    
    class func getLibPath() -> String{
        var pathInfo = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.LibraryDirectory
            ,NSSearchPathDomainMask.UserDomainMask,true) as Array
        
        return pathInfo[0] as! String
    }
   
}
