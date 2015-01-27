//
//  AppDelegate.swift
//  Cultivator
//
//  Created by Julian Abentheuer on 21.01.15.
//  Copyright (c) 2015 Aaron Abentheuer. All rights reserved.
//

import UIKit
import GPUImage

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UIGestureRecognizerDelegate {

    var window: UIWindow?

    var videoCamera:GPUImageVideoCamera?
    var filter:GPUImageMotionDetector?
    
    var userInteractionTimer : NSTimer?
    var userInteractionTimerActivated : Bool = false
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        videoCamera = GPUImageVideoCamera(sessionPreset: AVCaptureSessionPreset640x480, cameraPosition: .Front)
        videoCamera!.outputImageOrientation = UIInterfaceOrientation.LandscapeLeft;
        filter = GPUImageMotionDetector()
        videoCamera?.addTarget(filter)
        videoCamera?.startCameraCapture()
        
        userInteractionTimer = NSTimer(timeInterval: 3, target: self, selector: Selector("handleIdleUser:"), userInfo: nil, repeats: false)
        
        var userInteractionDetectedNotification = NSNotification(name: "userInteractionDetectedNotification", object: self)
        var userIdleDetectedNotification = NSNotification(name: "userIdleDetectedNotification", object: self)
        
        
        filter?.motionDetectionBlock = { (motionCentroid : CGPoint, motionIntensity : CGFloat, frameTime : CMTime) in
            
            if (motionIntensity == 0.0) {
                if (self.userInteractionTimerActivated == false) {
                    self.setupTimer()
                }
            } else {
                if (self.userInteractionTimer != nil) {
                    if (self.userInteractionTimer!.valid) {
//                        self.userInteractionTimer!.invalidate()
                        self.userInteractionTimerActivated = false
                    }
                }
            }
            
//            println(self.userInteractionTimer!.valid)
            
            return
        }
        
        var interactionRecognizer : UIGestureRecognizer = UIGestureRecognizer(target: self, action: nil)
        interactionRecognizer.delegate = self
        self.window!.addGestureRecognizer(interactionRecognizer)
        
        return true
    }
    
    func setupTimer () {
        println("setup")
        
        var vc : ViewController = ViewController()
        
        if (viewIsReady) {
            println("ready")
            NSRunLoop.currentRunLoop().addTimer(userInteractionTimer!, forMode: NSRunLoopCommonModes)
            self.userInteractionTimerActivated = true
        }
        
        println(userInteractionTimer!.valid)
    }
    
    func handleIdleUser (timer : NSTimer) {
        println("handled")
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        if (userInteractionTimer != nil) {
            if (userInteractionTimer!.valid) {
//                userInteractionTimer!.invalidate()
                userInteractionTimerActivated = false
            }
        }
        
        return false
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }


    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

