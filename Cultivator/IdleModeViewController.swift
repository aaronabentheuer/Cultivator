//
//  IdleModeViewController.swift
//  Cultivator
//
//  Created by Julian Abentheuer on 27.01.15.
//  Copyright (c) 2015 Aaron Abentheuer. All rights reserved.
//

import UIKit

class IdleModeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.yellowColor()
        self.view.alpha = 0.5

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}