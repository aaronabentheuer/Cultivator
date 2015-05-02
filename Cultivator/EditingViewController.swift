//
//  EditingViewController.swift
//  Cultivator
//
//  Created by Julian Abentheuer on 25.01.15.
//  Copyright (c) 2015 Aaron Abentheuer. All rights reserved.
//

import UIKit
import SceneKit

var meatToBeEdited : [Meat] = []

class EditingViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var thisMeat : Meat?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clearColor()
        
        println("reached")
        
        
        var recipeCollectionViewLayout = RecipeLayout()
        recipeCollectionViewLayout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        recipeCollectionViewLayout.itemSize = CGSize(width: 280, height: 580)
        recipeCollectionViewLayout.minimumLineSpacing = 50
        recipeCollectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 50)
        
        
        recipeCollectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: recipeCollectionViewLayout)
        recipeCollectionView!.delegate = self
        recipeCollectionView!.backgroundColor = UIColor.clearColor()
        recipeCollectionView!.dataSource = self
        
        var tapGestureRecognizer : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("handleTapInBackground:"))
        
        recipeCollectionView!.addGestureRecognizer(tapGestureRecognizer)
        
        recipeCollectionView!.registerClass(Recipe.self, forCellWithReuseIdentifier: "cell")
        recipeCollectionView!.registerClass(AddCell.self, forCellWithReuseIdentifier: "addCell")
        
        self.view.addSubview(recipeCollectionView!)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! Recipe
        
        cell.myMeat = meatToBeEdited[0]
        
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 6
        paragraphStyle.lineBreakMode = NSLineBreakMode.ByWordWrapping
        
        var attrString = NSMutableAttributedString(string: meatToBeEdited[0].comment)
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
        
        
        cell.title.text = meatToBeEdited[0].title
        
        cell.avatar.image = UIImage(named: meatToBeEdited[0].creator)
        cell.commentText.text = "\(meatToBeEdited[0].creator) empfiehlt"
        
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
        
        
        cell.creator.text = meatToBeEdited[0].creator
        
        return cell
    }

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 200
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func handleTapInBackground (recognizer : UITapGestureRecognizer) {
        var vc = ViewController()
        self.presentingViewController!.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        snapshot?.removeFromSuperview()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
