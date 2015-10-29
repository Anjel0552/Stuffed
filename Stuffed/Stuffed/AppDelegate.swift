//
//  AppDelegate.swift
//  Stuffed
//
//  Created by Anjel Villafranco on 10/27/15.
//  Copyright © 2015 Anjel Villafranco. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        switch UIDevice.currentDevice().userInterfaceIdiom {
        
        case .Pad :
            
            // use game board
            let storyboard = UIStoryboard(name: "GameBoard", bundle: nil)
            
            window?.rootViewController = storyboard.instantiateInitialViewController()
            
        case.Phone :
            
            // use game pad
            let storyboard = UIStoryboard(name: "GamePad", bundle: nil)
            
            window?.rootViewController = storyboard.instantiateInitialViewController()
            
        case .TV :
            
            print("to be added")
            
        case .Unspecified :
            
            print("going to crash... fuck you")
            
            
            
        
        }
        
        
        
        print(UIDevice.currentDevice().userInterfaceIdiom)
        
//        window?.rootViewController = UIViewController()
        
        window?.makeKeyAndVisible()
        
        return true
    }
}

