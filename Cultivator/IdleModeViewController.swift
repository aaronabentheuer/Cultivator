//
//  IdleModeViewController.swift
//  Cultivator
//
//  Created by Julian Abentheuer on 27.01.15.
//  Copyright (c) 2015 Aaron Abentheuer. All rights reserved.
//

import UIKit

class IdleModeViewController: UIViewController {
    
    var cleaningLabel : UILabel = UILabel()
    var smudgesView : UIView = UIView()
    var fadeInOutAnimation : CABasicAnimation = CABasicAnimation(keyPath: "opacity")

    
    override func viewDidLoad() {
        super.viewDidLoad()

        var backgroundView : UIVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.Dark))
        backgroundView.frame = self.view.frame
        self.view.addSubview(backgroundView)
        
        
        for (var i : Int = 0; i <= 34; i++) {
            for (var j : Int = 0; j <= 26; j++) {
                
                var honeyComb : UIImageView = UIImageView(image: UIImage(named: "Honeycomb"))
                
                if (j%2 == 0) {
                    honeyComb.frame = CGRectMake(-16.0 + CGFloat(i) * 32, -15 + CGFloat(j) * 30, 32, 32)
                } else {
                    honeyComb.frame = CGRectMake(1 + CGFloat(i) * 32, -15 + CGFloat(j) * 30, 32, 32)
                }
                
                var normalizer : CGFloat = abs(((honeyComb.center.x - self.view.center.x)/(self.view.center.x)) * ((honeyComb.center.y - self.view.center.y)/(self.view.center.y)))
                var minimumAlphaValue : CGFloat = 0.01 - 0.01 * normalizer
                var maximumAlphaValue : CGFloat = 0.05 - 0.05 * normalizer
                
                var dice = Double(1 + arc4random_uniform(2))
                var delay = Double(arc4random_uniform(3))
                
                var fadeInOutAnimation : CABasicAnimation = CABasicAnimation(keyPath: "opacity")
                fadeInOutAnimation.fromValue = minimumAlphaValue
                fadeInOutAnimation.toValue = maximumAlphaValue
                fadeInOutAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
                fadeInOutAnimation.duration = dice
                fadeInOutAnimation.autoreverses = true
                fadeInOutAnimation.repeatCount = HUGE
                fadeInOutAnimation.beginTime = CACurrentMediaTime() + delay
                fadeInOutAnimation.removedOnCompletion = false
                fadeInOutAnimation.fillMode = kCAFillModeBoth
                
                honeyComb.layer.addAnimation(fadeInOutAnimation, forKey: "opacity")
                
                self.view.addSubview(honeyComb)
            }
            
            smudgesView = UIView(frame: self.view.bounds)
            smudgesView.backgroundColor = UIColor.clearColor()
            self.view.addSubview(smudgesView)
        }
        
//        cleaningLabel.textColor = UIColor.whiteColor()
//        cleaningLabel.font = UIFont(name: "Colfax", size: 24)
//        cleaningLabel.frame = UIScreen.mainScreen().bounds
//        cleaningLabel.text = "Oberfläche wird gereinigt. Bitte nicht berühren."
//        cleaningLabel.sizeToFit()
//        cleaningLabel.center = CGPointMake(UIScreen.mainScreen().bounds.midX, UIScreen.mainScreen().bounds.midY/2)
//        self.view.addSubview(cleaningLabel)
//        
//        fadeInOutAnimation.fromValue = 1
//        fadeInOutAnimation.toValue = 0
//        fadeInOutAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
//        fadeInOutAnimation.duration = 1
//        fadeInOutAnimation.autoreverses = true
//        fadeInOutAnimation.repeatCount = HUGE
//        fadeInOutAnimation.removedOnCompletion = true
//        fadeInOutAnimation.fillMode = kCAFillModeBoth
//        
//        notificationCenter.addObserver(self, selector: "handleAwakeUser", name: "userIsAwakeNotification", object: nil)
    }
    
//    func handleAwakeUser() {
//
//        var acquiringHealthInformationLabel : UILabel = UILabel(frame: UIScreen.mainScreen().bounds)
//        acquiringHealthInformationLabel.font = UIFont(name: "Colfax-Medium", size: 16)
//        acquiringHealthInformationLabel.textColor = UIColor.whiteColor()
//        acquiringHealthInformationLabel.textAlignment = .Center
//        acquiringHealthInformationLabel.layer.opacity = 1
//        self.view.addSubview(acquiringHealthInformationLabel)
//        
//        acquiringHealthInformationLabel.text = "HealthDaten-Abfrage"
//        acquiringHealthInformationLabel.sizeToFit()
//        acquiringHealthInformationLabel.center = CGPointMake(UIScreen.mainScreen().bounds.midX, UIScreen.mainScreen().bounds.midY + 100)
//        
//        CATransaction.begin()
//        
//
//        CATransaction.setCompletionBlock({ _ in
//            var vc = ViewController()
//            vc.handleAwakeUser()
//        })
//        acquiringHealthInformationLabel.layer.addAnimation(fadeInOutAnimation, forKey: "opacity")
//        
//        CATransaction.commit()
//    }

    
    var smudgesViewArray : [UIView] = []
    var cleaningInstruction : UILabel = UILabel()
    
    var shimmeringInstruction : FBShimmeringView = FBShimmeringView()
    
    override func viewWillAppear(animated: Bool) {
        
        cleaningInstruction.frame = self.view.bounds
        cleaningInstruction.font = UIFont(name: "Colfax-Light", size: 24)
        cleaningInstruction.text = "Bildschirm wird gereinigt!"
        cleaningInstruction.textAlignment = .Center
        cleaningInstruction.textColor = UIColor.whiteColor()
        cleaningInstruction.alpha = 1

        shimmeringInstruction = FBShimmeringView(frame: self.view.bounds)
        shimmeringInstruction.alpha = 0
        self.view.addSubview(shimmeringInstruction)
        
        shimmeringInstruction.contentView = cleaningInstruction
        
        for smudge in smudgeArray {
            
            var dice = 1+arc4random_uniform(5)
            
            var dirtySmudge : UIImageView = UIImageView(frame: CGRectMake(0, 0, 50, 50))
            dirtySmudge.contentMode = UIViewContentMode.ScaleAspectFill
            
            dirtySmudge.image = UIImage(named: "Smudge\(dice)")
            dirtySmudge.center = smudge
            dirtySmudge.alpha = 0
            smudgesViewArray.append(dirtySmudge)
            
            smudgesView.addSubview(dirtySmudge)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        
        shimmeringInstruction.shimmering = true
        
        if (smudgeArray.count != 0) {
            UIView.animateWithDuration(Double(1), animations: { _ in
                for smudge in self.smudgesViewArray {
                    smudge.alpha = 0.5
                }
                }, completion: { _ in
                    UIView.animateWithDuration(3, animations: {
                        for smudge in self.smudgesViewArray {
                            smudge.alpha = 0
                        }
                    })
                    
            })
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
    }
    
    override func viewDidDisappear(animated: Bool) {
        
        for view in smudgesView.subviews {
            view.removeFromSuperview()
        }
        
        smudgesViewArray.removeAll(keepCapacity: false)
        smudgeArray.removeAll(keepCapacity: false)
        
        cleaningInstruction.layer.removeAllAnimations()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}