//
//  ViewController.swift
//  ActionYaMalaab
//
//  Created by Hussam Aldin on 27/06/2018.
//  Copyright © 2018 Hussam Aldin. All rights reserved.
//

import UIKit
import MaterialComponents
import FirebaseAuth
import Validator
import NVActivityIndicatorView
import FirebaseDatabase



class CheckPhone: UIViewController {

    @IBOutlet weak var Name: MDCTextField!
    
    @IBOutlet weak var UserMobile: MDCTextField!
    
    @IBOutlet weak var ActiveCode: MDCTextField!
    
    var NameController: MDCTextInputControllerUnderline?
    
    var UserMobileController: MDCTextInputControllerUnderline?
    
    var ActiveCodeController: MDCTextInputControllerUnderline?
    
    var ref: DatabaseReference!
    
    
    
    @IBOutlet weak var Confirm: UIButton!
    
    
    enum ValidationErrors: String, Error {
        case PhoneValid = "رقم الجوال غير صحيح"
        var message: String { return self.rawValue }
    }
    
    enum ValidationErrors2: String, Error {
        case PhoneValid = "الرجاء ادخال رمز التحقق  المكون من ٦ ارقام"
        var message: String { return self.rawValue }
    }
    

    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        self.navigationController?.navigationBar.isHidden = false
//
//    }
  
    
    override func viewWillAppear(_ animated: Bool) {
        //  super.viewWillAppear(false)
        self.navigationController?.navigationBar.isHidden = true
      
        
        ref = Database.database().reference()
        
        
        if Auth.auth().currentUser != nil {
            
            
            self.performSegue(withIdentifier: "LogInToHome", sender: self)
        }
        
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
       ref = Database.database().reference()
        
        NameController = MDCTextInputControllerUnderline(textInput: Name)
        UserMobileController = MDCTextInputControllerUnderline(textInput: UserMobile)
        ActiveCodeController = MDCTextInputControllerUnderline(textInput: ActiveCode)

        
        Name.leftViewMode = .always
        
        let NameView = UIView (frame: CGRect(x: 0, y: 0, width: 25, height: 20))
        let NameView2 = UIImageView (frame: CGRect(x: 5, y: 0, width: 20, height: 20))
        NameView2.image = UIImage(named: "Group 10")
        NameView.addSubview(NameView2)
        
        Name.leftView = NameView
    
        
        
        UserMobile.leftViewMode = .always
        
        let UserMobileView = UIView (frame: CGRect(x: 0, y: 0, width: 25, height: 20))
        let UserMobileView2 = UIImageView (frame: CGRect(x: 5, y: 0, width: 20, height: 20))
        UserMobileView2.image = UIImage(named: "Path 980")
        UserMobileView.addSubview(UserMobileView2)
     
        UserMobile.leftView = UserMobileView
        
           NameController?.normalColor = UIColor(rgb: 0x1D3A5C)
           NameController?.inlinePlaceholderColor = UIColor.black
           NameController?.activeColor = UIColor(rgb: 0x1D3A5C)
           NameController?.floatingPlaceholderActiveColor = UIColor.black
        
            UserMobileController?.normalColor = UIColor(rgb: 0x1D3A5C)
            UserMobileController?.inlinePlaceholderColor = UIColor.black
            UserMobileController?.activeColor = UIColor(rgb: 0x1D3A5C)
            UserMobileController?.floatingPlaceholderActiveColor = UIColor.black
        
        
           ActiveCodeController?.normalColor = UIColor(rgb: 0x1D3A5C)
           ActiveCodeController?.inlinePlaceholderColor = UIColor.black
           ActiveCodeController?.activeColor = UIColor(rgb: 0x1D3A5C)
           ActiveCodeController?.floatingPlaceholderActiveColor = UIColor.black
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func Confirm(_ sender: Any) {
        
        Auth.auth().languageCode = "ar";
        
        if (ActiveCode.isHidden){
            
            let rule = ValidationRuleLength(min: 13, max: 13, error: ValidationErrors.PhoneValid )
            
            let result = UserMobile.validate(rule: rule)
            
            switch result {
            case .valid: do {
                
                UserMobileController?.setErrorText(nil, errorAccessibilityValue: nil)
                
                let activityData = ActivityData()
                
                NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData, nil)
                
                PhoneAuthProvider.provider().verifyPhoneNumber("\(UserMobile.text!)" , uiDelegate: nil) { (verificationID, error) in
                    
                    NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
                    
                    if let error = error {
                        
                        self.displayMsg(title: "هناك خطأ ما", msg: error.localizedDescription, style: .alert, dontRemindKey: nil)
                        print(error.localizedDescription)
                        return
                    }
                    
                    UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
                    self.ActiveCode.isHidden = false
                }
                
                
                }
            case .invalid( _): UserMobileController?.setErrorText(ValidationErrors.PhoneValid.rawValue, errorAccessibilityValue: nil)
            }
            
            
            
            
            
        }else {
            
            let verificationID = UserDefaults.standard.string(forKey: "authVerificationID")
            
            let rule = ValidationRuleLength(min: 6, max: 6,error: ValidationErrors2.PhoneValid )
            
            let result = ActiveCode.validate(rule: rule)
            
            switch result {
            case .valid: do {
                
                ActiveCodeController?.setErrorText(nil, errorAccessibilityValue: nil)
                
                let credential = PhoneAuthProvider.provider().credential(
                    withVerificationID: verificationID!,
                    verificationCode: ActiveCode.text!)
                
                let activityData = ActivityData()
                
                NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData, nil)
                
                Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
                    
                    NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
                    
                    if let error = error {
                        self.displayMsg(title: "هناك خطأ ما", msg: error.localizedDescription, style: .alert, dontRemindKey: nil)
                        
                        print(error.localizedDescription)
                        
                        return
                    }
                    
                    //  print("succed Log In \(authResult?.user)")
                    let isHajj = true
                    if (isHajj) {
                    
                     self.performSegue(withIdentifier: "LogInTohajjHome", sender: self)
                    } else {
                        
                     self.performSegue(withIdentifier: "LogInToVHome", sender: self)
                        
                    }
//                    self.ref.child("users/\(String(describing: (authResult?.user.uid)!))").observeSingleEvent(of: .value, with: { (snapshot) in
//                        if snapshot.exists(){
//
//                            self.performSegue(withIdentifier: "LogInToHome", sender: self)
//                        }else{
//
//                            self.performSegue(withIdentifier: "goRegister", sender: self)
//                        }
//                    })
                }
                }
                
            case .invalid( _): ActiveCodeController?.setErrorText(ValidationErrors2.PhoneValid.rawValue, errorAccessibilityValue: nil)
            }
        }
        
        
    }

}

