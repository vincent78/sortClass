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
    
    var database:CBLDatabase
    
    
    //MARK: - lifecycle
    init(){
        
        dbManger = CBLManager.sharedInstance()
        
        var error : NSError?
        
//        database = dbManger.existingDatabaseNamed(AppContents.DB_NAME,error:error)
        if (CBLManager.isValidDatabaseName(AppContents.DB_NAME))
        {
            database = dbManger.databaseNamed(AppContents.DB_NAME,error:&error);
        }
        else
        {
            database = dbManger.existingDatabaseNamed(AppContents.DB_NAME, error: &error)
        }
        
    }
   
}
