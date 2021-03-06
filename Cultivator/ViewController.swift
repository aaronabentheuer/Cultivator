//
//  ViewController.swift
//  Cultivator
//
//  Created by Julian Abentheuer on 21.01.15.
//  Copyright (c) 2015 Aaron Abentheuer. All rights reserved.
//

import UIKit
import GPUImage
import AVFoundation

var notificationCenter : NSNotificationCenter = NSNotificationCenter.defaultCenter()
var editingViewController : EditingViewController = EditingViewController()
var recipeCollectionView : UICollectionView?
var backgroundView : UIVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.Dark))

var snapshot : UIView? = nil
var viewIsReady : Bool = false

var energySourceIndicator : UIImageView = UIImageView (frame: CGRectMake(0, 0, 48, 40))


class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate {

    var recipeCollectionViewCell : Recipe?
    var addRecipeCollectionViewCell : AddCell?    
    var noInteraction = false
    
    var idleTimer : NSTimer?

    var recepies : NSArray = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blackColor()
        
        var recipeCollectionViewLayout = TLSpringFlowLayout()
        recipeCollectionViewLayout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        recipeCollectionViewLayout.itemSize = CGSize(width: 280, height: 580)
        recipeCollectionViewLayout.minimumLineSpacing = 50
        recipeCollectionViewLayout.sectionInset = UIEdgeInsets(top: 20, left: 50, bottom: 0, right: 50)
        
        recipeCollectionView = UICollectionView(frame: CGRectMake(0, 0, 1024, 768), collectionViewLayout: recipeCollectionViewLayout)
        
        
        recipeCollectionView!.delegate = self
        recipeCollectionView!.backgroundColor = UIColor.clearColor()
        recipeCollectionView!.dataSource = self
        
        recipeCollectionView!.registerClass(Recipe.self, forCellWithReuseIdentifier: "cell")
        recipeCollectionView!.registerClass(AddCell.self, forCellWithReuseIdentifier: "addCell")
        
        self.view.addSubview(recipeCollectionView!)
        
        var path = NSBundle.mainBundle().pathForResource("Rezepturen", ofType: "plist")
        recepies = NSArray(contentsOfFile: path!)!
        
        
        
        var cameraView : GPUImageView = GPUImageView(frame: CGRectMake(0, 0, 100, 100))
        self.view.addSubview(cameraView)
        
        notificationCenter.addObserver(self, selector: "handleAwakeUser", name: "userIsAwakeNotification", object: nil)
        notificationCenter.addObserver(self, selector: "handleIdleUser", name: "userIsIdleNotification", object: nil)
        
        
        var familyMemberView = UIView(frame: CGRectMake(0, 0, 330, 50))
        familyMemberView.center = CGPointMake(UIScreen.mainScreen().bounds.midX, UIScreen.mainScreen().bounds.minY + 50)
        self.view.addSubview(familyMemberView)
        
        var familyMember1 = FamilyMember(frame: CGRectMake(0, 0, 50, 50))
        familyMember1.familyimageView!.image = UIImage(named: "Julia Hoffmann")
        familyMember1.layer.borderWidth = 2
        familyMember1.layer.borderColor = UIColor.whiteColor().CGColor
        familyMemberView.addSubview(familyMember1)
        
        var familyMember2 = FamilyMember(frame: CGRectMake(70, 0, 50, 50))
        familyMember2.familyimageView!.image = UIImage(named: "Frank Hoffmann")
        familyMember2.layer.borderWidth = 2
        familyMember2.layer.borderColor = UIColor.whiteColor().CGColor
        familyMemberView.addSubview(familyMember2)
        
        var familyMember3 = FamilyMember(frame: CGRectMake(140, 0, 50, 50))
        familyMember3.familyimageView!.image = UIImage(named: "Daniel Hoffmann")
        familyMember3.layer.borderWidth = 2
        familyMember3.layer.borderColor = UIColor.whiteColor().CGColor
        familyMemberView.addSubview(familyMember3)
        
        var familyMember4 = FamilyMember(frame: CGRectMake(210, 0, 50, 50))
        familyMember4.familyimageView!.image = UIImage(named: "Irina Hoffmann")
        familyMember4.layer.borderWidth = 2
        familyMember4.layer.borderColor = UIColor.whiteColor().CGColor
        familyMemberView.addSubview(familyMember4)
        
        var familyMember5 = FamilyMember(frame: CGRectMake(280, 0, 50, 50))
        familyMember5.familyimageView!.image = UIImage(named: "Douggy Hoffmann")
        familyMember5.layer.borderWidth = 2
        familyMember5.layer.borderColor = UIColor.whiteColor().CGColor
        familyMemberView.addSubview(familyMember5)
        
