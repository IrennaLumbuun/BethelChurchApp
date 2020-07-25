//
//  Utilities.swift
//  JCR3
//
//  Created by Irenna Nicole on 24/07/20.
//  Copyright © 2020 Irenna Lumbuun. All rights reserved.
//

import Foundation
import UIKit

class Utilities{
    
    //TODO: check regex.
    /**
         - Password has to be at least 8 characters
         - Contains a character, a number, a special character
     */
    static func isAStrongPassword(password: String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@",
            "^(?=.*[a-z])(?=.*[$@$#!%*?&])(A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with:password)
    }
    
    static func styleButton(btn: UIButton){
        btn.layer.cornerRadius = 10
    }
    // TODO: check phoneNumber
}
