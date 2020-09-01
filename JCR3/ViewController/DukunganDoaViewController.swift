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

class DukunganDoaViewController: UIViewController, UIScrollViewDelegate, UITextViewDelegate {

    @IBOutlet weak var NavBar: UINavigationBar!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pageControl.numberOfPages = 2
        scrollView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        setupScreens()
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
        let shalomLbl = UILabel(frame: CGRect(x: 0, y: 20, width: self.view.frame.width, height: 40))
        shalomLbl.text = "Shalom! \(Auth.auth().currentUser!.displayName!)"
        shalomLbl.textAlignment = .center
        shalomLbl.textColor = UIColor(red: 67/255, green: 122/255, blue: 77/255, alpha: 1.0)
        shalomLbl.font = .systemFont(ofSize: 18)
        vertStack.addSubview(shalomLbl)
        
        //message
        let messageLbl = UILabel(frame: CGRect(x: 20, y: shalomLbl.frame.height + 20, width: self.view.frame.width - 40, height: 60))
        messageLbl.text = "Bantu kami untuk sebutkan jenis kelamin dan usia Anda."
        messageLbl.numberOfLines = 0
        messageLbl.textAlignment = .center
        messageLbl.font = .systemFont(ofSize: 14)
        vertStack.addSubview(messageLbl)
        
        //horizontal stack for button
        let horizontalStack = UIStackView(frame: CGRect(x: 20, y: shalomLbl.frame.height + messageLbl.frame.height + 40, width: self.view.frame.width - 40, height: 100))
        horizontalStack.axis = .horizontal
        horizontalStack.alignment = .fill
        horizontalStack.distribution = .fillEqually
        horizontalStack.spacing = 100
        
