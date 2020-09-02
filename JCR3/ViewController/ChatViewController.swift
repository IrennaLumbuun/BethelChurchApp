//
//  ChatViewController.swift
//  JCR3
//
//  Created by Irenna Nicole on 01/09/20.
//  Copyright © 2020 Irenna Lumbuun. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {
    @IBOutlet weak var NavBar: UINavigationBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        print(NavBar.isHidden)
    }
    override func viewWillAppear(_ animated: Bool) {
        if self.navigationController != nil {
            print("set true")
            NavBar.isHidden = true
        }
        print(NavBar.isHidden)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
