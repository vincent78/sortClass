//
//  SerializeUtil.swift
//  sortClass
//
//  Created by vincent on 15/5/21.
//  Copyright (c) 2015年 Fruit. All rights reserved.
//

import UIKit


public class SerializeUtil {
    
    //MARK: - Singleton
    
    public class func shareInstance()->SerializeUtil{
        struct Singleton{
            static var predicate:dispatch_once_t = 0
            static var instance:SerializeUtil? = nil
        }
        dispatch_once(&Singleton.predicate,{
            
            Singleton.instance = SerializeUtil()
            
        })
        return Singleton.instance!
    }
    
    //MARK: - 实例属性
    
    var dbManger:CBLManager
    
    var database:CBLDatabase!
    
    let logTitle = "db info"
    
    
    //MARK: - lifecycle
    init(){
        
        dbManger = CBLManager.sharedInstance()
        
        var error : NSError?

        if (CBLManager.isValidDatabaseName(AppContents.DB_NAME)){
            
            database = dbManger.databaseNamed(AppContents.DB_NAME, error: &error)
            
            if (error != nil) {
                LogUtil.printError(logTitle, error: &error)
                return;
            }
            
            LogUtil.info(logTitle, info: "path:\(dbManger.directory)")
        }
        else
        {
            LogUtil.error(logTitle, info: "the bad db name")
        }
        
        
    }
    
    //MARK: - CRUD
    
    public func createDoc(infoDic:Dictionary<NSObject , AnyObject>) -> String?
    {
        var error:NSError?
        
        var doc = database.createDocument()
        
        var newRevision =  doc.putProperties(infoDic, error: &error)
        
        if (error != nil) {
            LogUtil.printError(logTitle, error: &error)
            return nil;
        } else {
            LogUtil.debug(logTitle, info: "doc[\(doc.documentID) created success!]")
            return doc.documentID;
        }
    }
    
    public func loadDoc(id:String) -> CBLDocument?
    {
        var doc = database.documentWithID(id)
        if (doc.isDeleted) {
            LogUtil.debug(logTitle, info: "doc[\(id)] is deleted!")
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
            LogUtil.error(logTitle, info: "doc[\(id) is not exist!]")
            return false;
        }
    }
    
    
    public func updateDoc(var doc :CBLDocument! ,infoDic:Dictionary<NSObject,AnyObject>) -> Bool {
        
        var error:NSError?
        var newRev = doc.putProperties(infoDic, error: &error)
        if (newRev != nil) {
            LogUtil.debug(logTitle, info: "doc[\(doc.documentID)] update success!")
            return true;
        } else {
            if (error != nil) {
                LogUtil.printError(logTitle, error: &error)
            } else {
                LogUtil.error(logTitle, info: "doc[\(doc.documentID) update failure!]")
            }
            return false;
        }
    }
    
    public func deleteDoc(doc :CBLDocument ) {
        
        if (doc.isDeleted) {
            LogUtil.debug(logTitle, info: "doc[\(doc.documentID)] has deleted!")
            return
        }
        
        var error:NSError?
        if (doc.deleteDocument(&error)) {
            LogUtil.debug(logTitle, info: "doc[\(doc.documentID)] delete success!")
        } else {
            if (error != nil) {
                LogUtil.printError(logTitle, error: &error)
            } else {
                LogUtil.error(logTitle, info: "doc[\(doc.documentID) delete failure!]")
            }
        }
    }
    
    public func deleteDocById(id:String) {
        if var doc = loadDoc(id) {
            deleteDoc(doc)
        } else {
            LogUtil.debug(logTitle, info: "doc[\(id)] is not exist!")
        }
    }
    
    
    //MARK: - db info
    public func getDocumentCount() -> Int {
        return Int(database.documentCount)
    }
}
