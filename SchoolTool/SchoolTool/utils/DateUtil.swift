//
//  DateUtil.swift
//  SchoolTool
//
//  Created by vincent on 15/6/29.
//  Copyright (c) 2015年 fruit. All rights reserved.
//

import UIKit

public class DateUtil: NSObject {
    
    /**
    返回时间戳
    
    :returns: <#return value description#>
    */
    public class func getTimesnap() -> String {
        var retStr = Date().timeWithDefault()
        return retStr
    }
   
}
