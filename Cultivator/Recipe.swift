//
//  Recipe.swift
//  Cultivator
//
//  Created by Julian Abentheuer on 24.01.15.
//  Copyright (c) 2015 Aaron Abentheuer. All rights reserved.
//

import UIKit

var myRed = UIColor(red: 253/255, green: 119/255, blue: 121/255, alpha: 1)
var myRedWithAlpha = UIColor(red: 253/255, green: 119/255, blue: 121/255, alpha: 0.35)


class Recipe: UICollectionViewCell, UITableViewDelegate, UITableViewDataSource {
    
    var myMeat : Meat?
    
    var title : MarqueeLabel = MarqueeLabel()
    var creator : UILabel = UILabel()
    var comment : UILabel = UILabel()
    var blendingView : UIView = UIView()
    
    var healthyWizard : UIView = UIView()
    var nutritionalTableView : UITableView = UITableView()
    
    var makeHealthyButton : UIButton?
    var makeHealthyButtonLabel : UILabel?
    
    var myRandomValue : Int?
    
    var objectiveDescription : UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        notificationCenter.addObserver(self, selector: "handleScrollViewDidScroll:", name: "scrollViewDidScrollNotification", object: nil)
        notificationCenter.addObserver(self, selector: "handleScrollViewWillBeginDecelerating:", name: "scrollViewWillBeginDeceleratingNotification", object: nil)
        notificationCenter.addObserver(self, selector: "familyMemberWasTapped", name: "familyMemberWasTapped", object: nil)

        
        myRandomValue = Int(arc4random_uniform(20)+5)
        
        self.backgroundColor = UIColor(white: 1, alpha: 0.00)
        
        var speechBubbleRect : UIView = UIView(frame: CGRect(x: 0, y: 64, width: frame.width, height: 64))
        speechBubbleRect.backgroundColor = UIColor.whiteColor()
        self.addSubview(speechBubbleRect)
        
        var speechBubbleTraingleView : UIImageView = UIImageView(frame: CGRect(x: 0, y: 127, width: 10, height: 10))
        speechBubbleTraingleView.image = UIImage(named: "Triangle")
        self.addSubview(speechBubbleTraingleView)
        
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 6
        paragraphStyle.lineBreakMode = NSLineBreakMode.ByWordWrapping
        
        var attrString = NSMutableAttributedString(string: "Perfekt zartes, saftiges Fleisch wie im Wiener Traditionsbetrieb.")
        attrString.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        
        self.comment.attributedText = attrString
        
        self.comment.frame = CGRect(x: 12, y: 68, width: frame.width-32, height: 56)
        self.comment.textColor = UIColor.blackColor()
        self.comment.numberOfLines = 2
        self.comment.font = UIFont(name: "Avenir", size: 16)
        self.comment.textColor = UIColor.blackColor()
        self.addSubview(comment)
                
        self.creator.frame = CGRect(x: 12, y: 140, width: frame.width-16, height: 24)
        self.creator.text = "Ewald Plachutta · Wien, Österreich"
        self.creator.textColor = UIColor.whiteColor()
        self.creator.font = UIFont(name: "Avenir", size: 16)
        self.addSubview(creator)
        
        var seperatorLine : UIView = UIView(frame: CGRect(x: 0, y: 180, width: self.frame.width, height: 0.5))
        seperatorLine.backgroundColor = UIColor(white: 1, alpha: 0.5)
        seperatorLine.layer.cornerRadius = 0.25
        self.addSubview(seperatorLine)
        

        
        nutritionalTableView.delegate = self
        nutritionalTableView.dataSource = self
        nutritionalTableView.frame = CGRect(x: 0, y: 190, width: frame.width, height: frame.height-250)
        nutritionalTableView.backgroundColor = UIColor.clearColor()
        nutritionalTableView.separatorColor = UIColor(white: 1, alpha: 0.25)
        nutritionalTableView.showsVerticalScrollIndicator = false
        nutritionalTableView.registerClass(IngredientsTableViewCell.self, forCellReuseIdentifier: "ingredient")
        self.addSubview(nutritionalTableView)
        
