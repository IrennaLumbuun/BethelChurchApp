//
//  DukunganDoaViewController.swift
//  JCR3
//
//  Created by Irenna Nicole on 26/07/20.
//  Copyright © 2020 Irenna Lumbuun. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class DukunganDoaViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pageControl.numberOfPages = 2
        setupScreens()
        scrollView.delegate = self
    }
    
    struct userInfo{
        var gender = ""
        var age = -1
        var problem = ""
    }
    
    var user = userInfo()
    
    func setScreen1(frame: CGRect) {
        let vertStack  = UIStackView(frame: frame)
        
        //greeting
        let shalomLbl = UILabel(frame: CGRect(x: 20, y: 20, width: self.view.frame.width, height: 40))
        shalomLbl.text = "Shalom! \(Auth.auth().currentUser!.displayName!)"
        vertStack.addSubview(shalomLbl)
        
        //message
        let messageLbl = UILabel(frame: CGRect(x: 20, y: shalomLbl.frame.height + 20, width: self.view.frame.width - 40, height: 60))
        messageLbl.text = "Bantu kami untuk sebutkan jenis kelamin dan usia Anda."
        messageLbl.numberOfLines = 0
        vertStack.addSubview(messageLbl)
        
        //gender btn
        let maleBtn = UIButton(frame: CGRect(x: 20, y: shalomLbl.frame.height + messageLbl.frame.height + 20, width: 100, height: 100))
        maleBtn.setTitle("Male", for: .normal)
        maleBtn.tag = 0
        maleBtn.backgroundColor = UIColor.blue
        maleBtn.isUserInteractionEnabled = true
        maleBtn.addTarget(self, action: #selector(self.btnGenderClicked), for: UIControl.Event.touchUpInside)
        
        let femaleBtn = UIButton(frame: CGRect(x: 150, y: shalomLbl.frame.height + messageLbl.frame.height + 20, width: 100, height: 100))
        femaleBtn.addTarget(self, action: #selector(self.btnGenderClicked), for: UIControl.Event.touchUpInside)
        femaleBtn.tag = 1
        femaleBtn.setTitle("Female", for: .normal)
        femaleBtn.isUserInteractionEnabled = true
        femaleBtn.backgroundColor = UIColor.red
        
        vertStack.addSubview(maleBtn)
        vertStack.addSubview(femaleBtn)
        
        //Age
        let ageTxt = UITextField(frame: CGRect(x: 20, y: shalomLbl.frame.height + messageLbl.frame.height + 160, width: self.view.frame.width - 40, height: 40))
        ageTxt.placeholder = "Usia"
        ageTxt.addTarget(self, action: #selector(self.ageTextFieldDidChange(_:)), for: .editingChanged)
        vertStack.addSubview(ageTxt)
        
        self.scrollView.addSubview(vertStack)
    }
    @objc func ageTextFieldDidChange(_ textField: UITextField) {
        user.age = Int(textField.text!) ?? -1
        if user.age == -1 {
            print("error user age")
        }
    }
    
    @objc func btnGenderClicked(sender : UIButton) {
        //get buttonName
        let btnTag = sender.tag
        print(btnTag)

        if btnTag == 0 {
            print("male")
            user.gender = "Pria"
        } else if btnTag == 1 {
            print("female")
            user.gender = "Wanita"
        }
    }
    
    func setScreen2(frame: CGRect) {
        let vertStack  = UIStackView(frame: frame)
            
        //greeting
        let shalomLbl = UILabel(frame: CGRect(x: 20, y: 20, width: self.view.frame.width, height: 40))
        shalomLbl.text = "Shalom! \(Auth.auth().currentUser!.displayName!)"
        vertStack.addSubview(shalomLbl)
            
        //message
        let messageLbl = UILabel(frame: CGRect(x: 20, y: shalomLbl.frame.height + 20, width: self.view.frame.width - 40, height: 60))
        messageLbl.text = "Bantu kami untuk jelaskan apa yang rindu kami bantu dalam doa. Tuhan Yesus Memberkati"
        messageLbl.numberOfLines = 0
        vertStack.addSubview(messageLbl)
        
        //Masalah singkat
        let masalahTxt = UITextField(frame: CGRect(x: 20, y: shalomLbl.frame.height + messageLbl.frame.height + 40, width: self.view.frame.width - 40, height: 120))
        masalahTxt.placeholder = "Masalah singkat Anda"
        masalahTxt.addTarget(self, action: #selector(self.masalahTextFieldDidChange(_:)), for: .editingChanged)
        vertStack.addSubview(masalahTxt)
        
        //btn simpan
        let simpanBtn = UIButton(frame: CGRect(x: (self.view.frame.width / 2) - 100, y: shalomLbl.frame.height + messageLbl.frame.height + masalahTxt.frame.height + 40, width: 200, height: 40))
        simpanBtn.addTarget(self, action: #selector(self.simpanBtnClicked), for: UIControl.Event.touchUpInside)
        simpanBtn.setTitle("Simpan", for: .normal)
        simpanBtn.isUserInteractionEnabled = true
        simpanBtn.backgroundColor = UIColor.orange
        vertStack.addSubview(simpanBtn)
        
        self.scrollView.addSubview(vertStack)
    }
    
    @objc func masalahTextFieldDidChange(_ textField: UITextField) {
        user.problem = textField.text!
        print(user.problem)
    }
    
    @objc func simpanBtnClicked(sender : UIButton) {
        let uuid = Auth.auth().currentUser?.uid
        Database.database().reference().child("User/\(uuid!)").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let data = snapshot.value as? NSDictionary
            let idAccount = data?["IDAccount"]!
            let doaId = "DOA\(Utilities.getFormattedDate(desiredFormat: "ddMMyyHHmm"))\(idAccount!)"
            
            let field = [doaId: "[doaId, \(Auth.auth().currentUser!.displayName!), \(self.user.age) tahun, \(self.user.gender), \(self.user.problem), \(Utilities.getFormattedDate(desiredFormat: "yyyy-MM-dd hh:mm")), pending, noname]"]
            Database.database().reference().child("DukunganList/Dukdok").setValue(field)
        }) {(error) in
                print("error")
                print(error.localizedDescription)
            }
    }
    
    func setupScreens() {
        var frame = CGRect.zero
        for index in 0..<2 {
            // set up frame
            frame.origin.x = scrollView.frame.size.width * CGFloat(index)
            frame.origin.y = 20
            frame.size = scrollView.frame.size
            
            // inside frame
            if index == 0 {
                setScreen1(frame: frame)
            } else {
                setScreen2(frame: frame)
            }
        }

        // set up content size
        scrollView.contentSize = CGSize(width: (scrollView.frame.size.width * 2), height: self.view.frame.height - pageControl.frame.height)
        scrollView.delegate = self
    }
    
    // called after scroll view end decelerating
    // it tells us which page we're at
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
        pageControl.currentPage = Int(pageNumber)
    }

}
