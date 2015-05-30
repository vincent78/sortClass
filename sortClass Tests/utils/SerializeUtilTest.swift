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
    
    var testDic:Dictionary<NSObject,AnyObject>
    
    let serializeUtil = SerializeUtil.shareInstance()
    
    override
    init() {

        testDic = ["name":"serializeTest","age":23]
        super.init()
    }
    
    override func setUp() {
        super.setUp()
        printDocumentCount()
        
        
    }
    
    override func tearDown() {
        super.tearDown()
        printDocumentCount()
    }

    func testCreateDocument() {
        if var docId = serializeUtil.createDoc(testDic) {
            LogUtil.debug("" ,title:logTitle)
        }
        
        
        
    }
    
    func printDocumentCount() {
        LogUtil.debug("the document count is \(serializeUtil.getDocumentCount())" ,title:logTitle)
    }
    
}
