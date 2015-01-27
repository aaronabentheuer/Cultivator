//
//  Recipe.swift
//  Cultivator
//
//  Created by Julian Abentheuer on 24.01.15.
//  Copyright (c) 2015 Aaron Abentheuer. All rights reserved.
//

import UIKit

class Recipe: UICollectionViewCell, UITableViewDelegate, UITableViewDataSource {
    
    var title : UILabel = UILabel()
    var creator : UILabel = UILabel()
    var comment : UILabel = UILabel()
    var blendingView : UIView = UIView()
    
    var healthyWizard : UIView = UIView()
    var nutritionalTableView : UITableView = UITableView()
    
    var ingredientsNames = ["Cholesterin", "Phosphor", "Fett", "Eiweiß", "Purin", "Mineralien", "Vitamine"]
    var ingredientsValues = [12, 4, 21, 90, 20, 65, 32]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        notificationCenter.addObserver(self, selector: "handleScrollViewDidScroll:", name: "scrollViewDidScrollNotification", object: nil)
        notificationCenter.addObserver(self, selector: "handleScrollViewWillBeginDecelerating:", name: "scrollViewWillBeginDeceleratingNotification", object: nil)
        
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
        self.comment.font = UIFont(name: "Colfax-Regular", size: 16)
        self.comment.textColor = UIColor.blackColor()
        self.addSubview(comment)
        
        self.creator.frame = CGRect(x: 12, y: 140, width: frame.width-16, height: 24)
        self.creator.text = "Ewald Plachutta · Wien, Österreich"
        self.creator.textColor = UIColor.whiteColor()
        self.creator.font = UIFont(name: "Colfax-Regular", size: 16)
        self.addSubview(creator)
        
        var seperatorLine : UIView = UIView(frame: CGRect(x: 0, y: 180, width: self.frame.width, height: 0.5))
        seperatorLine.backgroundColor = UIColor(white: 1, alpha: 0.5)
        seperatorLine.layer.cornerRadius = 0.25
        self.addSubview(seperatorLine)
        
        healthyWizard.frame = CGRect(x: 0, y: 296+50, width: frame.width, height: 36)
        healthyWizard.backgroundColor = UIColor(hue: 350/360, saturation: 50/100, brightness: 100/100, alpha: 65/100)
        healthyWizard.layer.cornerRadius = 36/2
//        self.addSubview(healthyWizard)
        
        nutritionalTableView.delegate = self
        nutritionalTableView.dataSource = self
        nutritionalTableView.frame = CGRect(x: 0, y: 348+50, width: frame.width, height: frame.height-348-50)
        nutritionalTableView.backgroundColor = UIColor.clearColor()
        nutritionalTableView.separatorColor = UIColor(white: 1, alpha: 0.25)
        nutritionalTableView.showsVerticalScrollIndicator = false
        nutritionalTableView.registerClass(IngredientsTableViewCell.self, forCellReuseIdentifier: "ingredient")
        self.addSubview(nutritionalTableView)
        
        
        blendingView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        blendingView.backgroundColor = UIColor.blackColor()
        blendingView.layer.opacity = 0
        self.addSubview(blendingView)
        
        self.title.frame = CGRect(x: 12, y: 16, width: frame.width-16, height: 40)
        self.title.text = "Wiener Schnitzel"
        self.title.textColor = UIColor.whiteColor()
        self.title.font = UIFont(name: "Colfax-Light", size: 24)
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
    
    func handleScrollViewDidScroll (notification : NSNotification) {
                
        UIView.animateWithDuration(0.2, animations: {
            self.blendingView.layer.opacity = 0.95
            self.title.textAlignment = .Center
            self.title.font = UIFont(name: "Colfax-Regular", size: 20)
            self.title.numberOfLines = 2
            self.title.frame = CGRect(x: 12, y: self.frame.height/2-20, width: self.frame.width-16, height: 40)
        })
    }
    
    func handleScrollViewWillBeginDecelerating (notification : NSNotification) {
        UIView.animateWithDuration(0.2, animations: {
            self.blendingView.layer.opacity = 0
            self.title.textAlignment = .Left
            self.title.numberOfLines = 1
            self.title.font = UIFont(name: "Colfax-Light", size: 24)
            self.title.frame = CGRect(x: 12, y: 16, width: self.frame.width-16, height: 40)
        })
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.separatorInset = UIEdgeInsetsZero
        cell.layoutMargins = UIEdgeInsetsZero
        cell.preservesSuperviewLayoutMargins = false
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier("ingredient", forIndexPath: indexPath) as IngredientsTableViewCell
        cell.ingredientLabel.text = ingredientsNames[indexPath.row]
        cell.ingredientValue.text = "\(ingredientsValues[indexPath.row]) mg"
        return cell
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var header = IngredientsTableViewHeaderView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 30))
        header.sectionTitle.text = "Nährwerte"
        return header
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredientsNames.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
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
        ingredientLabel.font = UIFont(name: "Colfax-Medium", size: 20)
        self.addSubview(ingredientLabel)
        
        ingredientValue.frame = CGRect(x: 12, y: 0, width: frame.width-62, height: frame.height)
        ingredientValue.textColor = UIColor.whiteColor()
        ingredientValue.alpha = 1
//        ingredientValue.sizeToFit()
//        ingredientValue.layer.anchorPoint = CGPointMake(1, 1)
//        ingredientValue.center = CGPointMake(frame.width-12, frame.height)
        ingredientValue.textAlignment = .Right
        ingredientValue.font = UIFont(name: "Colfax-Light", size: 24)
        self.addSubview(ingredientValue)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class IngredientsTableViewHeaderView: UIView {
    
    var sectionTitle : UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.whiteColor()
        
        sectionTitle.frame = CGRect(x: 12, y: 0, width: frame.width-12, height: frame.height)
        sectionTitle.textColor = UIColor.blackColor()
        sectionTitle.alpha = 1
        sectionTitle.textAlignment = .Left
        sectionTitle.font = UIFont(name: "Colfax-Medium", size: 16)
        self.addSubview(sectionTitle)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}