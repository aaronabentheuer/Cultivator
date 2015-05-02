//
//  FamilyMember.swift
//  Cultivator
//
//  Created by Julian Abentheuer on 29.01.15.
//  Copyright (c) 2015 Aaron Abentheuer. All rights reserved.
//

import UIKit


class FamilyMember: UIButton {
    
    var activated : Bool = false
    var thisbackgroundView : UIView = UIView()
    var familyimageView : UIImageView?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = self.frame.width/2
        self.layer.masksToBounds = true
        
        familyimageView = UIImageView(frame: self.bounds)
        self.addSubview(familyimageView!)
        
        thisbackgroundView.frame = self.bounds
        thisbackgroundView.backgroundColor = UIColor.whiteColor()
        thisbackgroundView.alpha = 0
        self.addSubview(thisbackgroundView)
        
        self.addTarget(self, action: "wasTapped", forControlEvents: UIControlEvents.TouchUpInside)

    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func wasTapped () {
        
        println("tapped")
        
        if (activated == false) {
            
            UIView.animateWithDuration(0.3, animations: {
                self.thisbackgroundView.alpha = 0.5
                }, completion: { _ in
            })
            
            activated = true
            
            println(activated)

        } else if (activated == true) {
            
            UIView.animateWithDuration(0.3, animations: {
                self.thisbackgroundView.alpha = 0
                }, completion: { _ in
                    
            })
            
            activated = false

        }
    }
}

