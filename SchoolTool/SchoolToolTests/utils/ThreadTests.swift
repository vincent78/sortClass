//
//  ThreadTests.swift
//  SchoolTool
//
//  Created by vincent on 15/6/29.
//  Copyright (c) 2015年 fruit. All rights reserved.
//

import UIKit
import XCTest
import SchoolTool

class ThreadTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        println("\n\n\n")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        
        println("\n\n\n")
    }
    
    

    func testDoASyncInSub() {
        

        
        var doBlock = {
            () -> Void in
            println("the method thread \(ThreadUtil.getThreadInfo())")
        }
        
        ThreadUtil.doASyncInSub(doBlock)
        
//        sleep(2)
        LogUtil.debug("the end1.")
        
        ThreadUtil.doASyncInSub() {
            ()->Void in
            println("the invoke subThread \(ThreadUtil.getThreadInfo())")
            ThreadUtil.doASyncInSub(doBlock)
//            sleep(2)
            LogUtil.debug("invoke end.")
        }
//        sleep(1)
        LogUtil.debug("the end2.")
        
        sleep(4)

        
    }
    
    func testDoSyncInSub() {
        
        var doBlock = {
            () -> Void in
            println("thread: \(ThreadUtil.getThreadInfo())")
        }
        ThreadUtil.doSyncInSub(doBlock)
        LogUtil.debug("the end1.")
        
        
        //嵌套调用
        ThreadUtil.doSyncInSub(){
            ThreadUtil.printThreadInfo()
            ThreadUtil.doSyncInSub(doBlock)
        }
        
        
        LogUtil.debug("the end2.")
        
        
        for i in 1...10 {
            ThreadUtil.doSyncInSub() {
                println("thread: \(ThreadUtil.getThreadInfo()) the order:\(i) ")
            }
        }
        LogUtil.debug("the end3.")

    }
    
    
    
    /**
    循环
    */
    func testCircle() {
        var doBlock = {
            (i:Int) -> Void in
            println("\(i)")
        }
        ThreadUtil.gcd_doCircle(9, doBlock:doBlock)
    }
    
    
    
}
