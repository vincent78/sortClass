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
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSync() {
        
        ThreadUtil.gcd_Back_sync(){
            sleep(2);
            LogUtil.info("task 1 ", title: "\(ThreadUtil.getThreadInfo())");
        }
        LogUtil.info("the 1 task has passed", title: "\(ThreadUtil.getThreadInfo())");
        
        ThreadUtil.gcd_Back_sync(){
            LogUtil.info("task 2 \(ThreadUtil.getThreadInfo())", title: "\(ThreadUtil.getThreadInfo())");
        }
        
        LogUtil.info("the 2 task has passed", title: "\(ThreadUtil.getThreadInfo())");
        
        ThreadUtil.gcd_Back_sync(){
            sleep(5);
            LogUtil.info("task 3 \(ThreadUtil.getThreadInfo())", title: "\(ThreadUtil.getThreadInfo())");
        }
        LogUtil.info("the 3 task has passed", title: "\(ThreadUtil.getThreadInfo())");
        
        ThreadUtil.gcd_Back_sync(){
            LogUtil.info("task 4", title: "\(ThreadUtil.getThreadInfo())");
        }
        LogUtil.info("the 4 task has passed", title: "\(ThreadUtil.getThreadInfo())");
        
        ThreadUtil.gcd_Back_sync(){
            LogUtil.info("task 5", title: "\(ThreadUtil.getThreadInfo())");
        }
        
        LogUtil.info("the 5 task has passed", title: "\(ThreadUtil.getThreadInfo())");
        
        sleep(10)
        XCTAssert(true, "Pass")
    }
    
    func testASync() {
        
        ThreadUtil.gcd_Back_async(){
            println("1")
        }
        
        ThreadUtil.gcd_Back_async(){
            println("2")
        }
        
        ThreadUtil.gcd_Back_async(){
            sleep(2)
            println("3")
        }
        println("invoke the thread 3")
        
        ThreadUtil.gcd_Back_async(){
            println("4")
        }
        
        ThreadUtil.gcd_Back_async(){
            println("5")
        }
        
        println("wait")
        sleep(10)
        XCTAssert(true, "Pass")
    }
}
