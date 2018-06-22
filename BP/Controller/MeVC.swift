//
//  MeVC.swift
//  BP
//
//  Created by Nessin Elkharrat on 5/31/18.
//  Copyright © 2018 practice. All rights reserved.
//

import UIKit
import Firebase

class MeVC: UIViewController {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.emailLbl.text = Auth.auth().currentUser?.email

    }
    
    //actionsheet is log out styled pop up screen
    @IBAction func signOutButtonWasPressed(_ sender: Any) {
        let logOutPopUp = UIAlertController(title: "Log out?", message: "Are you sure you want to log out?", preferredStyle: .actionSheet)
        let logOutAction = UIAlertAction(title: "Log out??", style: .destructive) { (buttonTapped) in
            
            do {
               try Auth.auth().signOut()
                let authVC = self.storyboard?.instantiateViewController(withIdentifier: "AuthVC") as? AuthVC
                self.present(authVC!, animated: true, completion: nil)
            } catch {
                //do catch block automatically catches a variable called error and can present it by using print
                print(error)
            }
        }
        logOutPopUp.addAction(logOutAction)
        present(logOutPopUp, animated: true, completion: nil)
    }
}
