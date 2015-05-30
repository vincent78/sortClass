//
//  JsonUtil.swift
//  sortClass
//
//  Created by vincent on 15/5/18.
//  Copyright (c) 2015年 Fruit. All rights reserved.
//

public class JsonUtil: NSObject
{
    
    /**
    
    返回JSON字符串
    
    :param: obj <#obj description#>
    
    :returns: <#return value description#>
    */
    public class func toJSONStr(obj: AnyObject)->String{

        if (NSJSONSerialization.isValidJSONObject(obj))
        {
            var data = NSJSONSerialization.dataWithJSONObject(obj, options: NSJSONWritingOptions.PrettyPrinted, error: nil)
            var jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
            return jsonStr! as String
        }
        else
        {
            return "";
        }
    }
    
    
}