        //gender btn
        let maleBtn = UIButton(frame: CGRect(x: 20, y: shalomLbl.frame.height + messageLbl.frame.height + 40, width: 100, height: 100))
        maleBtn.tag = 0
        maleBtn.setImage(UIImage(named: "male"), for: .normal)
        maleBtn.isUserInteractionEnabled = true
        maleBtn.addTarget(self, action: #selector(self.btnGenderClicked), for: UIControl.Event.touchUpInside)
        
         Utilities.styleRectangularButton(btn: maleBtn)
        
        let femaleBtn = UIButton(frame: CGRect(x: 150, y: shalomLbl.frame.height + messageLbl.frame.height + 40, width: 100, height: 100))
        femaleBtn.addTarget(self, action: #selector(self.btnGenderClicked), for: UIControl.Event.touchUpInside)
        
        femaleBtn.tag = 1
        femaleBtn.isUserInteractionEnabled = true
        femaleBtn.setImage(UIImage(named:"female"), for: .normal)
        Utilities.styleRectangularButton(btn: femaleBtn)
        
        horizontalStack.addArrangedSubview(maleBtn)
        horizontalStack.addArrangedSubview(femaleBtn)
        
        vertStack.addSubview(horizontalStack)
        
        //Age
        let ageTxt = UITextField(frame: CGRect(x: 20, y: shalomLbl.frame.height + messageLbl.frame.height + 160, width: 100, height: 40))
        ageTxt.placeholder = "Usia"
        ageTxt.addTarget(self, action: #selector(self.ageTextFieldDidChange(_:)), for: .editingChanged)
        ageTxt.center.x = self.view.frame.width / 2
        ageTxt.textAlignment = .center
        
        ageTxt.backgroundColor = UIColor(red: 192, green: 192, blue: 192, alpha:1)
        ageTxt.textAlignment = .center
        ageTxt.layer.cornerRadius = 20
        ageTxt.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        ageTxt.layer.shadowOffset = CGSize(width: 0.0, height: 1)
        ageTxt.layer.shadowOpacity = 1.0
        ageTxt.layer.shadowRadius = 1.0
        ageTxt.layer.masksToBounds = false
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
        sender.isSelected = !sender.isSelected
        
        let selectedTitleInset = UIEdgeInsets(
            top: 62.5,
            left: -75,
            bottom: 0,
            right: 0
        )
        
        let selectedImageInset = UIEdgeInsets(
            top: 0.0,
            left: 10.0,
            bottom: 20.0,
            right: 0
        )
        let selectedContentInset = UIEdgeInsets(
            top: 0,
            left: 20,
            bottom: 0,
            right: 0
        )
        
        let originalInset = UIEdgeInsets(
            top: 0,
            left: 0,
            bottom: 0,
            right: 0
        )
        
        if btnTag == 0 {
            if(sender.isSelected) {
                user.gender = "Pria"
                sender.setTitle("Pria", for: .selected)
                sender.setTitleColor(UIColor.blue, for: .normal)
                sender.imageEdgeInsets = selectedImageInset
                sender.titleEdgeInsets = selectedTitleInset
                sender.contentEdgeInsets = selectedContentInset
            }
            else {
                user.gender = "Wanita"
                sender.imageEdgeInsets = originalInset
                sender.titleEdgeInsets = originalInset
                sender.contentEdgeInsets = originalInset
            }
        } else if btnTag == 1 {
            if(sender.isSelected) {
                user.gender = "Wanita"
                sender.setTitle("Wanita", for: .selected)
                sender.setTitleColor(UIColor.red, for: .normal)
                sender.imageEdgeInsets = selectedImageInset
                sender.titleEdgeInsets = selectedTitleInset
                sender.contentEdgeInsets = selectedContentInset
            }
            else {
                user.gender = "Pria"
                sender.imageEdgeInsets = originalInset
                sender.titleEdgeInsets = originalInset
                sender.contentEdgeInsets = originalInset
            }
        }
    }
    
    func setScreen2(frame: CGRect) {
        let vertStack  = UIStackView(frame: frame)
            
        //greeting
        let shalomLbl = UILabel(frame: CGRect(x: 0, y: 20, width: self.view.frame.width, height: 40))
        shalomLbl.text = "Shalom! \(Auth.auth().currentUser!.displayName!)"
        shalomLbl.textAlignment = .center
        shalomLbl.textColor = UIColor(red: 67/255, green: 122/255, blue: 77/255, alpha: 1.0)
        shalomLbl.font = .systemFont(ofSize: 18)
        vertStack.addSubview(shalomLbl)
        
            
        //message
        let messageLbl = UILabel(frame: CGRect(x: 20, y: shalomLbl.frame.height + 20, width: self.view.frame.width - 40, height: 60))
        messageLbl.text = "Bantu kami untuk jelaskan apa yang rindu kami bantu dalam doa. Tuhan Yesus Memberkati"
        messageLbl.numberOfLines = 0
        messageLbl.textAlignment = .center
        messageLbl.font = .systemFont(ofSize: 14)
        vertStack.addSubview(messageLbl)
        
        //Masalah singkat
        let masalahTxt = UITextView(frame: CGRect(x: 20, y: shalomLbl.frame.height + messageLbl.frame.height + 40, width: self.view.frame.width - 40, height: 120))
        masalahTxt.delegate = self
        masalahTxt.isSelectable = true
        masalahTxt.isEditable = true
        masalahTxt.isUserInteractionEnabled = true
        masalahTxt.isScrollEnabled = true
        masalahTxt.textAlignment = .left
        masalahTxt.text = "Masalah singkat Anda"
       // masalahTxt.addTarget(self, action: #selector(self.masalahTextFieldDidChange(_:)), for: .editingChanged)
        
        masalahTxt.center.x = self.view.frame.width / 2
        Utilities.styleView(v: masalahTxt)
        
        vertStack.addSubview(masalahTxt)
        
        //btn simpan
        let simpanBtn = UIButton(frame: CGRect(x: (self.view.frame.width / 2) - 100, y: shalomLbl.frame.height + messageLbl.frame.height + masalahTxt.frame.height + 60, width: 200, height: 40))
        simpanBtn.addTarget(self, action: #selector(self.simpanBtnClicked), for: UIControl.Event.touchUpInside)
        simpanBtn.setTitle("Simpan", for: .normal)
        simpanBtn.isUserInteractionEnabled = true
        simpanBtn.backgroundColor = UIColor(red: 67/255, green: 122/255, blue: 77/255, alpha: 1.0)
        // effect when selected
        vertStack.addSubview(simpanBtn)
        
        self.scrollView.addSubview(vertStack)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        print("editing")
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        user.problem = textView.text!
    }
    func textViewDidChange(_ textView: UITextView){
           user.problem = textView.text!
       }
    
    @objc func masalahTextFieldDidChange(_ textField: UITextField) {
        user.problem = textField.text!
    }
    
    @objc func simpanBtnClicked(sender : UIButton) {
        Utilities.onClickFeedback(btn: sender)
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
        scrollView.contentSize = CGSize(width: (scrollView.frame.size.width * 2), height: self.view.frame.height - pageControl.frame.height - NavBar.frame.height - 100)
        scrollView.delegate = self
    }
    
    // called after scroll view end decelerating
    // it tells us which page we're at
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
        pageControl.currentPage = Int(pageNumber)
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        //transition to home
        let homeVC = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        homeVC?.modalPresentationStyle = .fullScreen
        homeVC?.modalTransitionStyle = .coverVertical
        present(homeVC!, animated: true, completion: nil)
    }
}
