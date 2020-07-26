//
//  DaftarViewController.swift
//  JCR3
//
//  Created by Irenna Nicole on 25/07/20.
//  Copyright © 2020 Irenna Lumbuun. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class DaftarViewController: UIViewController {

    @IBOutlet weak var namaTxt: UITextField!
    @IBOutlet weak var errorLbl: UILabel!
    
    var pickerData: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()

        // Do any additional setup after loading the view.
    }

    func setup(){
        errorLbl.alpha = 0
        Utilities.initiateBackground(imageName: "welcome.jpg", view: self)
    }
    
    func validateFields() -> String? {
        if namaTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Semua textbox harus diisi"
        }
        return nil
    }
    
    //check 56:40
    @IBAction func simpanBtn(_ sender: Any) {
        let error = validateFields()
        if error != nil {
            errorLbl.text = error
            errorLbl.alpha = 1
        } else{
            storeUserToDatabase()
            self.transitionToHome()
            }
        }
    
    func transitionToHome(){
        let homeVC = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        view.window?.rootViewController = homeVC
        view.window?.makeKeyAndVisible()
    }
    
    func storeUserToDatabase(){
        let ref = Database.database().reference()
        
        let name = namaTxt.text
        let userID = Auth.auth().currentUser!.uid
        let userEmail = Auth.auth().currentUser!.email
        let userPhone = Auth.auth().currentUser!.phoneNumber
        let field = ["Email" : userEmail, "Role": "Jemaat", "Number": userPhone, "Name": name, "Uid": userID]
        ref.child("Account/\(userID)").setValue(field)
    }
}
