//
//  FirbaseOp.swift
//  ActionYaMalaab
//
//  Created by Hussam Aldin on 26/07/2018.
//  Copyright © 2018 Hussam Aldin. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class FirbaseOp  {
    
      var ref: DatabaseReference!
  
    func update_User (
                      appUserId :Bool?,
                      createdDate :Int?,
                      email :String? ,
                      fName :String?,
                      isActive :Bool? ,
                      lName :String?,
                      latitude:Float?,
                      loggedInMode :Int?,
                      longitude:Float?,
                      mobileNo: String? ,
                      modifyDate: Int? ,
                      noOfBookings: Int? ,
                      password: String? ,
                      referred_by:String? ,
                      role: String? ,
                      uId: String? )    {
        
        self.ref = Database.database().reference()
        
        let uid = Auth.auth().currentUser?.uid
        let CaptainRef = self.ref.child("users").child(uid!)
        
        var values = [ String : Any]()
        values["uId"] = uid
        values["role"] = "captain"
        
       
        if appUserId != nil {
       
            values["appUserId"] = ""
        }
        
        if let fName = fName {
    
            values["fName"] = fName
        }
         if let lName = lName {
    
             values["lName"] = lName
        }
        
        if let email = email {
        
             values["email"] = email
        }
        
        if let createdDate = createdDate {
        
             values["createdDate"] = createdDate
        }
        
        if let mobileNo = mobileNo {
          
             values["mobileNo"] = mobileNo
        }
      
         CaptainRef.setValue (values)
    
        }
    
    
}