        backgroundView.frame = self.view.frame
        backgroundView.alpha = 0
        self.view.addSubview(backgroundView)
    }
    
    var idleModeViewController = IdleModeViewController()
    var idleModeViewControllerIsCurrentlyPresented = false
    
    func handleAwakeUser () {
        if (idleModeViewControllerIsCurrentlyPresented) {

            self.dismissViewControllerAnimated(true, completion: nil)
            idleModeViewControllerIsCurrentlyPresented = false
        }
    }
    
    func handleIdleUser () {
        idleModeViewController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        idleModeViewController.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
        if (idleModeViewControllerIsCurrentlyPresented == false) {
            self.presentViewController(idleModeViewController, animated: true, completion: nil)
            idleModeViewControllerIsCurrentlyPresented = true
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        changeEnergySoundTimer = NSTimer.scheduledTimerWithTimeInterval(50, target: self, selector: Selector("changeEnergySource"), userInfo: nil, repeats: true)
        changeEnergySoundTimer!.fire()
        
        viewIsReady = true
    }
    
    //MARK: RECIPE-COLLECTIONVIEW RELATED METHODS.
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 200
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return meatArray.count
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
//        let cell : Recipe = recipeCollectionView!.cellForItemAtIndexPath(indexPath) as Recipe
//        
//        snapshot = self.customSnapshotFromView(cell)
//        var center : CGPoint = cell.center
//        
//        var attributes : UICollectionViewLayoutAttributes = recipeCollectionView!.layoutAttributesForItemAtIndexPath(indexPath)!
//        
//        var cellRect = attributes.frame
//        var cellFrameInSuperView : CGRect = recipeCollectionView!.convertRect(cellRect, toView: recipeCollectionView!.superview)
//        
//        snapshot?.center = CGPointMake(cellFrameInSuperView.midX, cellFrameInSuperView.midY)
//        snapshot?.alpha = 1
//        self.view.addSubview(snapshot!)
//        cell.alpha = 0
//        
//        UIView.animateWithDuration(NSTimeInterval(0.5), animations: {
//            snapshot?.center.y = self.view.center.y
//            snapshot?.center.x = 190
//            
//            snapshot?.alpha = 1
//            
//            backgroundView.alpha = 1
//            
//            snapshot?.layer.shouldRasterize = true
//            snapshot?.layer.rasterizationScale = UIScreen.mainScreen().scale
//                        
//            }, completion: { (value: Bool) in
////                meatToBeEdited.append(meatArray[indexPath.row])
////                editingViewController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
////                editingViewController.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
////                self.presentViewController(editingViewController, animated: true, completion: nil)
//        })
    }
    
    func customSnapshotFromView (inputView : UIView) -> UIView {
        UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, false, 0)
        inputView.layer.renderInContext(UIGraphicsGetCurrentContext())
        var image : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        var snapshot : UIView = UIImageView(image: image)
        snapshot.layer.masksToBounds = false
        snapshot.layer.cornerRadius = 0
        snapshot.layer.shadowOffset = CGSizeMake(0.0, 0.0);
        snapshot.layer.shadowRadius = 2.0;
        snapshot.layer.shadowOpacity = 0.4;
        
        return snapshot
    }
    
    var scrollViewDidScrollNotification = NSNotification(name: "scrollViewDidScrollNotification", object: nil)
    var scrollViewWillBeginDeceleratingNotification = NSNotification(name: "scrollViewWillBeginDeceleratingNotification", object: nil)
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        notificationCenter.postNotification(scrollViewDidScrollNotification)
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        notificationCenter.postNotification(scrollViewWillBeginDeceleratingNotification)
    }
    
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        notificationCenter.postNotification(scrollViewWillBeginDeceleratingNotification)
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! Recipe
            
            cell.myMeat = meatArray[indexPath.row]
            cell.myMeat!.reset()
        cell.resetHealthyButton()

            var paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 6
            paragraphStyle.lineBreakMode = NSLineBreakMode.ByWordWrapping
            
            var attrString = NSMutableAttributedString(string: meatArray[indexPath.row].comment)
            attrString.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
            
            cell.comment.attributedText = attrString
            
            var jucinessdescription : String?
            var structuredescription : String?
            var colordescription: String?

            
            if (cell.myMeat!.juiciness < 0.4) {
                jucinessdescription = "trocken"
            } else {
                jucinessdescription = "saftig"
            }
            
            if (cell.myMeat!.structure < 0.4) {
                structuredescription = "herb"
            } else {
                structuredescription = "sanft"
            }
            
            if (cell.myMeat!.meatColor < 0.5) {
                colordescription = "hell"
            } else {
                colordescription = "dunkel"
            }
            
            
            cell.myRandomValue = Int(arc4random_uniform(20)+5)


            cell.title.text = meatArray[indexPath.row].title
            
            cell.avatar.image = UIImage(named: meatArray[indexPath.row].creator)
            cell.commentText.text = "\(meatArray[indexPath.row].creator) empfiehlt"
            
            if (cell.myMeat!.unhealthy) {
                cell.makeHealthyButton!.backgroundColor = myRedWithAlpha
                cell.makeHealthyButtonLabel!.text = "Nährwerte personalisieren"
                cell.myMeat!.unhealthy = true

            } else if (cell.myMeat!.notinqueue) {
                cell.makeHealthyButton!.backgroundColor = UIColor(white: 1, alpha: 0.35)
                cell.makeHealthyButtonLabel!.text = "Zur Warteschlange hinzufügen"
                cell.myMeat!.notinqueue = true

            } else if (cell.myMeat!.inqueue) {
                cell.makeHealthyButton!.backgroundColor = UIColor(white: 1, alpha: 0.35)
                cell.makeHealthyButtonLabel!.text = "Dauer wird berechnet."
                
                var fadeInOutAnimation : CABasicAnimation = CABasicAnimation(keyPath: "opacity")
                fadeInOutAnimation.fromValue = 1
                fadeInOutAnimation.toValue = 0.25
                fadeInOutAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
                fadeInOutAnimation.duration = 1
                fadeInOutAnimation.autoreverses = true
                fadeInOutAnimation.repeatCount = HUGE
                fadeInOutAnimation.removedOnCompletion = true
                fadeInOutAnimation.fillMode = kCAFillModeBoth
                
                cell.makeHealthyButton!.layer.addAnimation(fadeInOutAnimation, forKey: "opacity")
            }

            
            cell.creator.text = meatArray[indexPath.row].creator

            return cell
    }
    
    //MARK: ENERGYINDICATOR RELATED METHODS.
    
    var changeEnergySoundTimer : NSTimer?
    var selfSufficiency = UIImage(named: "SelfSufficient")
    var energyAutarchy = UIImage(named: "Autarchy")
    var energyDependancy = UIImage(named: "Dependant")
    var energySourceChangedAudioPlayer : AVAudioPlayer?
    var energySourceIndicatorTooltip : UILabel = UILabel(frame: UIScreen.mainScreen().bounds)
    var energySourceIndicatorTooltipPanGestureRecognizer : UIPanGestureRecognizer?
    var energySourceIndicatorTooltipTapGestureRecognizer : UITapGestureRecognizer?
    
    func changeEnergySource () {
        
        energySourceIndicator.layer.removeAllAnimations()
        
        energySourceIndicatorTooltipPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: "energySourceIndicatorTooltipWasPanned")
        energySourceIndicatorTooltipPanGestureRecognizer!.delegate = self
        energySourceIndicator.addGestureRecognizer(energySourceIndicatorTooltipPanGestureRecognizer!)
        
        energySourceIndicatorTooltipTapGestureRecognizer = UITapGestureRecognizer(target: self, action: "energySourceIndicatorTooltipWasTapped")
        energySourceIndicatorTooltipTapGestureRecognizer!.delegate = self
        energySourceIndicator.addGestureRecognizer(energySourceIndicatorTooltipTapGestureRecognizer!)
        
        if (energySourceIndicator.superview == nil) {
            energySourceIndicator.center = CGPoint(x: UIScreen.mainScreen().bounds.midX, y: UIScreen.mainScreen().bounds.maxY-30)
            UIApplication.sharedApplication().delegate!.window!!.addSubview(energySourceIndicator)
            
            energySourceIndicatorTooltip.font = UIFont(name: "Colfax-Regular", size: 16)
            energySourceIndicatorTooltip.textColor = UIColor.whiteColor()
            energySourceIndicatorTooltip.textAlignment = .Center
            energySourceIndicatorTooltip.layer.opacity = 0
            energySourceIndicatorTooltip.sizeToFit()
            UIApplication.sharedApplication().delegate!.window!!.addSubview(energySourceIndicatorTooltip)
            
        }
        
        if (energySourceIndicator.image == nil) {
            var dice = Int(arc4random_uniform(3))
            
            switch dice {
            case 1: energySourceIndicator.image = energyAutarchy
            case 2: energySourceIndicator.image = energyDependancy
            case 3: energySourceIndicator.image = selfSufficiency
            default: energySourceIndicator.image = energyDependancy
            }
            
        } else {
            if (energySourceIndicator.image == energyAutarchy) {
                energySourceIndicator.image = energyDependancy
            } else if (energySourceIndicator.image == energyDependancy) {
                energySourceIndicator.image = selfSufficiency
            } else if (energySourceIndicator.image == selfSufficiency) {
                energySourceIndicator.image = energyAutarchy
            }
        }
        
        var fadeInOutAnimation : CABasicAnimation = CABasicAnimation(keyPath: "opacity")
        fadeInOutAnimation.fromValue = 1
        fadeInOutAnimation.toValue = 0.25
        fadeInOutAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        fadeInOutAnimation.duration = 0.5
        fadeInOutAnimation.autoreverses = true
        fadeInOutAnimation.repeatCount = 3
        fadeInOutAnimation.removedOnCompletion = false
        fadeInOutAnimation.fillMode = kCAFillModeBoth
        energySourceIndicator.layer.addAnimation(fadeInOutAnimation, forKey: "opacity")
        
        if (energySourceIndicator.image == energyAutarchy || energySourceIndicator.image == energyDependancy) {
            energySourceChangedAudioPlayer = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("Firm", ofType: ".mp3")!), error: nil)
            energySourceIndicator.alpha = 1
        } else {
            energySourceChangedAudioPlayer = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("100Percent", ofType: ".mp3")!), error: nil)
        }
        
        if (energySourceIndicator.image == energyAutarchy) {
            energySourceIndicatorTooltip.text = "Ihre hausinterne Stromversorgung wird verwendet. CULTIVATOR versucht die Selbstversorgung durch das Solarpanel wiederherzustellen."
        } else if (energySourceIndicator.image == energyDependancy) {
            energySourceIndicatorTooltip.text = "Das öffentliche Stromnetz wird zur Energieversorgung verwendet. CULTIVATOR versucht die Selbstversorgung durch das Solarpanel wiederherzustellen."
        } else if (energySourceIndicator.image == selfSufficiency) {
            energySourceIndicatorTooltip.text = "CULTIVATOR versorgt sich selbst durch Solarenergie in Ihrer Küche."
        }
        
        energySourceIndicatorTooltip.sizeToFit()
        energySourceIndicatorTooltip.numberOfLines = 2
        
        energySourceChangedAudioPlayer!.prepareToPlay()
        energySourceChangedAudioPlayer!.play()
        
        var minRandomEnergySourceChangeTimeInterval : UInt32 = 50
        var maxRandomEnergySourceChangeTimeInterval : UInt32 = 150
        
        changeEnergySoundTimer!.invalidate()
        changeEnergySoundTimer! = NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(Int(arc4random_uniform(minRandomEnergySourceChangeTimeInterval)) + Int(minRandomEnergySourceChangeTimeInterval)), target: self, selector: Selector("changeEnergySource"), userInfo: nil, repeats: true)
    }
    
    func energySourceIndicatorTooltipWasPanned (recognizer : UIPanGestureRecognizer) {
        
        if (recognizer.state == .Began) {
            energySourceIndicatorTooltip.alpha = 1
            energySourceIndicatorTooltip.center = recognizer.locationInView(energySourceIndicatorTooltip.superview!)
        } else if (recognizer.state == .Changed) {
            energySourceIndicatorTooltip.center = recognizer.locationInView(energySourceIndicatorTooltip.superview!)
        } else {
            energySourceIndicatorTooltip.center = recognizer.locationInView(energySourceIndicatorTooltip.superview!)
            energySourceIndicatorTooltip.alpha = 0
        }
    }
    
    func energySourceIndicatorTooltipWasTapped (recognizer : UIPanGestureRecognizer) {
        
        if (recognizer.state == .Began) {
            energySourceIndicatorTooltip.alpha = 1
            energySourceIndicatorTooltip.center = recognizer.locationInView(energySourceIndicatorTooltip.superview!)
        } else if (recognizer.state == .Changed) {
            energySourceIndicatorTooltip.center = recognizer.locationInView(energySourceIndicatorTooltip.superview!)
        } else {
            energySourceIndicatorTooltip.center = recognizer.locationInView(energySourceIndicatorTooltip.superview!)
            energySourceIndicatorTooltip.alpha = 0
        }
    }
    
    //MARK: SYSTEM-RELATED STUFF
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

