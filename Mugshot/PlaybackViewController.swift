//
//  PlaybackViewController.swift
//  UserTestingSuite
//
//  Created by Kyle Thomas on 20/07/2018.
//  Copyright © 2018 Kyle Thomas. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import AVKit

class PlaybackViewController: UIViewController {
    
    let playerVc = AVPlayerViewController()
    let screenPlayerVc = AVPlayerViewController()
    @IBOutlet weak var screenPlayerContainer: UIView!
    @IBOutlet weak var playerContainerView: UIView!
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addChildViewController(self.playerVc)
        self.playerContainerView.addSubview(self.playerVc.view)
        self.playerVc.view.frame = self.playerContainerView.bounds
        self.playerVc.view.layer.bounds = self.playerContainerView.layer.bounds
        self.playerVc.didMove(toParentViewController: self)
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileUrl = paths[0].appendingPathComponent("output.mov")
        
        let player = AVPlayer(url: fileUrl)
        self.playerVc.player = player
        
        
        //Screen Player
        self.addChildViewController(self.screenPlayerVc)
        self.screenPlayerContainer.addSubview(self.screenPlayerVc.view)
        self.screenPlayerVc.view.frame = self.screenPlayerContainer.bounds
        self.screenPlayerVc.view.layer.bounds = self.screenPlayerContainer.layer.bounds
        self.screenPlayerVc.didMove(toParentViewController: self)
        let screenFile = paths[0].appendingPathComponent("screen.mov")
        
        let screenPlayer = AVPlayer(url: screenFile)
        self.screenPlayerVc.player = screenPlayer
        
    }
}
