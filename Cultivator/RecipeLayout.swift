//
//  RecipeLayout.swift
//  Cultivator
//
//  Created by Julian Abentheuer on 24.01.15.
//  Copyright (c) 2015 Aaron Abentheuer. All rights reserved.
//

import UIKit

class RecipeLayout: UICollectionViewFlowLayout {
   
    override init() {
        super.init()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes! {
//        var index = indexPath.indexAtPosition(0)
//        var attributes : UICollectionViewLayoutAttributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
//        attributes.frame = CGRectMake(CGFloat(index) * itemSize.width, 0, itemSize.width, itemSize.height)
//        return attributes
//    }
//    
//    override func layoutAttributesForElementsInRect(rect: CGRect) -> [AnyObject]? {
//        var attributes : NSMutableArray = NSMutableArray()
//        var firstIndex = Int(floorf(Float(CGRectGetMinX(rect)) / Float(itemSize.width)))
//        var lastIndex = Int(ceilf(Float(CGRectGetMaxX(rect)) / Float(itemSize.width)))
//
//        for (var index = firstIndex; index <= lastIndex; index++) {
//            var indexPath : NSIndexPath = NSIndexPath(indexes: [0, index], length: 2)
//            attributes.addObject(self.layoutAttributesForItemAtIndexPath(indexPath))
//        }
//        
//        return attributes
//    }
//    
//    override func finalLayoutAttributesForDisappearingItemAtIndexPath(itemIndexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
//        var attributes : UICollectionViewLayoutAttributes = self.layoutAttributesForItemAtIndexPath(itemIndexPath)
//        attributes.alpha = 0
//        return attributes
//    }
}