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
    var juiciness : Float
    var structure : Float
    
    private var mineralsDictionary : NSDictionary
    var minerals : Float
    var calcium : Float
    var iron : Float
    var magnesium : Float
    
    private var nutritionsDictionary : NSDictionary
//    var calium : Float
//    var calories : Float
//    var carbohydrates : Float
    var cholesterol : Float
    var fat : Float
    var phosphorus : Float
    var protein : Float
    var purine : Float

    private var vitaminesDictionary : NSDictionary
    var vitamines : Float
    var b12 : Float
    var b6 : Float
    var niacin : Float
    
    init(ingredients : NSDictionary) {
        title = ingredients["Title"] as String!
        creator = ingredients["Creator"] as String!
        comment = ingredients["Description"] as String!
        favorite = ingredients["Favorite"] as Bool!
        location = ingredients["Location"] as String!
        currentlyInQueue = ingredients["PrintLine"] as Bool!
        
        meatColor = ingredients["color"] as Float!
        juiciness = ingredients["juiciness"] as Float!
        structure = ingredients["structure"] as Float!
        
        mineralsDictionary = ingredients["Minerals"] as NSDictionary!
        calcium = mineralsDictionary["calcium"] as Float!
        iron = mineralsDictionary["iron"] as Float!
        magnesium = mineralsDictionary["magnesium"] as Float!
        minerals = calcium+iron+magnesium

        nutritionsDictionary = ingredients["Nutritions"] as NSDictionary!
//        calium = nutritionsDictionary["calium"] as Float!
//        calories = nutritionsDictionary["calories"] as Float!
//        carbohydrates = nutritionsDictionary["carbs"] as Float!
        cholesterol = nutritionsDictionary["cholesterol"] as Float!
        fat = nutritionsDictionary["fat"] as Float!
        phosphorus = nutritionsDictionary["phosphor"] as Float!
        protein = nutritionsDictionary["protein"] as Float!
        purine = nutritionsDictionary["purin"] as Float!

        vitaminesDictionary = ingredients["Vitamines"] as NSDictionary!
        b12 = vitaminesDictionary["b12"] as Float!
        b6 = vitaminesDictionary["b6"] as Float!
        niacin = vitaminesDictionary["niacin"] as Float!
        vitamines = b12 + b6 + niacin
    }
}