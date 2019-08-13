//
//  AppDelegate.swift
//
//  Created by Tim Studt on 13/03/2018.
//  Copyright © 2018 Tim Studt. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appRouter: AppRouter!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        setupAppRouter()

        return true
    }

    private func setupAppRouter() {
        appRouter = AppRouter(window: window)
        appRouter.show(scene: .movieCollection)
    }
}
