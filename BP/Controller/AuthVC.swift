//
//  AuthVC.swift
//  BP
//
//  Created by Nessin Elkharrat on 5/28/18.
//  Copyright © 2018 practice. All rights reserved.
//

//This VC has a storyboard ID and will be called upon in other VCs


import UIKit
import Firebase

class AuthVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //Want the first thing to be done is to call all the messages and put them in an array
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Auth.auth().currentUser != nil {
            //if user logged in, dismiss the VC
            dismiss(animated: true, completion: nil)
        }
    }

    @IBAction func signInWithEmailBtnWasPressed(_ sender: Any) {
        let loginVC = storyboard?.instantiateViewController(withIdentifier: "LoginVC")
        present(loginVC!, animated: true, completion: nil)
    }
    
    @IBAction func facebookSignInBtnWasPressed(_ sender: Any) {
    }
    
    @IBAction func googleSignInBtnWasPressed(_ sender: Any) {
    }
}
