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
        } else {
            XCTFail("doc create failure!")
        }
    }
    
    func testUpdate() {
        var docId = "7D368CF0-CB41-429B-B89D-792D83B7EBED";
        testDic.updateValue(24, forKey: "age")
        testDic.updateValue("test", forKey: "remark")
        XCTAssert(serializeUtil.updateDocById(docId, infoDic: testDic), "update the test success!")
    }
    
    
    
    func printDocumentCount() {
        LogUtil.debug("the document count is \(serializeUtil.getDocumentCount())" ,title:logTitle)
    }
    
}
