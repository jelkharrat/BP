//
//  DataServices.swift
//  BP
//
//  Created by Nessin Elkharrat on 5/28/18.
//  Copyright © 2018 practice. All rights reserved.
//

import Foundation
import Firebase

let DB_Base = Database.database().reference()

class DataService {
    static let instance = DataService()
    
    private var _REF_BASE = DB_Base
    private var _REF_USERS = DB_Base.child("users")
    private var _REF_GROUPS = DB_Base.child("groups")
    private var _REF_FEED = DB_Base.child("feed")
    
    var REF_BASE: DatabaseReference {
        return _REF_BASE
    }
    
    var REF_USERS: DatabaseReference {
        return _REF_USERS
    }
    
    var REF_GROUPS: DatabaseReference {
        return _REF_GROUPS
    }
    
    var REF_FEED: DatabaseReference {
        return _REF_FEED
    }
    
    func createDBUser(uid:String, userData:Dictionary<String, Any>) {
        REF_USERS.child(uid).updateChildValues(userData)
    }
}
