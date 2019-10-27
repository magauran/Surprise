//
//  AccountRouter.swift
//  Surprise
//
//  Created by Alexey Salangin on 10/27/19.
//  Copyright © 2019 Alexey Salangin. All rights reserved.
//

import UIKit
import Swinject
import SwinjectAutoregistration

protocol AccountRoutingLogic {
    func open(url: URL?)
    func showAboutScreen()
    func showSettingsScreen()
}

final class AccountRouter {
    private let transitionHandler: UIViewController
    private let appRouter: AppRouter
    private let aboutAssembler: Assembler
    private let settingsAssembler: Assembler

    init(
        transitionHandler: UIViewController,
        appRouter: AppRouter,
        aboutAssembler: Assembler,
        settingsAssembler: Assembler
    ) {
        self.transitionHandler = transitionHandler
        self.appRouter = appRouter
        self.aboutAssembler = aboutAssembler
        self.settingsAssembler = settingsAssembler
    }
}

extension AccountRouter: AccountRoutingLogic {
    func open(url: URL?) {
        self.appRouter.open(url: url)
    }

    func showAboutScreen() {
        let aboutViewController = self.aboutAssembler.resolver ~> AboutViewController.self
        self.transitionHandler.present(aboutViewController, animated: true, completion: nil)
    }

    func showSettingsScreen() {
        let settingsViewController = self.settingsAssembler.resolver ~> SettingsViewController.self
        self.transitionHandler.present(settingsViewController, animated: true, completion: nil)
    }
}
