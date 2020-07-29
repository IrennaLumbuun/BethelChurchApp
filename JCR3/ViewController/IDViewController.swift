//
//  IDViewController.swift
//  JCR3
//
//  Created by Irenna Nicole on 26/07/20.
//  Copyright © 2020 Irenna Lumbuun. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class IDViewController: UIViewController {

    @IBOutlet weak var NavBar: UINavigationBar!
    @IBOutlet weak var horizontalStack: UIStackView!
    @IBOutlet weak var verticalStack: UIStackView!
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var accountIdLbl: UILabel!
    @IBOutlet weak var namaLbl: UILabel!
    @IBOutlet weak var qrCodeImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        // Do any additional setup after loading the view.
    }
    
    func setup(){
        instantiateBadge()
        styleItem()
    }
    func styleItem(){
        verticalStack.frame = CGRect(x: 20, y: 20, width: view.frame.width, height: view.frame.height / 4)
        namaLbl.textColor = UIColor.white
        accountIdLbl.textColor = UIColor.white
        
        //resize images
        let profilePicWidth = self.view.frame.width / 4
        let y = 20 + NavBar.frame.height
        self.profilePic.frame = CGRect(x:20, y: y, width: profilePicWidth, height: profilePicWidth)
    }
    
    func instantiateBadge(){
        let uuid = Auth.auth().currentUser?.uid
        Database.database().reference().child("Account/\(String(describing: uuid))").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let data = snapshot.value as? NSDictionary
            let nama = data?["Name"] as? String ?? "Jane Doe"
            let jcId = data?["IDAccount"] as? String ?? "JCR1234"
            self.namaLbl.text = nama
            self.accountIdLbl.text = jcId
            
            //set QR code
            let qrcode = self.generateQRCode(from: jcId)
            self.qrCodeImg.image = qrcode
            self.profilePic.image =  qrcode // TODO: change later!!
        }) {(error) in
                print("error")
                print(error.localizedDescription)
            }
    }
    
    // thanks to https://www.hackingwithswift.com/example-code/media/how-to-create-a-qr-code
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)

        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)

            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }

        return nil
    }

}
