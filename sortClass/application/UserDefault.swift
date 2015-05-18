//
//  UserDefault.swift
//  sortClass
//
//  Created by vincent on 15/5/18.
//  Copyright (c) 2015年 Fruit. All rights reserved.
//

class UserDefault: NSObject {
    
    //MARK: - set
    class func setBool(value:Bool,forKey:String)
    {
        NSUserDefaults.standardUserDefaults().setBool(value, forKey: forKey)
    }
    
    class func setFloat(value:Float,forKey:String)
    {
        NSUserDefaults.standardUserDefaults().setFloat(value, forKey: forKey)
    }
    
    class func setInteger(value:Int, forKey:String)
    {
        NSUserDefaults.standardUserDefaults().setInteger(value, forKey: forKey)
    }
    
    class func setObject(value:AnyObject?,forKey:String)
    {
        NSUserDefaults.standardUserDefaults().setObject(value, forKey: forKey)
    }
    

    
    //MARK: - get
    class func boolForKey(keyName:String) -> Bool
    {
        return NSUserDefaults.standardUserDefaults().boolForKey(keyName)
    }
    
    class func floatForKey(keyName:String) -> Float
    {
        return NSUserDefaults.standardUserDefaults().floatForKey(keyName)
    }
    
    class func intForKey(keyName:String) -> Int
    {
        return NSUserDefaults.standardUserDefaults().integerForKey(keyName)
    }
    
    class func stringForKey(keyName:String) -> String?
    {
        return NSUserDefaults.standardUserDefaults().stringForKey(keyName)
    }
    
    class func arrayForKey(keyName:String) -> Array<AnyObject>?
    {
        return  NSUserDefaults.standardUserDefaults().arrayForKey(keyName) as? Array<AnyObject!>
    }
    
    class func dictionaryForKey(keyName:String) -> [NSObject : AnyObject]?
    {
        return (NSUserDefaults.standardUserDefaults().dictionaryForKey(keyName) as [NSObject : AnyObject]!)
    }
    
    
    //MARK: - other
    class func synchronize() -> Bool
    {
        return NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    
    
    class func removeObjectForKey(keyName:String)
    {
        return NSUserDefaults.standardUserDefaults().removeObjectForKey(keyName)
    }
    
    
}
