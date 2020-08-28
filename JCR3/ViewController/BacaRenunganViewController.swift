//
//  BacaRenunganViewController.swift
//  JCR3
//
//  Created by Irenna Nicole on 25/08/20.
//  Copyright © 2020 Irenna Lumbuun. All rights reserved.
//

import UIKit

class BacaRenunganViewController: UIViewController {

    @IBOutlet weak var isiAyatLbl: UILabel!
    @IBOutlet weak var ayatLbl: UILabel!
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var renunganTableView: UITableView!
    @IBOutlet weak var logoJC: UIImageView!
    @IBOutlet weak var buatGematBtn: UIButton!
    @IBOutlet weak var renunganTitleLbl: UILabel!
    @IBOutlet weak var btnShare: UIButton!
    @IBOutlet weak var renunganTextLbl: UILabel!
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var ayatHarianView: UIView!
    @IBOutlet weak var quotesHarianView: UIView!
    
    // TODO: replace popupview with UIAlertController instead
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        Utilities.styleView(v: ayatHarianView)
        Utilities.styleView(v: quotesHarianView)
    }
    
    // show share popup
    @IBAction func btnShareTapped(_ sender: Any) {
    }
    
    @IBAction func btnCancelTapped(_ sender: Any) {
    }
}
