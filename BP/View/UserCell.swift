//
//  UserCell.swift
//  BP
//
//  Created by Nessin Elkharrat on 6/22/18.
//  Copyright © 2018 practice. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var checkImage: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    
    //Variables
    var showing  = false
    
    func configureCell(profileImage image: UIImage, email: String, isSelected: Bool) {
        self.profileImage.image = image
        self.emailLbl.text = email
        
        if isSelected {
            self.checkImage.isHidden = false
        } else {
            self.checkImage.isHidden = true
        }
    }
    
    // Configure the view for the selected state
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            if showing == false {
                checkImage.isHidden = false
                showing = true
            
            } else {
                checkImage.isHidden = true
                showing = false
            }
        }
    }

}
