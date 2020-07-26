//
//  DaftarViewController.swift
//  JCR3
//
//  Created by Irenna Nicole on 25/07/20.
//  Copyright © 2020 Irenna Lumbuun. All rights reserved.
//

import UIKit
import FirebaseAuth

class DaftarViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var namaTxt: UITextField!
    @IBOutlet weak var gerejaPicker: UIPickerView!
    @IBOutlet weak var coolPicker: UIPickerView!
    @IBOutlet weak var errorLbl: UILabel!
    
    var pickerData: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) ->Int {
        return pickerData.count
    }
    // The data to return fopr the row and component (column) that's being passed in
      func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
          return pickerData[row]
      }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
        print("component: \(component)")
        print("row: \(row)")
    }
    
    func setup(){
        errorLbl.alpha = 0
        Utilities.initiateBackground(imageName: "welcome.jpg", view: self)
        
        self.gerejaPicker.delegate = self
        self.gerejaPicker.dataSource = self
        pickerData = ["a", "b", "c"]
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
        } else {
            let email = "111@111.com"
            let password = "000000"
            
            Auth.auth().createUser(withEmail: email, password: password) { (success, error) in
                if error != nil {
                    self.errorLbl.text = error?.localizedDescription
                    self.errorLbl.alpha = 1
                } else {
                    print("AuthDataResult = \(String(describing: success))")
                    self.transitionToHome()
                }
            }
        }
    }
    func transitionToHome(){
        let homeVC = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        view.window?.rootViewController = homeVC
        view.window?.makeKeyAndVisible()
    }
}
