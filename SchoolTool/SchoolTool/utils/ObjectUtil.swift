//
//  ObjectUtil.swift
//  SchoolTool
//
//  Created by vincent on 15/7/6.
//  Copyright (c) 2015年 fruit. All rights reserved.
//

import UIKit

public class ObjectUtil: NSObject {
    
    public class func getClassName() -> String {
        return NSStringFromClass( object_getClass(self))
    }
   
}
