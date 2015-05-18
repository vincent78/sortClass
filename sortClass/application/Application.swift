//
//  application.swift
//  sortClass
//
//  Created by vincent on 15/5/18.
//  Copyright (c) 2015年 Fruit. All rights reserved.
//



class Application {
    
    private var _info:Dictionary<String,String> = [:]
    
    
    init(){
        
    }
    
    var info:Dictionary<String,String> {
        get {
            if (_info.isEmpty){
                _info = DeviceUtil.getInfo();
                genInfo()
            }
            return _info;
        }
    }
    
    
    //MARK: - Singleton
    
    class func shareInstance()->Application{
        struct Singleton{
            static var predicate:dispatch_once_t = 0
            static var instance:Application? = nil
        }
        dispatch_once(&Singleton.predicate,{
            
            Singleton.instance = Application()
            
        })
        return Singleton.instance!
    }
    
    
    
    //MARK: - 添加新的信息
    
    func genInfo(){
        
        let mainBundleInfoDict = NSBundle.mainBundle().infoDictionary
        if let info = mainBundleInfoDict {
            // app名称
            _info["CFBundleName"] = info["CFBundleName"] as! String!
            // app版本
            _info["CFBundleShortVersionString"] = info["CFBundleShortVersionString"] as! String!
            // app build版本
            _info["CFBundleVersion"] = info["CFBundleVersion"]as! String!
        }
    }
    
    
    //MARK: - 提供的信息
    
    func resetInfo(){
        _info.removeAll(keepCapacity: false)
    }
    
    /**
    获取当前系统信息
    
    :returns: <#return value description#>
    */
    class func getInfoStr() -> String{
        return JsonUtil.toJSONString(Application.shareInstance().info);
    }
    
    /**
    获取当前APP的版本
    
    :returns: <#return value description#>
    */
    class func getVersion() -> String{
        return Application.shareInstance().info["CFBundleVersion"]!
    }
    
    //MARK: - 路径相关
    
    /**
    获取当前沙盒的路径
    
    :returns: <#return value description#>
    */
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
