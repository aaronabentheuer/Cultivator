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
        
        notificationCenter.addObserver(self, selector: "userInteractionDetected", name: "userInteractionDetectedNotification", object: nil)

    }
    
    func userInteractionDetected () {
        println("dismiss")
        if (self.isFirstResponder()) {
            self.presentingViewController!.dismissViewControllerAnimated(false, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}