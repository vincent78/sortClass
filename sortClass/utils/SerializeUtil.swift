//
//  SerializeUtil.swift
//  sortClass
//
//  Created by vincent on 15/5/21.
//  Copyright (c) 2015年 Fruit. All rights reserved.
//

import UIKit


class SerializeUtil {
    
    //MARK: - Singleton
    
    class func shareInstance()->SerializeUtil{
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
    
    func createDoc(infoDic:Dictionary<NSObject , AnyObject>) -> String?
    {
        var error:NSError?
        
        var doc = database.createDocument()
        
        var newRevision =  doc.putProperties(infoDic, error: &error)
        
        if (error != nil) {
            LogUtil.printError(logTitle, error: &error)
            return nil;
        }
        else {
            return doc.documentID;
        }
    }
    
    func loadDoc(id:String) -> CBLDocument?
    {
        var doc = database.documentWithID(id)
        if (doc.isDeleted) {
            LogUtil.debug(logTitle, info: "doc[\(id)] is deleted!")
            return nil;
        } else {
            return doc;
        }
    }
    
    func loadDocIncludeDeleted(id:String) -> CBLDocument?
    {
        return database.documentWithID(id)
    }
    
    func loadDocProperties(id:String) -> Dictionary<NSObject,AnyObject>?
    {
        return loadDoc(id)?.properties
    }
    
    
    func updateDocById(id:String, infoDic:Dictionary<NSObject,AnyObject>) -> Bool {
        
        if var doc = loadDoc(id) {
            return updateDoc(doc, infoDic: infoDic)
        } else {
            LogUtil.error(logTitle, info: "doc[\(id) is not exist!]")
            return false;
        }
    }
    
    
    func updateDoc(doc :CBLDocument ,infoDic:Dictionary<NSObject,AnyObject>) -> Bool {
        var error:NSError?
        if (doc.putProperties(infoDic, error: &error) != nil) {
            LogUtil.debug(logTitle, info: "doc[\(doc.documentID)] update success!")
            return true;
        }
        else {
            if (error != nil) {
                LogUtil.printError(logTitle, error: &error)
            } else {
                LogUtil.error(logTitle, info: "doc[\(doc.documentID) update failure!]")
            }
            return false;
        }
    }
    
    func deleteDoc(doc :CBLDocument ) {
        
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
    
    func deleteDocById(id:String) {
        if var doc = loadDoc(id) {
            deleteDoc(doc)
        } else {
            LogUtil.debug(logTitle, info: "doc[\(id)] is not exist!")
        }
    }
    
    
    //MARK: - other
    func printDocumentCount(){
        LogUtil.debug(logTitle, info: "document count :\(database.documentCount)")
    }
}
