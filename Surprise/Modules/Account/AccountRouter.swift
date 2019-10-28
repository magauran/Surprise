//
//  AccountRouter.swift
//  Surprise
//
//  Created by Alexey Salangin on 10/27/19.
//  Copyright © 2019 Alexey Salangin. All rights reserved.
//

import UIKit
import SPStorkController
import Swinject
import SwinjectAutoregistration

protocol AccountRoutingLogic {
    func open(url: URL?)
    func showAboutScreen()
    func showSettingsScreen(onClose: @escaping () -> Void)
}

final class AccountRouter {
    private weak var transitionHandler: UIViewController?
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

// MARK: - AccountRoutingLogic
extension AccountRouter: AccountRoutingLogic {
    func open(url: URL?) {
        self.appRouter.open(url: url)
    }

    func showAboutScreen() {
        let aboutViewController = self.aboutAssembler.resolver ~> AboutViewController.self

        let transitionDelegate = Self.makeTransitioningDelegate()
        aboutViewController.transitioningDelegate = transitionDelegate
        aboutViewController.modalPresentationStyle = .custom
        aboutViewController.modalPresentationCapturesStatusBarAppearance = true

        self.transitionHandler?.present(aboutViewController, animated: true, completion: nil)
    }

    func showSettingsScreen(onClose: @escaping () -> Void) {
        let settingsViewController = self.settingsAssembler.resolver ~> SettingsViewController.self
        settingsViewController.onClose = onClose

        let transitionDelegate = Self.makeTransitioningDelegate()
        settingsViewController.transitioningDelegate = transitionDelegate
        settingsViewController.modalPresentationStyle = .custom
        settingsViewController.modalPresentationCapturesStatusBarAppearance = true

        self.transitionHandler?.present(settingsViewController, animated: true, completion: nil)
    }
}

// MARK: - Factory
extension AccountRouter {
    static func makeTransitioningDelegate() -> SPStorkTransitioningDelegate {
        let transitionDelegate = SPStorkTransitioningDelegate()
        transitionDelegate.indicatorMode = .alwaysLine
        transitionDelegate.cornerRadius = 25
        return transitionDelegate
    }
}
