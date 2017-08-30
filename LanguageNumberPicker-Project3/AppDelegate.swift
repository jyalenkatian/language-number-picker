//
//  AppDelegate.swift
//  LanguageNumberPicker-Project3
//
//  Created by Joseph Yalenkatian on 2/1/17.
//  Copyright © 2017 Joseph Yalenkatian. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //This code will set the status bar text color to white
        UIApplication.shared.statusBarStyle = .lightContent
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        //showAlertAppDelegate is a function to display an UIAlert to the View Controller. The alert will be called with an Instructions Message for the user. The alert will appear each time the app is opened (i.e. launched for the first time or when opened again after pressing the home button
        
        func showAlertAppDelegate(title : String, message : String, buttonTitle : String,window: UIWindow){
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: buttonTitle, style: UIAlertActionStyle.default, handler: nil))
            window.rootViewController?.present(alert, animated: true, completion: nil)
        }
        showAlertAppDelegate(title: "Instructions - Instrucciones",message: "Match the numbers in all three columns.\nEmparejar los números en las tres columnas.", buttonTitle: "OK",window: self.window!);
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

