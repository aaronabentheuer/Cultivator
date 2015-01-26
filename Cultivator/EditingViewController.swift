//
//  EditingViewController.swift
//  Cultivator
//
//  Created by Julian Abentheuer on 25.01.15.
//  Copyright (c) 2015 Aaron Abentheuer. All rights reserved.
//

import UIKit

class EditingViewController: UIViewController {
    
    var backgroundView : UIVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.Dark))

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clearColor()
        backgroundView.frame = self.view.frame
        backgroundView.alpha = 0
        self.view.addSubview(backgroundView)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        UIView.animateWithDuration(0.3, animations: {
            self.backgroundView.alpha = 1
        }, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
