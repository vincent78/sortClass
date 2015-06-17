//
//  SerializeUtilTest.swift
//  sortClass
//
//  Created by vincent on 15/5/30.
//  Copyright (c) 2015年 Fruit. All rights reserved.
//

import UIKit
import XCTest
import sortClass

class SerializeUtilTest: XCTestCase {
    
    var logTitle = "test serialize"
    
    var testDic:Dictionary<NSObject,AnyObject>!
    
    let serializeUtil = SerializeUtil.shareInstance()
    
    override func setUp() {
        super.setUp()
        printDocumentCount()
        
        testDic = ["name":"serializeTest","age":23]
        LogUtil.debug("testDic:\(testDic)", title: logTitle)
        
    }
    
    override func tearDown() {
        super.tearDown()
        printDocumentCount()
    }

    func testCRUD() {
        if var docId = serializeUtil.createDoc(testDic) {
            XCTAssertNotNil(docId, "test doc created success!")
            testDic.updateValue(24, forKey: "age")
            testDic.updateValue("test", forKey: "remark")
            LogUtil.debug("testDic:\(testDic)", title: logTitle)
            XCTAssert(serializeUtil.updateDocById(docId, infoDic: testDic), "update the test success!")
            XCTAssert(serializeUtil.deleteDocById(docId), "delete the test success!")
        } else {
            XCTFail("doc create failure!")
        }
    }
    
    
    func printDocumentCount() {
        LogUtil.debug("the document count is \(serializeUtil.getDocumentCount())" ,title:logTitle)
    }
    
}
