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
    static let dbQueue = dispatch_queue_create("system.sortClass.db.queue", DISPATCH_QUEUE_SERIAL);
    static let backQueue = dispatch_queue_create("system.sortClass.app.queue", DISPATCH_QUEUE_SERIAL);
    
    static let conQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    //MARK: - 主线程
    
    /**
    主线程中异步操作
    
    - parameter doBlock: <#doBlock description#>
    */
    public class func gcd_Main_ASync( doBlock: ()->Void){
        dispatch_async(dispatch_get_main_queue(),doBlock)
    }
    
    /**
    主线程中同步操作
    
    慎用，很容易死循环
    
    - parameter doBlock: <#doBlock description#>
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
    
    - parameter doBlock: <#doBlock description#>
    */
    public class func gcd_Back_ASync(doBlock: ()->Void){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
            , doBlock)
    }
    
    /**
    子线程中同步操作
    
    - parameter doBlock: <#doBlock description#>
    */
    public class func gcd_Back_Sync(doBlock: ()->Void) {
        dispatch_async(backQueue, doBlock)
    }
    
    
    
    
    
    
    
    
    public class func gcd_app(doBlock:() -> Void) {
        dispatch_sync(backQueue, doBlock)
    }
    
    public class func gcd_db(doBlock:()->Void) {
        if (NSThread.currentThread().isMainThread) {
            doBlock()
        } else {
            dispatch_sync(dispatch_get_main_queue(), doBlock)
        }
    }
    
    
    public class func gcd_doCircle(size:size_t,doBlock:(Int)->Void) {
        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_apply(size, queue, doBlock)
    }
    
    
    //MARK: - other
    
    public class func getThreadInfo() -> String {
        return "isMain(\(isMain())) [\(NSThread.currentThread().description)]";
    }
    
    public class func printThreadInfo() {
        print("\(getThreadInfo())");
    }
    
    
    
    
    //MARK: - 整理后的方法
    
    /// 在子线程中同步执行block
    public class func doSyncInSub( doBlock:()->Void) {
        let semaphore = dispatch_semaphore_create(0)
        dispatch_async(conQueue,{
            () -> Void in
            doBlock()
            dispatch_semaphore_signal(semaphore)
        })
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
    }
    
    /// 在子线路中异步执行block
    public class func doASyncInSub( doBlock:()->Void) {
        dispatch_async(conQueue,doBlock)
    }
    
    /// 在主线程中同步执行block
    public class func doSyncInMain( doBlock:()->Void) {
        if ThreadUtil.isMain() {
            doBlock()
        } else {
//            var semaphore = dispatch_semaphore_create(0)
//            dispatch_async(dispatch_get_main_queue()) {
//                doBlock()
//                dispatch_semaphore_signal(semaphore)
//            }
//            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
            
            dispatch_sync(dispatch_get_main_queue(),doBlock)
        }
    }
    
    /// 在主线程中异步执行block
    public class func doASyncInMain( doBlock:()->Void) {
        dispatch_async(dispatch_get_main_queue(), doBlock)
    }
    
    
    /// 是否为主线程
    public class func isMain() -> Bool {
        return NSThread.currentThread().isMainThread
    }

}
