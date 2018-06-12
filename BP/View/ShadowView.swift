//
//  ShadowView.swift
//  BP
//
//  Created by Nessin Elkharrat on 5/28/18.
//  Copyright © 2018 practice. All rights reserved.
//

import UIKit

class ShadowView: UIView {
    
    override func awakeFromNib() {
        self.layer.shadowOpacity = 0.75
        self.layer.shadowRadius = 5
        self.layer.shadowColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
        
        super.awakeFromNib()
    }

}
