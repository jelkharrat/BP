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
    
    //update child values allows you to update the dictionary with values
    func createDBUser(uid:String, userData:Dictionary<String, Any>) {
        REF_USERS.child(uid).updateChildValues(userData)
    }
    
    //Call this function in the FeedVC cellforrowat
    func getUserName(forUID uid: String, handler: @escaping (_ username: String) -> ()) {
        REF_USERS.observeSingleEvent(of: .value) { (userSnapShot) in
            //going through database once
            guard let userSnapShot = userSnapShot.children.allObjects as?  [DataSnapshot] else { return }
            
            for user in userSnapShot{
                if user.key == uid {
                    //using this handler in cellForRowAt in FeedVC
                    handler(user.childSnapshot(forPath: "email").value as! String)
                }
            }
        }
    }
    
    //throws a message up into firebase
    func uploadPost(withMessage message: String, forUID uid: String, withGroupKey groupKey: String?, sendComplete: @escaping SENDCOMPLETE) {
        if groupKey != nil {
            //send to group ref
        } else {
            // childByAutoId = unique identifier to each individual message. update with a dictionary
            REF_FEED.childByAutoId().updateChildValues(["content": message, "senderId": uid])
            sendComplete(true)
        }
    }
    
    //Want to pull info from the Feed reference (_RED_FFEED), then want to pass data out of closure so we use a handler for that
    func getAllFeedMessages(handler: @escaping (_ messages: [Message]) -> ()) {
        var messageArray = [Message]()
        //Observe single event after loading every message from feed array
        REF_FEED.observeSingleEvent(of: .value) { (feedMessageSnapshot) in
            guard let feedMessageSnapshot = feedMessageSnapshot.children.allObjects as? [DataSnapshot] else { return }
            
            //going to cycle through the FirDataSnapshot array and store all the messages in Message array
            for message in feedMessageSnapshot {
                // The string "content" is a reference to what the name of the data section in firebase is called
                let content = message.childSnapshot(forPath: "content").value as! String
                let senderId = message.childSnapshot(forPath: "senderId").value as! String
                let message = Message(content: content, senderId: senderId)
                messageArray.append(message)
            }
            handler(messageArray)
        }
    }
}
