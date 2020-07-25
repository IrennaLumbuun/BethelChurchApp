//
//  LogInViewController.swift
//  JCR3
//
//  Created by Irenna Nicole on 23/07/20.
//  Copyright © 2020 Irenna Lumbuun. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {

    @IBOutlet weak var phoneNumberTxt: UITextField!
    
    @IBOutlet weak var passwordTxt: UITextField!
    
    @IBOutlet weak var masukBtn: UIButton!
    
    @IBOutlet weak var errorLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    func setUpElements(){
        errorLbl.alpha = 0
        // TODO: style other elements?
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    //check 22:16 for form styling (Coding with Chris)
    @IBAction func masukBtnTapped(_ sender: Any) {
    }
}
