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
            
            Singleton.instance = CouchbaseUtil()
            
        })
        return Singleton.instance!
    }
    
    //MARK: - 实例属性
    
    var dbManger:CBLManager
    
    var database:CBLDatabase!
    
    let logTitle = "couchbase info"
    
    
    //MARK: - lifecycle
    override init(){
        
        dbManger = CBLManager.sharedInstance()
        
        var error : NSError?
        
        if (CBLManager.isValidDatabaseName("test")){
            
            database = dbManger.databaseNamed("test", error: &error)
            
            if (error != nil) {
                LogUtil.printError(&error ,title:logTitle)
                return;
            }
            
            LogUtil.info("path:\(dbManger.directory)" ,title:logTitle)
        }
        else
        {
            LogUtil.error("the bad db name" ,title:logTitle)
        }
        
        
    }
    
    //MARK: - CRUD
    
    public func createDoc(infoDic:Dictionary<NSObject , AnyObject>) -> String?
    {
        var docId:String!
        var error:NSError?
        
        
        var doc = database.createDocument()
        
        var newRevision =  doc.putProperties(infoDic, error: &error)
        
        if (error != nil) {
            LogUtil.printError(&error ,title:logTitle)
            return nil;
        } else {
            LogUtil.debug("doc[\(doc.documentID) created success!]" ,title:logTitle)
            docId = doc.documentID
            doc = nil
            return docId;
        }
    }
    
    public func loadDoc(id:String) -> CBLDocument?
    {
        var doc = database.documentWithID(id)
        if (doc.isDeleted) {
            LogUtil.debug("doc[\(id)] is deleted!" ,title:logTitle)
            return nil;
        } else {
            return doc;
        }
    }
    
    public func loadDocIncludeDeleted(id:String) -> CBLDocument?
    {
        return database.documentWithID(id)
    }
    
    func loadDocProperties(id:String) -> Dictionary<NSObject,AnyObject>?
    {
        return loadDoc(id)?.properties
    }
    
    
    public func updateDocById(id:String, infoDic:Dictionary<NSObject,AnyObject>) -> Bool {
        
        if var doc = loadDoc(id) {
            return updateDoc(doc, infoDic: infoDic)
        } else {
            LogUtil.error("doc[\(id) is not exist!]" , title:logTitle)
            return false;
        }
    }
    
    
    public func updateDoc(var doc :CBLDocument! ,infoDic:Dictionary<NSObject,AnyObject>) -> Bool {
        
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
            LogUtil.debug("doc[\(doc.documentID)] update success!" ,title:logTitle)
            return true;
        } else {
            if (error != nil) {
                LogUtil.printError(&error ,title:logTitle)
            } else {
                LogUtil.error("doc[\(doc.documentID) update failure!]" ,title:logTitle)
            }
            return false;
        }
    }
    
    public func deleteDoc(doc :CBLDocument ) -> Bool {
        
        if (doc.isDeleted) {
            LogUtil.debug("doc[\(doc.documentID)] has deleted!" ,title:logTitle)
            return true;
        }
        
        var error:NSError?
        if (doc.deleteDocument(&error)) {
            LogUtil.debug("doc[\(doc.documentID)] delete success!" ,title:logTitle)
            return true;
        } else {
            if (error != nil) {
                LogUtil.printError(&error ,title:logTitle)
            } else {
                LogUtil.error("doc[\(doc.documentID) delete failure!]" ,title:logTitle)
            }
            return false;
        }
    }
    
    public func deleteDocById(id:String) ->Bool{
        if var doc = loadDoc(id) {
            return deleteDoc(doc)
        } else {
            LogUtil.debug("doc[\(id)] is not exist!" ,title:logTitle)
            return false;
        }
    }
    
    
    //MARK: - query
    
    
    //MARK: - db info
    public func getDocumentCount() -> UInt {
        return database.documentCount
    }
}
