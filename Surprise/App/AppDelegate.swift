//
//  AppDelegate.swift
//  Surprise
//
//  Created by Alexey Salangin on 10/26/19.
//  Copyright © 2019 Alexey Salangin. All rights reserved.
//

import UIKit
import Swinject
import SwinjectAutoregistration

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    let assembler = AppAssembler(parent: nil)

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = self.assembler.resolver ~> UIViewController.self
        self.window?.makeKeyAndVisible()

        self.setupAppearance()

        return true
    }

    private func setupAppearance() {
        self.window?.tintColor = UIColor(named: "base")
    }
}
