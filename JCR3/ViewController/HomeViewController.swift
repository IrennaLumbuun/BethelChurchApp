//
//  HomeViewController.swift
//  JCR3
//
//  Created by Irenna Nicole on 23/07/20.
//  Copyright © 2020 Irenna Lumbuun. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class HomeViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    

    @IBOutlet weak var newsUpdateSearchBar: UISearchBar!
    @IBOutlet weak var inboxUpdateBtn: UIButton!
    @IBOutlet weak var profileBtn: UIButton!
    @IBOutlet weak var radioBtn: UIButton!
    @IBOutlet weak var gemarBtn: UIButton!
    @IBOutlet weak var notifScrollView: UIScrollView!
    @IBOutlet weak var btnGroupCollectionView: UICollectionView!
    
    //setting up scrollable button group here
    private let cellId = "btnCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setup()
        
        //for scrollable button group
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        btnGroupCollectionView.backgroundColor = UIColor.black
        btnGroupCollectionView.collectionViewLayout = layout
        btnGroupCollectionView.translatesAutoresizingMaskIntoConstraints = false
        btnGroupCollectionView.register(BtnCell.self, forCellWithReuseIdentifier: "btnCell")
    }
    
    //10:30 to see the whole code for horizontal scroll direction collection view
    // lanjut 17:29, 19:06, 19:18
    // append element see 27:40
    
    override func viewWillAppear(_ animated: Bool) {
        //in a weird case where user is has not set up their name yet
        if Auth.auth().currentUser?.displayName == nil {
            self.transitionToDaftar()
        }
    }
    
    func transitionToDaftar(){
        let daftarVC = storyboard?.instantiateViewController(identifier: Constants.Storyboard.daftarViewController) as? DaftarViewController
        
        view.window?.rootViewController = daftarVC
        view.window?.makeKeyAndVisible()
    }
    
    
    //override func for collection view layout
    let btnName: [String] = ["Live Streaming", "Warrior Bride", "SBS COOL", "Dukungan Doa"]
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           print("resize collection")
           return CGSize(width: 150, height: 50)
       }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("return collection")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath as IndexPath) as! BtnCell
        
        let button = UIButton()
        button.tag = indexPath.row
        button.setTitle(btnName[indexPath.row], for: .normal)
        button.backgroundColor = UIColor.white
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(self.btnClicked), for: UIControl.Event.touchUpInside)

        button.frame = CGRect(x: 10, y: 10, width: 150, height: 30)
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.sizeToFit()
        button.layer.cornerRadius = 10
        
        cell.btn = button
        cell.setupViews()
        return cell
    }

    @objc func btnClicked(sender : UIButton) {
        //get buttonName
        let btnTag = sender.tag
        // 0 -> pop up with link
        if btnTag == 0 {
            let popUp = storyboard?.instantiateViewController(identifier: Constants.Storyboard.liveStreamPopUp) as? StreamingPopUpViewController
            self.addChild(popUp!)
            popUp!.view.frame = self.view.frame
            self.view.addSubview(popUp!.view)
            popUp?.didMove(toParent: self)
            
        }
        // 1 -> auto download warrior bride
        if btnTag == 1 {
            Database.database().reference().child("Dashboard").observeSingleEvent(of: .value, with: { (snapshot) in
                  // Get user value
                    let data = snapshot.value as? NSDictionary
                    var url = data?["Warrior"] as? String ?? ""
                    url = url.replacingOccurrences(of: "\\/", with: "/").replacingOccurrences(of:"\"", with: "")
                    let toOpen = URL(string: url)
                    UIApplication.shared.open((toOpen)!)
                  }) {(error) in
                    print("error")
                    print(error.localizedDescription)
                }
            }
        
        if btnTag == 2 {
            Database.database().reference().child("Dashboard").observeSingleEvent(of: .value, with: { (snapshot) in
              // Get user value
                let data = snapshot.value as? NSDictionary
                var url = data?["SBS"] as? String ?? ""
                url = url.replacingOccurrences(of: "\\/", with: "/").replacingOccurrences(of:"\"", with: "")
                let toOpen = URL(string: url)
                UIApplication.shared.open((toOpen)!)
              }) {(error) in
                print("error")
                print(error.localizedDescription)
            }
        }
    
        if btnTag == 3 {
            let dukunganDoaVC = storyboard?.instantiateViewController(identifier: Constants.Storyboard.dukunganDoaViewController) as? DukunganDoaViewController
            
            view.window?.rootViewController = dukunganDoaVC
            view.window?.makeKeyAndVisible()
        }
    }
    
}

class BtnCell: UICollectionViewCell {
    var btn: UIButton!
    
    override init(frame:CGRect) {
        super.init(frame:frame)
        //setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(btn)
    }
    
}


