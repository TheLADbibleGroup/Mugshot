//
//  UserTesterViewController.swift
//  UserTestingSuite
//
//  Created by Kyle Thomas on 20/07/2018.
//  Copyright © 2018 Kyle Thomas. All rights reserved.
//

import UIKit
import AVFoundation
import ReplayKit

class UserTesterViewController: UIViewController{

     let v = UIView(frame: CGRect.zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AVCaptureDevice.requestAccess(for: .video, completionHandler: { success in
            
        })
        self.setupView()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func setupView() {
        self.v.backgroundColor = UIColor.red
        self.view.addSubview(v)
        
        self.v.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.v.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        self.v.heightAnchor.constraint(equalToConstant: 300).isActive = true
        self.v.widthAnchor.constraint(equalToConstant: 200).isActive = true
        self.v.translatesAutoresizingMaskIntoConstraints = false
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
    }
    
    var userTester = UserTester()
    
}



