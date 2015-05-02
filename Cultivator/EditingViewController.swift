//
//  EditingViewController.swift
//  Cultivator
//
//  Created by Julian Abentheuer on 25.01.15.
//  Copyright (c) 2015 Aaron Abentheuer. All rights reserved.
//

import UIKit
import SceneKit

var displayedDictionary : NSDictionary = NSDictionary()

class EditingViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clearColor()
        
        var recipeCollectionViewLayout = RecipeLayout()
        recipeCollectionViewLayout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        recipeCollectionViewLayout.itemSize = CGSize(width: 280, height: 620)
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
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as Recipe
        
        cell.title.text = displayedDictionary["Title"]! as? String
        cell.comment.text = displayedDictionary["Description"]! as? String
        cell.creator.text = displayedDictionary["Creator"]! as? String
        
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
        vc.animateOutBlurView()
        self.presentingViewController!.dismissViewControllerAnimated(false, completion: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        snapshot?.removeFromSuperview()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
