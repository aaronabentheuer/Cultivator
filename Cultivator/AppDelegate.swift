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
var familyMemberArray : [NSDictionary] = []

var smudgeArray : [CGPoint] = []


@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate, UIGestureRecognizerDelegate {

    var window: UIWindow?

    var videoCamera:GPUImageVideoCamera?
    var filter:GPUImageMotionDetector?
    
    var userInteractionTimer : NSTimer?
    var userInteractionTimerActivated : Bool = false

    var backgroundNoiseAudioPlayer : AVAudioPlayer?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        var path = NSBundle.mainBundle().pathForResource("Rezepturen", ofType: "plist")
        var recepies = NSArray(contentsOfFile: path!)!
        
        for recepie in recepies {
            meatArray.append(Meat(ingredients: recepie as! NSDictionary))
        }
        
        var familyPath = NSBundle.mainBundle().pathForResource("FamilyHoffmann", ofType: "plist")
        var familyMembers = NSArray(contentsOfFile: familyPath!)!
        
        for member in familyMembers {
            familyMemberArray.append(member as! NSDictionary)
        }

        videoCamera = GPUImageVideoCamera(sessionPreset: AVCaptureSessionPreset640x480, cameraPosition: .Front)
        videoCamera!.outputImageOrientation = UIInterfaceOrientation.LandscapeLeft;
        filter = GPUImageMotionDetector()
        videoCamera?.addTarget(filter)
        videoCamera?.startCameraCapture()
                
        filter?.motionDetectionBlock = { (motionCentroid : CGPoint, motionIntensity : CGFloat, frameTime : CMTime) in
            
            var normalizedIntensity = motionIntensity*100
            
            if (normalizedIntensity == 0) {
                if (self.userInteractionTimerActivated == false) {
                    self.setupTimer()
                }
            } else {
                if (self.userInteractionTimerActivated == true) {
                    if (self.userInteractionTimer != nil) {
                        self.userInteractionTimer!.invalidate()
                        self.userInteractionTimerActivated = false
                        self.handleAwakeUser()
                    }
                }
        }
            return
        }
    
        var interactionRecognizer : UIGestureRecognizer = UIGestureRecognizer(target: self, action: nil)
        interactionRecognizer.delegate = self
        self.window!.addGestureRecognizer(interactionRecognizer)
        
        backgroundNoiseAudioPlayer = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("Noise", ofType: ".aiff")!), error: nil)
        backgroundNoiseAudioPlayer!.numberOfLoops = -1
        backgroundNoiseAudioPlayer!.volume = 0.2
        backgroundNoiseAudioPlayer!.play()

        
        return true
    }
    
    func setupTimer () {
        self.userInteractionTimer = nil
                
        dispatch_async(dispatch_get_main_queue(), {
            self.userInteractionTimer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: Selector("handleIdleUser:"), userInfo: nil, repeats: false)
        })
        
        self.userInteractionTimerActivated = true
    }
    
    var idleModeViewController : IdleModeViewController = IdleModeViewController()
    
    var userIsIdleNotification = NSNotification(name: "userIsIdleNotification", object: nil)
    var userIsAwakeNotification = NSNotification(name: "userIsAwakeNotification", object: nil)
    
    func handleIdleUser (timer : NSTimer) {
        notificationCenter.postNotification(userIsIdleNotification)
    }
    
    func handleAwakeUser () {
        notificationCenter.postNotification(userIsAwakeNotification)
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        
        smudgeArray.append(touch.locationInView(self.window!))
        
        if (self.userInteractionTimerActivated == true) {
            self.userInteractionTimer!.invalidate()
            self.userInteractionTimerActivated = false
            self.handleAwakeUser()
        }
        
        return false
    }
}

