//
//  Meat.swift
//  Cultivator
//
//  Created by Julian Abentheuer on 27.01.15.
//  Copyright (c) 2015 Aaron Abentheuer. All rights reserved.
//

import UIKit

class Meat: NSObject {
    
    var title : String
    var creator : String
    var comment : String
    var favorite : Bool
    var location : String
    var currentlyInQueue : Bool
    
    var meatColor : Float
    var cholesterol : Float
    
    init(ingredients : NSDictionary) {
        title = ingredients["Title"] as String!
        creator = ingredients["Creator"] as String!
        comment = ingredients["Description"] as String!
        favorite = ingredients["Favorite"] as Bool!
        location = ingredients["Location"] as String!
        currentlyInQueue = ingredients["PrintLine"] as Bool!
        
        meatColor = ingredients["Cholesterol"] as Float!
        cholesterol = ingredients["Cholesterol"] as Float!
    }
}