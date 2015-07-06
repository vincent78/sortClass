//
//  ThreadUtil.swift
//  SchoolTool
//
//  Created by vincent on 15/6/29.
//  Copyright (c) 2015年 fruit. All rights reserved.
//

import UIKit



public class ThreadUtil: NSObject {
    
    //the serial queue
    static let SerialDBQueue = dispatch_queue_create("system.sortClass.db.queue", DISPATCH_QUEUE_SERIAL);
    static let AppBackgroudQueue = dispatch_queue_create("system.sortClass.app.queue", DISPATCH_QUEUE_SERIAL);
    
    //MARK: - 主线程
    
    /**
    主线程中异步操作
    
    :param: doBlock <#doBlock description#>
    */
    public class func gcd_Main_ASync( doBlock: ()->Void){
        dispatch_async(dispatch_get_main_queue(),doBlock)
    }
    
    /**
    主线程中同步操作
    
    慎用，很容易死循环
    
    :param: doBlock <#doBlock description#>
    */
    public  class func gcd_Main_Sync( doBlock: ()->Void) {
        
        if (!NSThread.currentThread().isMainThread) {
            dispatch_sync(dispatch_get_main_queue(),doBlock)
        } else {
            gcd_Back_ASync(doBlock)
        }
    }
    
    
    //MARK: - 子线程
    
    
    /**
    子线程中异步操作
    
    :param: doBlock <#doBlock description#>
    */
    public class func gcd_Back_ASync(doBlock: ()->Void){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
            , doBlock)
    }
    
    /**
    子线程中同步操作
    
    :param: doBlock <#doBlock description#>
    */
    public class func gcd_Back_sync(doBlock: ()->Void) {
        dispatch_sync(AppBackgroudQueue, doBlock)
    }
    
    public class func gcd_bd(doBlock:()->Void) {
        dispatch_sync(SerialDBQueue, doBlock)
    }
    
    //MARK: - other
    
    public class func getThreadInfo() -> String {
        return "thread[\(NSThread.currentThread().description)]";
    }
    
    public class func printThreadInfo() {
        println("\(getThreadInfo())");
    }
}