        blendingView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        blendingView.backgroundColor = UIColor.blackColor()
        blendingView.layer.opacity = 0
        self.addSubview(blendingView)
        
        makeHealthyButton = UIButton(frame: CGRect(x: 0, y: self.frame.height-50, width: self.frame.width, height: 38))
        makeHealthyButton!.backgroundColor = UIColor(white: 1, alpha: 0.25)
        makeHealthyButton!.clipsToBounds = true
        makeHealthyButton!.layer.cornerRadius = 38/2
        makeHealthyButton!.addTarget(self, action: "wasTapped", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(makeHealthyButton!)
        
        makeHealthyButtonLabel = UILabel(frame: makeHealthyButton!.bounds)
        makeHealthyButtonLabel!.font = UIFont(name: "Avenir", size: 16)
        makeHealthyButtonLabel!.textColor = UIColor.whiteColor()
        makeHealthyButtonLabel!.textAlignment = .Center
        makeHealthyButton!.addSubview(makeHealthyButtonLabel!)

        self.title.frame = CGRect(x: 12, y: 16, width: frame.width-16, height: 40)
        self.title.scrollDuration = 2
        self.title.animationDelay = 0.5
        self.title.fadeLength = 5
        self.title.animationCurve = UIViewAnimationOptions.CurveEaseInOut
        self.title.text = "Wiener Schnitzel"
        
        self.title.textColor = UIColor.whiteColor()
        self.title.font = UIFont(name: "Avenir", size: 24)
        self.addSubview(title)
        
        var cornerWidth : CGFloat = 10
        var cornerAlpha : CGFloat = 0.5
        
        var topLeftCorner : UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: cornerWidth, height: cornerWidth))
        topLeftCorner.image = UIImage(named: "TopLeft")
        topLeftCorner.alpha = cornerAlpha
        self.addSubview(topLeftCorner)
        
        var topRightCorner : UIImageView = UIImageView(frame: CGRect(x: frame.width-cornerWidth, y: 0, width: cornerWidth, height: cornerWidth))
        topRightCorner.image = UIImage(named: "TopRight")
        topRightCorner.alpha = cornerAlpha
        self.addSubview(topRightCorner)
        
        var bottomLeftCorner : UIImageView = UIImageView(frame: CGRect(x: 0, y: frame.height-cornerWidth, width: cornerWidth, height: cornerWidth))
        bottomLeftCorner.image = UIImage(named: "BottomLeft")
        bottomLeftCorner.alpha = cornerAlpha
        self.addSubview(bottomLeftCorner)
        
        var bottomRightCorner : UIImageView = UIImageView(frame: CGRect(x: frame.width-cornerWidth, y: frame.height-cornerWidth, width: cornerWidth, height: cornerWidth))
        bottomRightCorner.image = UIImage(named: "BottomRight")
        bottomRightCorner.alpha = cornerAlpha
        self.addSubview(bottomRightCorner)
    }
    
    var avatar : UIImageView = UIImageView(frame: CGRectMake(0, 0, 80, 80))
    var commentText : UILabel = UILabel()
    
    func handleScrollViewDidScroll (notification : NSNotification) {
        
        avatar.center = CGPointMake(self.bounds.midX, self.bounds.midY-40)
        avatar.backgroundColor = UIColor.clearColor()
        avatar.layer.cornerRadius = 40
        avatar.layer.borderWidth = 1
        avatar.layer.borderColor = UIColor.whiteColor().CGColor
        avatar.clipsToBounds = true
        avatar.alpha = 1
        self.blendingView.addSubview(avatar)
        
        commentText.frame = CGRect(x: 12, y: self.frame.height/2+10, width: self.frame.width-16, height: 40)
        commentText.font = UIFont(name: "AvenirNext-Demibold", size: 16)
        commentText.textAlignment = .Center
        commentText.textColor = UIColor.whiteColor()
        commentText.alpha = 0.5
        self.blendingView.addSubview(commentText)
        
        UIView.animateWithDuration(0.2, animations: {
            self.blendingView.layer.opacity = 0.95
            self.title.textAlignment = .Center
            self.title.font = UIFont(name: "Avenir", size: 20)
            self.title.numberOfLines = 2
            self.title.frame = CGRect(x: 12, y: self.frame.height/2+36, width: self.frame.width-16, height: 40)
            self.makeHealthyButton!.frame = CGRect(x: 0, y: self.frame.height-50, width: 38, height: 38)
            self.makeHealthyButton!.center.x = self.bounds.midX
            self.makeHealthyButtonLabel!.textColor = UIColor(white: 1, alpha: 0)
        })
    }
    

    
    func handleScrollViewWillBeginDecelerating (notification : NSNotification) {
        UIView.animateWithDuration(0.2, animations: {
            self.blendingView.layer.opacity = 0
            
            self.title.textAlignment = .Left
            self.title.numberOfLines = 1
            self.title.font = UIFont(name: "Avenir-Light", size: 24)
            self.title.frame = CGRect(x: 12, y: 16, width: self.frame.width-16, height: 40)
            self.makeHealthyButton!.frame = CGRect(x: 0, y: self.frame.height-50, width: self.frame.width, height: 38)
            self.makeHealthyButtonLabel!.textColor = UIColor(white: 1, alpha: 1)

        })
    }
    
    func animateGlancabilityOut () {
        
    }
    
    func wasTapped () {
        if (myMeat!.unhealthy) {
            myMeat!.makeHealthy()
            
            nutritionalTableView.beginUpdates()
            nutritionalTableView.deleteSections(NSIndexSet(index: 0), withRowAnimation: UITableViewRowAnimation.Fade)
            nutritionalTableView.insertSections(NSIndexSet(index: 0), withRowAnimation: UITableViewRowAnimation.Fade)
            
            nutritionalTableView.endUpdates()
            UIView.animateWithDuration(0.3, animations: {
                self.makeHealthyButton!.backgroundColor = UIColor(white: 1, alpha: 0.35)
                self.makeHealthyButtonLabel!.text = "Zur Warteschlange hinzufügen"
            })
            
            myMeat!.unhealthy = false
            myMeat!.notinqueue = true
            
        } else {
            makeHealthyButton!.backgroundColor = UIColor(white: 1, alpha: 0.35)
            makeHealthyButtonLabel!.text = "2 Stunden 35 Minuten"
            
            var fadeInOutAnimation : CABasicAnimation = CABasicAnimation(keyPath: "opacity")
            fadeInOutAnimation.fromValue = 1
            fadeInOutAnimation.toValue = 0.25
            fadeInOutAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            fadeInOutAnimation.duration = 1
            fadeInOutAnimation.autoreverses = true
            fadeInOutAnimation.repeatCount = HUGE
            fadeInOutAnimation.removedOnCompletion = true
            fadeInOutAnimation.fillMode = kCAFillModeBoth
            
            makeHealthyButton!.layer.addAnimation(fadeInOutAnimation, forKey: "opacity")
            
            myMeat!.notinqueue = false
            myMeat!.inqueue = true
        }
    }
    
    func resetHealthyButton () {
        myMeat!.notinqueue = true
        makeHealthyButton!.layer.removeAllAnimations()
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.separatorInset = UIEdgeInsetsZero
        cell.layoutMargins = UIEdgeInsetsZero
        cell.preservesSuperviewLayoutMargins = false
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        if (indexPath.section == 0) {
            let cell = tableView.dequeueReusableCellWithIdentifier("ingredient", forIndexPath: indexPath) as! IngredientsTableViewCell
            cell.ingredientLabel.text = myMeat!.nutritionsNameArray[indexPath.row]
            cell.ingredientValue.text = "\(Int(myMeat!.nutritionsArray[indexPath.row])) mg"
            
            if (myMeat!.healthynessArray[indexPath.row]) {
                cell.ingredientLabel.textColor = myRed
                cell.ingredientValue.textColor = myRed
            } else {
                cell.ingredientLabel.textColor = UIColor.whiteColor()
                cell.ingredientValue.textColor = UIColor.whiteColor()
            }
            
            
            return cell
        } else if (indexPath.section == 1) {
            let cell = tableView.dequeueReusableCellWithIdentifier("ingredient", forIndexPath: indexPath) as! IngredientsTableViewCell
            cell.ingredientLabel.text = myMeat!.mineralsNameArray[indexPath.row]
            cell.ingredientValue.text = "\(Int(myMeat!.mineralsArray[indexPath.row])) mg"
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("ingredient", forIndexPath: indexPath) as! IngredientsTableViewCell
            cell.ingredientLabel.text = myMeat!.vitamineNameArray[indexPath.row]
            cell.ingredientValue.text = "\(Int(myMeat!.vitaminesArray[indexPath.row])) mg"
            return cell
        }
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if (section == 0) {
            var header = IngredientsTableViewHeaderView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 30))
            header.sectionTitle.text = "Nährwerte"
            return header
        } else if (section == 1) {
            var header = IngredientsTableViewHeaderView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 30))
            header.sectionTitle.text = "Mineralien"
            header.sectionValue.text = "\(myMeat!.minerals) mg / 100 g"
            return header
        } else {
            var header = IngredientsTableViewHeaderView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 30))
            header.sectionTitle.text = "Vitamine"
            header.sectionValue.text = "\(myMeat!.vitamines) mg / 100 g"
            return header
        }
    }
    
    var contentOffset : CGFloat = 0
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return myMeat!.nutritionsNameArray.count
        } else if (section == 1) {
            return myMeat!.mineralsNameArray.count
        } else {
            return myMeat!.vitamineNameArray.count
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class IngredientsTableViewCell: UITableViewCell {

    var ingredientLabel : UILabel = UILabel()
    var ingredientValue : UILabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor.clearColor()
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
        //TODO: PROPERLY ALIGN LABELS
        
        ingredientLabel.frame = CGRect(x: 12, y: 0, width: frame.width-12, height: frame.height)
        ingredientLabel.textColor = UIColor.whiteColor()
        ingredientLabel.alpha = 0.5
//        ingredientLabel.sizeToFit()
//        ingredientLabel.layer.anchorPoint = CGPointMake(0, 1)
//        ingredientValue.center = CGPointMake(12, frame.height)
        ingredientLabel.textAlignment = .Left
        ingredientLabel.font = UIFont(name: "AvenirNext-Demibold", size: 20)
        self.addSubview(ingredientLabel)
        
        ingredientValue.frame = CGRect(x: 12, y: 0, width: frame.width-62, height: frame.height)
        ingredientValue.textColor = UIColor.whiteColor()
        ingredientValue.alpha = 1
//        ingredientValue.sizeToFit()
//        ingredientValue.layer.anchorPoint = CGPointMake(1, 1)
//        ingredientValue.center = CGPointMake(frame.width-12, frame.height)
        ingredientValue.textAlignment = .Right
        ingredientValue.font = UIFont(name: "Avenir-Light", size: 24)
        self.addSubview(ingredientValue)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class IngredientsTableViewHeaderView: UIView {
    
    var sectionTitle : UILabel = UILabel()
    var sectionValue : UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.whiteColor()
        
        sectionTitle.frame = CGRect(x: 12, y: 0, width: frame.width-12, height: frame.height)
        sectionTitle.textColor = UIColor.blackColor()
        sectionTitle.alpha = 1
        sectionTitle.textAlignment = .Left
        sectionTitle.font = UIFont(name: "AvenirNext-Demibold", size: 16)
        self.addSubview(sectionTitle)
        
        sectionValue.frame = CGRect(x: 0, y: 0, width: frame.width-12, height: frame.height)
        sectionValue.textColor = UIColor.blackColor()
        sectionValue.alpha = 0.5
        sectionValue.textAlignment = .Right
        sectionValue.font = UIFont(name: "AvenirNext-Demibold", size: 16)
        self.addSubview(sectionValue)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}