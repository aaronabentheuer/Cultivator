//
//  ViewController.swift
//  Cultivator
//
//  Created by Julian Abentheuer on 21.01.15.
//  Copyright (c) 2015 Aaron Abentheuer. All rights reserved.
//

import UIKit

var notificationCenter : NSNotificationCenter = NSNotificationCenter.defaultCenter()

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var recipeCollectionView : UICollectionView?
    var recipeCollectionViewCell : Recipe?
    var addRecipeCollectionViewCell : AddCell?

    
    
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
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
//        if (indexPath == NSIndexPath(forItem: 0, inSection: 0)) {
//            var newString = "KochInfinity"
//            self.testArray.insert(newString, atIndex: 0)
//            
//            UIView.animateWithDuration(0.5, animations: {
//                self.recipeCollectionView!.reloadData()
//            })
//        }
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
            
            return cell
        }
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}

