//
//  ViewController.swift
//  ActionYaMalaab
//
//  Created by Hussam Aldin on 27/06/2018.
//  Copyright © 2018 Hussam Aldin. All rights reserved.
//

import UIKit
import Firebase

class StartUp: UIViewController {
    
     var ref: DatabaseReference!
    
    override func viewWillAppear(_ animated: Bool) {
      //  super.viewWillAppear(false)
         self.navigationController?.navigationBar.isHidden = true
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
//        self.navigationController?.navigationBar.isTranslucent = true
//        self.navigationController?.view.backgroundColor = .clear
        
          ref = Database.database().reference()
        
        
        if Auth.auth().currentUser != nil {

            
            if (true) {
            self.performSegue(withIdentifier: "goToHajjHome", sender: self)
            } else {
                
             self.performSegue(withIdentifier: "goToVHome", sender: self)
            }
        }
        
  // self.performSegue(withIdentifier: "goToHajjHome", sender: self)
     
    }

    @IBAction func IamHajj(_ sender: Any) {
      
         self.performSegue(withIdentifier: "goToReg", sender: self)
    }
    
    @IBAction func IamVoulanteer(_ sender: Any) {
        
         self.performSegue(withIdentifier: "gotoVDirect", sender: self)
    }
    
    @IBOutlet weak var IamVolanteer: UIButton!
    
    @IBAction func Skip(_ sender: Any) {
        
         self.performSegue(withIdentifier: "toMenuScreen", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension UIViewController {
    func displayMsg(title : String?, msg : String,
                    style: UIAlertControllerStyle = .alert,
                    dontRemindKey : String? = nil) {
        if dontRemindKey != nil,
            UserDefaults.standard.bool(forKey: dontRemindKey!) == true {
            return
        }
        
        let ac = UIAlertController.init(title: title,
                                        message: msg, preferredStyle: style)
        ac.addAction(UIAlertAction.init(title: "OK",
                                        style: .default, handler: nil))
        
        if dontRemindKey != nil {
            ac.addAction(UIAlertAction.init(title: "Don't Remind",
                                            style: .default, handler: { (aa) in
                                                UserDefaults.standard.set(true, forKey: dontRemindKey!)
                                                UserDefaults.standard.synchronize()
            }))
        }
        DispatchQueue.main.async {
            self.present(ac, animated: true, completion: nil)
        }
    }
}

extension UINavigationBar {
    func transparentNavigationBar() {
        self.setBackgroundImage(UIImage(), for: .default)
        self.shadowImage = UIImage()
        self.isTranslucent = true
    }
}
