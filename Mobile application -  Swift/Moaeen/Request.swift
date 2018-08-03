//
//  ViewController.swift
//  Moaeen
//
//  Created by Hussam Aldin on 01/08/2018.
//  Copyright © 2018 hakathon. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase



class Request: UIViewController {

    var ref: DatabaseReference!
    
    @IBOutlet weak var Desc: UITextView!
    
    @IBOutlet weak var isUrgent: UISwitch!
    
    var request = helpRequest()
    
    @IBOutlet weak var SubmitRequest: UIButton!
    
    @IBAction func SubmitRequest(_ sender: Any) {
        
        self.ref = Database.database().reference()
        
        let uid = Auth.auth().currentUser?.uid
        let requestRef = self.ref.child("Request").childByAutoId()
    
        
        var values = [ String : Any]()
        values["uId"]          = uid
        values["hajjNumber"]   =  Auth.auth().currentUser?.phoneNumber
        values["ProblemDesc"]  =  Desc.text
        values["latitude"]     =   request.latitude
        values["longitude"]    = request.longitude
        values["isUrgent"]     = isUrgent.isOn
        
        
        requestRef.setValue (values)
        
        performSegue(withIdentifier: "finishRequest", sender: self)
        
    }
    
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Desc.placeholderText = "الرجاء اكتب هنا وصف مشكلتك باختصار"
   //     Desc.placeholderColor = UIColor.lightGray // optional
      //  Desc.attributedPlaceholder = ...

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

struct helpRequest {
    
    
    var hajjNumber: Int?
    var hajjName: String?
    var ProblemDesc: String?
    var latitude: String?
    var longitude: String?
    var isUrgent: Bool?
    
     init( hajjNumber : Int?  = nil,
     hajjName : String? = nil,
     ProblemDesc : String? = nil,
     latitude : String? = nil,
     longitude : String? = nil,
      isUrgent : Bool? = nil )
     {
        
        self.hajjNumber = hajjNumber
        self.hajjName = hajjName
        self.ProblemDesc = ProblemDesc
        self.latitude = latitude
        self.longitude = longitude
        self.isUrgent = isUrgent
    }
    
  

}



