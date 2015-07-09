//
//  CouchbaseUtil.swift
//  SchoolTool
//
//  Created by vincent on 15/6/29.
//  Copyright (c) 2015年 fruit. All rights reserved.
//

import UIKit

public class CouchbaseUtil: NSObject {
    //MARK: - Singleton
    
    public class func shareInstance()->CouchbaseUtil{
        struct Singleton{
            static var predicate:dispatch_once_t = 0
            static var instance:CouchbaseUtil? = nil
        }
        dispatch_once(&Singleton.predicate,{
            LogUtil.debug("",title: ObjectUtil.getClassName(self) + " | " + __FUNCTION__)
            Singleton.instance = CouchbaseUtil()
            
        })
        return Singleton.instance!
    }
    
    //MARK: - 实例属性
    
    var dbManger:CBLManager
    var database:CBLDatabase!
    
    let defaultDBName = "test"
    
    //MARK: - lifecycle
    override init(){

        dbManger = CBLManager.sharedInstance()
        super.init()
        
        var error : NSError?
        if (CBLManager.isValidDatabaseName(defaultDBName)){

            self.database = self.dbManger.databaseNamed(self.defaultDBName, error: &error)

            
            if (error != nil) {
                LogUtil.printError(&error)
                return;
            }
            
            LogUtil.info("path:\(dbManger.directory)")
        }
        else
        {
            LogUtil.error("the bad db name")
        }
        
        
    }
    
    //MARK: - CRUD
    
    public func createDoc(infoDic:Dictionary<NSObject , AnyObject>) -> String?
    {
        LogUtil.debug("",title: ObjectUtil.getClassName(self) + " | " + __FUNCTION__)
        LogUtil.debug("run in \(NSThread.currentThread().description)")
        
        var docId:String!
        ThreadUtil.gcd_db({
            ()->Void in
            LogUtil.debug("run in gcd_db thread: \(NSThread.currentThread().description)")
            var error:NSError?
            var doc : CBLDocument?
            doc = self.database.createDocument()
            var newRevision =  doc!.putProperties(infoDic, error: &error)
            if (error != nil) {
                LogUtil.printError(&error)
            } else {
                LogUtil.debug("doc[\(doc!.documentID) created success!]")
                docId = doc!.documentID
                doc = nil
            }
        })
        LogUtil.debug(" the create oper is end!")
        
        return docId;
        
    }
    
    public func loadDoc(id:String) -> CBLDocument?
    {
        LogUtil.debug("",title: ObjectUtil.getClassName(self) + " | " + __FUNCTION__)
        
        var doc = database.documentWithID(id)
        if (doc.isDeleted) {
            LogUtil.debug("doc[\(id)] is deleted!")
            return nil;
        } else {
            return doc;
        }
    }
    
    public func loadDocIncludeDeleted(id:String) -> CBLDocument?
    {
        LogUtil.debug("",title: ObjectUtil.getClassName(self) + " | " + __FUNCTION__)
        
        return database.documentWithID(id)
    }
    
    func loadDocProperties(id:String) -> Dictionary<NSObject,AnyObject>?
    {
        LogUtil.debug("",title: ObjectUtil.getClassName(self) + " | " + __FUNCTION__)
        
        return loadDoc(id)?.properties
    }
    
    
    public func updateDocById(id:String, infoDic:Dictionary<NSObject,AnyObject>) -> Bool {
        LogUtil.debug("",title: ObjectUtil.getClassName(self) + " | " + __FUNCTION__)
        
        if var doc = loadDoc(id) {
            return updateDoc(doc, infoDic: infoDic)
        } else {
            LogUtil.error("doc[\(id) is not exist!]")
            return false;
        }
    }
    
    
    public func updateDoc(var doc :CBLDocument! ,infoDic:Dictionary<NSObject,AnyObject>) -> Bool {
        LogUtil.debug("",title: ObjectUtil.getClassName(self) + " | " + __FUNCTION__)
        
        var error:NSError?
        var actDic = Dictionary<NSObject,AnyObject>()
        
        if var revId = doc.currentRevisionID {
            for (key,value) in infoDic {
                actDic[key] = value
            }
            actDic.updateValue(revId, forKey: "_rev")
        }
        
        
        var newRev = doc.putProperties(actDic, error: &error)
        if (newRev != nil) {
            LogUtil.debug("doc[\(doc.documentID)] update success!")
            return true;
        } else {
            if (error != nil) {
                LogUtil.printError(&error)
            } else {
                LogUtil.error("doc[\(doc.documentID) update failure!]" )
            }
            return false;
        }
    }
    
    public func deleteDoc(doc :CBLDocument ) -> Bool {
        LogUtil.debug("",title: ObjectUtil.getClassName(self) + " | " + __FUNCTION__)
        
        if (doc.isDeleted) {
            LogUtil.debug("doc[\(doc.documentID)] has deleted!")
            return true;
        }
        
        var error:NSError?
        if (doc.deleteDocument(&error)) {
            LogUtil.debug("doc[\(doc.documentID)] delete success!" )
            return true;
        } else {
            if (error != nil) {
                LogUtil.printError(&error)
            } else {
                LogUtil.error("doc[\(doc.documentID) delete failure!]")
            }
            return false;
        }
    }
    
    public func deleteDocById(id:String) ->Bool{
        
        LogUtil.debug("",title: ObjectUtil.getClassName(self) + " | " + __FUNCTION__)
        
        if var doc = loadDoc(id) {
            return deleteDoc(doc)
        } else {
            LogUtil.debug("doc[\(id)] is not exist!")
            return false;
        }
    }
    
    
    //MARK: - query
    
    
    //MARK: - db info
    public func getDocumentCount() -> UInt {
        LogUtil.debug("",title: ObjectUtil.getClassName(self) + " | " + __FUNCTION__)
        return database.documentCount
    }
}
