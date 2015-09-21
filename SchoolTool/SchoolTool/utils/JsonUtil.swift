//
//  JsonUtil.swift
//  SchoolTool
//
//  Created by vincent on 15/6/29.
//  Copyright (c) 2015年 fruit. All rights reserved.
//

import UIKit

public class JsonUtil: NSObject {
    
    /**
    
    返回JSON字符串
    
    - parameter obj: <#obj description#>
    
    - returns: <#return value description#>
    */
    public class func toJSONStr(obj: AnyObject)->String{
        
        if (NSJSONSerialization.isValidJSONObject(obj))
        {
            let data = try? NSJSONSerialization.dataWithJSONObject(obj, options: NSJSONWritingOptions.PrettyPrinted)
            let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
            return jsonStr! as String
        }
        else
        {
            return "";
        }
    }
   
}
