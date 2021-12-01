//
//  AppDelegate.swift
//  SCR
//
//  Created by 최제환 on 2021/12/01.
//

import UIKit
import ModernRIBs

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    private var launchRouter: LaunchRouting?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        
        let launchRouter = AppRootBuilder(dependency: AppComponent()).build()
        self.launchRouter = launchRouter
        self.launchRouter?.launch(from: window)
        
        return true
    }
}

