//
//  RadioViewController.swift
//  JCR3
//
//  Created by Irenna Nicole on 01/08/20.
//  Copyright © 2020 Irenna Lumbuun. All rights reserved.
//

import UIKit
import AVFoundation

class RadioViewController: UIViewController, AVAssetResourceLoaderDelegate {
    @IBOutlet weak var radioImg: UIImageView!
    @IBOutlet weak var radioNameLbl: UILabel!
    @IBOutlet weak var onAirStatus: UILabel!
    @IBOutlet weak var numListenerLbl: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var chatBtn: UIButton!
    
    let urlFile = URL(string:"http://pu.klikhost.com:8060/stream")!
    var player: AVPlayer!
    var avAudioSession:AVAudioSession = AVAudioSession.sharedInstance()

    override func viewDidLoad() {
        super.viewDidLoad()
        try! avAudioSession.setCategory(.playback, mode: .default, options: [])
        try! avAudioSession.setActive(true)

        let audioURLAsset = AVURLAsset(url: urlFile)
        player = AVPlayer(playerItem: AVPlayerItem(asset: audioURLAsset))
        player.play()
        // styling
        // autoplay radio
    }
    
    @IBAction func shareBtnTapped(_ sender: Any) {
        // todo later
    }
    
    @IBAction func playBtnTapped(_ sender: Any) {
        /*
        if let player = player, player.isPlaying {
            player.stop()
            onAirStatus.text = "Playing"
            playBtn.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
        } else {
            let url = "http://pu.klikhost.com:8060/stream"
            do {
               //AVAudioSession.sharedInstance().setMode(.default)
                //AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
                player = try AVAudioPlayer(contentsOf:URL(string: url)!)
               guard let player = player else {
                    return
                }
                player.play()
                playBtn.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
                onAirStatus.text = "Not playing"
            } catch Exception {
                print(Exception)
            }
        }
 */
    }
    
    @IBAction func chatBtnTapped(_ sender: Any) {
    }
}
