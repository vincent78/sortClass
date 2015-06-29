//
//  UserDefaultUtil.swift
//  SchoolTool
//
//  Created by vincent on 15/6/29.
//  Copyright (c) 2015年 fruit. All rights reserved.
//

import UIKit

public class UserDefaultUtil: NSObject {
    
    //MARK: - set
    public class func setBool(value:Bool,forKey:String)
    {
        NSUserDefaults.standardUserDefaults().setBool(value, forKey: forKey)
    }
    
    public class func setFloat(value:Float,forKey:String)
    {
        NSUserDefaults.standardUserDefaults().setFloat(value, forKey: forKey)
    }
    
    public class func setInteger(value:Int, forKey:String)
    {
        NSUserDefaults.standardUserDefaults().setInteger(value, forKey: forKey)
    }
    
    public class func setObject(value:AnyObject?,forKey:String)
    {
        NSUserDefaults.standardUserDefaults().setObject(value, forKey: forKey)
    }
    
    
    
    //MARK: - get
    public class func boolForKey(keyName:String) -> Bool
    {
        return NSUserDefaults.standardUserDefaults().boolForKey(keyName)
    }
    
    public class func floatForKey(keyName:String) -> Float
    {
        return NSUserDefaults.standardUserDefaults().floatForKey(keyName)
    }
    
    public class func intForKey(keyName:String) -> Int
    {
        return NSUserDefaults.standardUserDefaults().integerForKey(keyName)
    }
    
    public class func stringForKey(keyName:String) -> String?
    {
        return NSUserDefaults.standardUserDefaults().stringForKey(keyName)
    }
    
    public class func arrayForKey(keyName:String) -> Array<AnyObject>?
    {
        return  NSUserDefaults.standardUserDefaults().arrayForKey(keyName) as? Array<AnyObject!>
    }
    
    public class func dictionaryForKey(keyName:String) -> [NSObject : AnyObject]?
    {
        return (NSUserDefaults.standardUserDefaults().dictionaryForKey(keyName) as [NSObject : AnyObject]!)
    }
    
    
    //MARK: - other
    public class func synchronize() -> Bool
    {
        return NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    
    
    public class func removeObjectForKey(keyName:String)
    {
        return NSUserDefaults.standardUserDefaults().removeObjectForKey(keyName)
    }
   
}
