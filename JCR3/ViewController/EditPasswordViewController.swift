//
//  EditPasswordViewController.swift
//  JCR3
//
//  Created by Irenna Nicole on 01/08/20.
//  Copyright © 2020 Irenna Lumbuun. All rights reserved.
//

import UIKit
import FirebaseAuth

class EditPasswordViewController: UIViewController {

    @IBOutlet weak var popUpVertical: UIStackView!
    @IBOutlet weak var tutupBtn: UIBarButtonItem!
    @IBOutlet weak var passwordBaruTxt: UITextField!
    @IBOutlet weak var konfirmPasswordTxt: UITextField!
    @IBOutlet weak var simpanPasswordBtn: UIButton!
    @IBOutlet weak var errorLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stylePopup()
    }
    
    func setup() {
        // do styling and whatnot
    }
    
    func stylePopup() {
        
        let stackHeight = popUpVertical.frame.height
        self.popUpVertical.frame = CGRect(x: 20, y: (self.view.frame.height - stackHeight) / 2, width: self.view.frame.width - 40, height: stackHeight)
    }
    
    func isPasswordMatch() -> Bool{
        let pass =  passwordBaruTxt.text
        let passKonfirm = konfirmPasswordTxt.text
        if pass != passKonfirm {
            errorLbl.alpha = 1
            errorLbl.text = "Password dan Konfirmasi harus sama."
            return false
        }
        errorLbl.alpha = 0
        return true
    }
    func closePopUp(){
        let profileVC = storyboard?.instantiateViewController(identifier: Constants.Storyboard.userProfileViewController) as? UserProfileViewController
        
        view.window?.rootViewController = profileVC
        view.window?.makeKeyAndVisible()
    }
    
    @IBAction func tutupBtnTapped(_ sender: Any) {
        closePopUp()
        
    }
    @IBAction func simpanBtnTapped(_ sender: Any) {
        //check both text field
        let pass =  passwordBaruTxt.text
        let passKonfirm = konfirmPasswordTxt.text
        
        if pass == "" || passKonfirm == "" {
        errorLbl.text = "Isi  password baru dan konfirmasi password"
        errorLbl.alpha = 1
        }
        
        //if match, change password
        if isPasswordMatch() {
            Auth.auth().currentUser?.updatePassword(to: pass!) { (error) in
                if error != nil{
                    self.errorLbl.text = error?.localizedDescription
                    self.errorLbl.alpha = 1
                }
                else {
                    self.closePopUp()
                }
            }
        }
    }
    
}
