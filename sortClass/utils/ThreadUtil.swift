//
//  ThreadUtil.swift
//  sortClass
//
//  Created by vincent on 15/5/18.
//  Copyright (c) 2015年 Fruit. All rights reserved.
//


public class ThreadUtil: NSObject {
    
    public class func gcd_Main( doBlock: ()->Void){
        dispatch_async(dispatch_get_main_queue(),doBlock)
    }
    
    
    public class func gcd_Back(doBlock: ()->Void){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
            , doBlock)
    }

}
