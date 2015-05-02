//
//  AppDelegate.swift
//  Cultivator
//
//  Created by Julian Abentheuer on 21.01.15.
//  Copyright (c) 2015 Aaron Abentheuer. All rights reserved.
//

import UIKit
import GPUImage
import AVFoundation

var meatArray : [Meat] = []

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate, UIGestureRecognizerDelegate {

    var window: UIWindow?

    var videoCamera:GPUImageVideoCamera?
    var filter:GPUImageMotionDetector?
    
    var userInteractionTimer : NSTimer?
    var userInteractionTimerActivated : Bool = false
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        var path = NSBundle.mainBundle().pathForResource("Rezepturen", ofType: "plist")
        var recepies = NSArray(contentsOfFile: path!)!
        
        for recepie in recepies {
            meatArray.append(Meat(ingredients: recepie as NSDictionary))
        }
        
        videoCamera = GPUImageVideoCamera(sessionPreset: AVCaptureSessionPreset640x480, cameraPosition: .Front)
        videoCamera!.outputImageOrientation = UIInterfaceOrientation.LandscapeLeft;
        filter = GPUImageMotionDetector()
        videoCamera?.addTarget(filter)
        videoCamera?.startCameraCapture()
        
        userInteractionTimer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: Selector("handleIdleUser:"), userInfo: nil, repeats: false)
        
        filter?.motionDetectionBlock = { (motionCentroid : CGPoint, motionIntensity : CGFloat, frameTime : CMTime) in
            
            var normalizedIntensity : Int = Int(roundf(Float(motionIntensity))*100)
                        
            if (normalizedIntensity == 0) {
                if (self.userInteractionTimerActivated == false) {
                    self.setupTimer()
                }
            } else {
                if (self.userInteractionTimerActivated == true) {
                        self.userInteractionTimer!.invalidate()
                        self.userInteractionTimerActivated = false
                }
                
                var userInteractionDetectedNotification = NSNotification(name: "userInteractionDetectedNotification", object: nil)
                notificationCenter.postNotification(userInteractionDetectedNotification)
            }
            
            return
        }
        
        var interactionRecognizer : UIGestureRecognizer = UIGestureRecognizer(target: self, action: nil)
        interactionRecognizer.delegate = self
        self.window!.addGestureRecognizer(interactionRecognizer)
        
        return true
    }
    
    func setupTimer () {
        self.userInteractionTimer = nil
        
        dispatch_async(dispatch_get_main_queue(), {
            self.userInteractionTimer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: Selector("handleIdleUser:"), userInfo: nil, repeats: false)
        })
        
        self.userInteractionTimerActivated = true
    }
    
    var idleModeViewController : IdleModeViewController = IdleModeViewController()
    
    func handleIdleUser (timer : NSTimer) {
        idleModeViewController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        idleModeViewController.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        
        if (self.userInteractionTimerActivated == true) {
            self.userInteractionTimer!.invalidate()
            self.userInteractionTimerActivated = false
        }
        
        return false
    }
}

