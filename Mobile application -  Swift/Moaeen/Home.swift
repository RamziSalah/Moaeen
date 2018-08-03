//
//  ViewController.swift
//  Moaeen
//
//  Created by Hussam Aldin on 01/08/2018.
//  Copyright © 2018 hakathon. All rights reserved.
//

import UIKit
import Firebase



class Home: UIViewController {

    
    @IBAction func logOut(_ sender: Any) {
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "StartUp") as! StartUp
        self.present(vc, animated: false, completion: nil)
        
    }
    
    @IBAction func DoctoerNeeds(_ sender: Any) {
        
         self.performSegue(withIdentifier: "open_map", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

