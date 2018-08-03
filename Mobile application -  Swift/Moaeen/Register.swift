//
//  ViewController.swift
//  ActionYaMalaab
//
//  Created by Hussam Aldin on 27/06/2018.
//  Copyright © 2018 Hussam Aldin. All rights reserved.
//

import UIKit
import MaterialComponents
import ImagePicker
import Firebase
import FirebaseDatabase
import Validator
import NVActivityIndicatorView

class Register: UIViewController  {
    
    //https://goo.gl/AFCj2H
   
    @IBOutlet weak var CountryCode: MDCTextField!
    
    @IBOutlet weak var UserMobile: MDCTextField!
    
    @IBOutlet weak var FisrtName: MDCTextField!
    
     @IBOutlet weak var LastName: MDCTextField!
    
     @IBOutlet weak var Email: MDCTextField!
    
    var CountryCodeController: MDCTextInputControllerUnderline?
    
    var UserMobileController: MDCTextInputControllerUnderline?
    
    var FisrtNameController: MDCTextInputControllerUnderline?
    
    var LastNameController: MDCTextInputControllerUnderline?
    
    var EmailController: MDCTextInputControllerUnderline?
    
     var ref: DatabaseReference!
    
    @IBOutlet weak var PlayerImage: UIImageView!
    
    @IBOutlet weak var Confirm: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
         setupUI()
        
        if let phone = Auth.auth().currentUser?.phoneNumber {
            
            UserMobile.text = String(phone.suffix(9))
        }
        
      
        
        
    }
    
   
    
    @IBAction func Confirm(_ sender: Any) {
        
        
        
    }
   


    func setupUI()  {
    
      
//        
//        CountryCodeController = MDCTextInputControllerUnderline(textInput: CountryCode)
//        UserMobileController = MDCTextInputControllerUnderline(textInput: UserMobile)
//        FisrtNameController = MDCTextInputControllerUnderline(textInput: FisrtName)
//        LastNameController = MDCTextInputControllerUnderline(textInput: LastName)
//        EmailController = MDCTextInputControllerUnderline(textInput: Email)
//    
//        
//        CountryCodeController?.normalColor = UIColor(rgb: 0x67AC5D)
//        CountryCodeController?.inlinePlaceholderColor = UIColor.white
//        CountryCodeController?.activeColor = UIColor(rgb: 0x67AC5D)
//        CountryCodeController?.isFloatingEnabled = false
//        
//        UserMobileController?.normalColor = UIColor(rgb: 0x67AC5D)
//        UserMobileController?.inlinePlaceholderColor = UIColor.white
//        UserMobileController?.activeColor = UIColor(rgb: 0x67AC5D)
//        UserMobileController?.floatingPlaceholderActiveColor = UIColor.white
//        UserMobileController?.isFloatingEnabled = false
//        
//        FisrtNameController?.normalColor = UIColor(rgb: 0x67AC5D)
//        FisrtNameController?.inlinePlaceholderColor = UIColor.white
//        FisrtNameController?.activeColor = UIColor(rgb: 0x67AC5D)
//        FisrtNameController?.floatingPlaceholderActiveColor = UIColor.white
//        FisrtNameController?.isFloatingEnabled = false
//        //FisrtNameController?.accessibilityAttributedLabel.
//        
//        LastNameController?.normalColor = UIColor(rgb: 0x67AC5D)
//        LastNameController?.inlinePlaceholderColor = UIColor.white
//        LastNameController?.activeColor = UIColor(rgb: 0x67AC5D)
//        LastNameController?.floatingPlaceholderActiveColor = UIColor.white
//        LastNameController?.isFloatingEnabled = false
//        
//        
//        EmailController?.normalColor = UIColor(rgb: 0x67AC5D)
//        EmailController?.inlinePlaceholderColor = UIColor.white
//        EmailController?.activeColor = UIColor(rgb: 0x67AC5D)
//        EmailController?.floatingPlaceholderActiveColor = UIColor.white
//        
//        EmailController?.isFloatingEnabled = false
    }
}

