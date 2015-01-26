//
//  ViewController.swift
//  Cultivator
//
//  Created by Julian Abentheuer on 21.01.15.
//  Copyright (c) 2015 Aaron Abentheuer. All rights reserved.
//

import UIKit
import GPUImage

var notificationCenter : NSNotificationCenter = NSNotificationCenter.defaultCenter()

var editingViewController : EditingViewController = EditingViewController()
var recipeCollectionView : UICollectionView?

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var recipeCollectionViewCell : Recipe?
    var addRecipeCollectionViewCell : AddCell?

    var videoCamera:GPUImageVideoCamera?
    var filter:GPUImageMotionDetector?
    
    
    var recepies : NSArray = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blackColor()
        
        var recipeCollectionViewLayout = RecipeLayout()
        recipeCollectionViewLayout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        recipeCollectionViewLayout.itemSize = CGSize(width: 280, height: 620)
        recipeCollectionViewLayout.minimumLineSpacing = 50
        recipeCollectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 50)

        
        recipeCollectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: recipeCollectionViewLayout)
        recipeCollectionView!.delegate = self
        recipeCollectionView!.dataSource = self
        
        recipeCollectionView!.registerClass(Recipe.self, forCellWithReuseIdentifier: "cell")
        recipeCollectionView!.registerClass(AddCell.self, forCellWithReuseIdentifier: "addCell")
        
        self.view.addSubview(recipeCollectionView!)
        
        var path = NSBundle.mainBundle().pathForResource("Rezepturen", ofType: "plist")
        recepies = NSArray(contentsOfFile: path!)!
        
        var cameraView : GPUImageView = GPUImageView(frame: CGRectMake(0, 0, 100, 100))
        self.view.addSubview(cameraView)
        
        
        videoCamera = GPUImageVideoCamera(sessionPreset: AVCaptureSessionPreset640x480, cameraPosition: .Front)
        videoCamera!.outputImageOrientation = UIInterfaceOrientation.LandscapeLeft;
        filter = GPUImageMotionDetector()
        videoCamera?.addTarget(filter)
//        filter?.addTarget(cameraView as GPUImageView)
        videoCamera?.startCameraCapture()

        filter?.motionDetectionBlock = { (motionCentroid : CGPoint, motionIntensity : CGFloat, frameTime : CMTime) in return
            println(Int(floor(motionIntensity*100)))
        }

    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 200
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recepies.count
    }
    
    var snapshot : UIView? = nil
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        var cell : Recipe = recipeCollectionView!.cellForItemAtIndexPath(indexPath) as Recipe
        
        self.snapshot = self.customSnapshotFromView(cell)
        var center : CGPoint = cell.center
        println(center)
        
        
        var attributes : UICollectionViewLayoutAttributes = recipeCollectionView!.layoutAttributesForItemAtIndexPath(indexPath)!
        
        var cellRect = attributes.frame
        var cellFrameInSuperView : CGRect = recipeCollectionView!.convertRect(cellRect, toView: recipeCollectionView!.superview)
        
        self.snapshot?.center = CGPointMake(cellFrameInSuperView.midX, cellFrameInSuperView.midY)
        self.snapshot?.alpha = 1
        self.view.addSubview(self.snapshot!)
        cell.alpha = 0
        
        UIView.animateWithDuration(NSTimeInterval(0.5), animations: {
            self.snapshot?.center.y = self.view.center.y
            self.snapshot?.center.x = self.view.center.x-300
            
            self.snapshot?.alpha = 1
            
            self.snapshot?.layer.shouldRasterize = true
            self.snapshot?.layer.rasterizationScale = UIScreen.mainScreen().scale
            
            }, completion: { (value: Bool) in
                editingViewController.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
                self.presentViewController(editingViewController, animated: false, completion: nil)
        })
        
//        if (indexPath == NSIndexPath(forItem: 0, inSection: 0)) {
//            var newString = "KochInfinity"
//            self.testArray.insert(newString, atIndex: 0)
//            
//            UIView.animateWithDuration(0.5, animations: {
//                self.recipeCollectionView!.reloadData()
//            })
        
//        }
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
//        notificationCenter.postNotification(scrollViewDidScrollNotification)
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
//        notificationCenter.postNotification(scrollViewWillBeginDeceleratingNotification)
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        var dictionary : NSDictionary = recepies[indexPath.row] as NSDictionary
        
        if (indexPath == NSIndexPath(forItem: 0, inSection: 0)) {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("addCell", forIndexPath: indexPath) as AddCell
            return cell
        } else {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as Recipe
            
            cell.title.text = dictionary["Title"]! as? String
            cell.comment.text = dictionary["Description"]! as? String
            cell.creator.text = dictionary["Creator"]! as? String

            return cell
        }
    }
    
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}

