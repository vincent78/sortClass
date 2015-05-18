//
//  DeviceUtil.swift
//  sortClass
//
//  Created by vincent on 15/5/18.
//  Copyright (c) 2015年 Fruit. All rights reserved.
//

import UIKit

class DeviceUtil: NSObject {
    
    
    class func getVersion() -> String{
        
        return UIDevice.currentDevice().systemVersion
        
    }
    
    class func getInfo() -> Dictionary<String,String> {
        
        var infoDic:Dictionary<String , String> = [:]
        
        //获取设备名称
        infoDic["name"] = UIDevice.currentDevice().name
        //获取设备系统名称
        infoDic["systemName"] = UIDevice.currentDevice().systemName
        //获取系统版本
        infoDic["systemVersion"] = UIDevice.currentDevice().systemVersion
        //获取设备模型
        infoDic["model"] = UIDevice.currentDevice().model
        //获取设备本地模型
        infoDic["localizedModel"] = UIDevice.currentDevice().localizedModel
        
        //ip地址
        infoDic["ipAddr"] = OCDevice.getIPAddress()
        

        return infoDic;
    }
    /**
    获取屏幕的宽度
    
    :returns: <#return value description#>
    */
    class func getWidth() -> CGFloat{
        return UIScreen.mainScreen().bounds.width
    }
    
    /**
    获取屏幕的高度
    
    :returns: <#return value description#>
    */
    class func getHeight() -> CGFloat{
        return UIScreen.mainScreen().bounds.height
    }
    
}
