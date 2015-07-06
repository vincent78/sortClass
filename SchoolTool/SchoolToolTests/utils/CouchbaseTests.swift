//
//  CouchbaseTests.swift
//  SchoolTool
//
//  Created by vincent on 15/6/29.
//  Copyright (c) 2015年 fruit. All rights reserved.
//

import UIKit
import XCTest
import SchoolTool

class CouchbaseTests: XCTestCase {

    
    var logTitle = "test serialize"
    
    var testDic:Dictionary<NSObject,AnyObject>!
    
    let couchbaseUtil = CouchbaseUtil.shareInstance()
    
    override func setUp() {
        super.setUp()
        printDocumentCount()
        
        testDic = ["name":"serializeTest","age":23]
        LogUtil.debug("testDic:\(testDic)")
        
    }
    
    override func tearDown() {
        super.tearDown()
        printDocumentCount()
    }
    
    func testCRUD() {
        if var docId = couchbaseUtil.createDoc(testDic) {
            XCTAssertNotNil(docId, "test doc created success!")
            testDic.updateValue(24, forKey: "age")
            testDic.updateValue("test", forKey: "remark")
            LogUtil.debug("testDic:\(testDic)")
            XCTAssert(couchbaseUtil.updateDocById(docId, infoDic: testDic), "update the test success!")
            printDocumentCount()
            XCTAssert(couchbaseUtil.deleteDocById(docId), "delete the test success!")
        } else {
            XCTFail("doc create failure!")
        }
    }
    
    
    func testMutliThread() {
        
        let threadMethod = {
            [unowned self](name:String) -> () in
            for  i  in 0...1000 {
                self.couchbaseUtil.createDoc(["obj":name,"seq":i,"timesnap":DateUtil.getTimesnap()])
                LogUtil.info("do is end! \(name)")
            }
        }
        ThreadUtil.gcd_Back_ASync(){
            threadMethod("thread1")
        }
        
        sleep(10)
        
    }
    
    
    
    func printDocumentCount() {
        LogUtil.debug("the document count is \(couchbaseUtil.getDocumentCount())")
    }

}
