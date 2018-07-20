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
    let headerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 32)
        label.textAlignment = .center
        label.text = "MUGSHOT"
        label.textColor = UIColor.black
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AVCaptureDevice.requestAccess(for: .video, completionHandler: { success in
            
        })
        self.setupView()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func setupView() {
        self.v.backgroundColor = UIColor.white
        self.view.addSubview(v)
        let height = UIScreen.main.bounds.height * 0.5
        let width = UIScreen.main.bounds.width * 0.75
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(close)))
        self.v.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.v.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        self.v.heightAnchor.constraint(equalToConstant: height).isActive = true
        self.v.widthAnchor.constraint(equalToConstant: width).isActive = true
        self.v.translatesAutoresizingMaskIntoConstraints = false
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        
        self.v.addSubview(self.headerLabel)
        NSLayoutConstraint(item: self.headerLabel, attribute: .top, relatedBy: .equal, toItem: self.v, attribute: .top, multiplier: 1.0, constant: 32.0).isActive = true
        self.headerLabel.centerXAnchor.constraint(equalTo: self.v.centerXAnchor).isActive = true
        self.headerLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        self.headerLabel.widthAnchor.constraint(equalTo: self.v.widthAnchor).isActive = true
        self.headerLabel.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    @objc func close() {
        self.dismiss(animated: false, completion: nil)
    }
    
    var userTester = UserTester()
    
}







