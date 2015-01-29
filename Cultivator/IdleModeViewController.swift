//
//  IdleModeViewController.swift
//  Cultivator
//
//  Created by Julian Abentheuer on 27.01.15.
//  Copyright (c) 2015 Aaron Abentheuer. All rights reserved.
//

import UIKit

class IdleModeViewController: UIViewController {
    
    var backgroundView : UIVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.Dark))

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clearColor()

        backgroundView.frame = self.view.frame
        backgroundView.alpha = 0
        self.view.addSubview(backgroundView)
    }
    
    override func viewDidAppear(animated: Bool) {
        UIView.animateWithDuration(0.25, animations: {
            self.backgroundView.alpha = 1
        })
    }
    
    override func viewWillDisappear(animated: Bool) {
        UIView.animateWithDuration(0.25, animations: {
            energySourceIndicator.center = CGPoint(x: UIScreen.mainScreen().bounds.midX, y: UIScreen.mainScreen().bounds.maxY-30)
        })
    }
    
    override func viewDidDisappear(animated: Bool) {
        self.backgroundView.alpha = 0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}