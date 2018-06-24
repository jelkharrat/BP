//
//  CreateGroupsVC.swift
//  BP
//
//  Created by Nessin Elkharrat on 6/21/18.
//  Copyright © 2018 practice. All rights reserved.
//

import UIKit

class CreateGroupsVC: UIViewController {
    
    @IBOutlet weak var titleTextField: InsetTextField!
    @IBOutlet weak var descriptionTextField: InsetTextField!
    @IBOutlet weak var emailSearchTextField: InsetTextField!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var groupMemberLbl: UILabel!
    
    var emailArray = [String]()
    //holds all the people we chose to be in our group
    var chosenUserArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        emailSearchTextField.delegate = self
        //monitors what is happening in the textfield. If i type in a word it will edit the selection for me
        emailSearchTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        doneButton.isHidden = true
    }
    //if empty, empty the array. if contains characters, does a search
    @objc func textFieldDidChange() {
        if emailSearchTextField.text == "" {
            emailArray = []
            tableView.reloadData()
            
        } else {
            DataService.instance.getEmail(forSearchQuery: emailSearchTextField.text!, handler: { (returnedEmailArray) in
                self.emailArray = returnedEmailArray
                self.tableView.reloadData()
            })
        }
    }
    
    @IBAction func doneBtnWasPressed(_ sender: Any) {
    }
    
    @IBAction func closeBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}


extension CreateGroupsVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "userCell") as? UserCell else { return UITableViewCell() }
        
        let profileImage = UIImage(named: "defaultProfileImage")
        
        //making sure all cells in tableview start off as not selected
        if chosenUserArray.contains(emailArray[indexPath.row]) {
            cell.configureCell(profileImage: profileImage!, email: emailArray[indexPath.row], isSelected: true)
        } else {
            cell.configureCell(profileImage: profileImage!, email: emailArray[indexPath.row], isSelected: false)
        }
        return cell
    }
    
    //called when a tableview cell is selected at a certain index path
    //creating temporary array to list all the poeple in the group
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //need to first create a cell
        guard let cell = tableView.cellForRow(at: indexPath) as? UserCell else { return }
        //! means not. so checking to see if user array is NOT there
        if !chosenUserArray.contains(cell.emailLbl.text!) {
            chosenUserArray.append(cell.emailLbl.text!)
            //adding comma and a space
            groupMemberLbl.text = chosenUserArray.joined(separator: ", ")
            doneButton.isHidden = false

        } else {
            // $0 means everything. We are filtering everything that is not the current email because it currently exists in the array
            chosenUserArray = chosenUserArray.filter({ $0 != cell.emailLbl.text })
            
            //check to see greater or = to one should show name but if less than 1 then show add people to group
            if chosenUserArray.count >= 1 {
                groupMemberLbl.text = chosenUserArray.joined(separator: ", ")
            } else {
                groupMemberLbl.text = "Add people to your group"
                doneButton.isHidden = true

            }
        }
    }
}

extension CreateGroupsVC: UITextFieldDelegate {
    
}
