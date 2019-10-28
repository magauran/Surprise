//
//  AccountPresenter.swift
//  Surprise
//
//  Created by Alexey Salangin on 10/26/19.
//  Copyright © 2019 Alexey Salangin. All rights reserved.
//

import Foundation
import class UIKit.UIImage

protocol AccountPresentationLogic {
    func presentMenu(_ menuItems: [[MenuItem]])
    func presentUserInfo(_ profile: Profile)
    func presentAppInfo(bundleVersion: String)
    func showAboutScreen()
    func showSettingsScreen()
    func open(url: URL?)
}

final class AccountPresenter {
    weak var viewController: AccountDispayLogic?
}

// MARK: - AccountPresentationLogic
extension AccountPresenter: AccountPresentationLogic {
    func presentMenu(_ menuItems: [[MenuItem]]) {
        let menuSections = menuItems.map { items in
            MenuSectionViewModel(items: items.map(Self.makeMenuItemViewModel))
        }
        self.viewController?.displayMenu(viewModel: menuSections)
    }

    func presentUserInfo(_ profile: Profile) {
        let accountHeaderViewModel = Self.makeAccountHeaderViewModel(profile: profile)
        self.viewController?.displayHeader(viewModel: accountHeaderViewModel)
    }

    func showAboutScreen() {
        self.viewController?.showAboutScreen()
    }

    func showSettingsScreen() {
        self.viewController?.showSettingsScreen()
    }

    func open(url: URL?) {
        self.viewController?.open(url: url)
    }

    func presentAppInfo(bundleVersion: String) {
        let bundleVersionString = "v " + bundleVersion
        let footerViewModel = AccountFooterViewModel(bundleVersion: bundleVersionString)
        self.viewController?.displayFooter(viewModel: footerViewModel)
    }
}

// MARK: - View Model Generator
extension AccountPresenter {
    static func makeMenuItemViewModel(menuItem: MenuItem) -> MenuItemViewModel {
        let title: String
        let image: UIImage?

        switch menuItem {
        case .about:
            title = "About us"
            image = UIImage(named: "gift")
        case .settings:
            title = "Settings"
            image = UIImage(named: "settings")
        case .rate:
            title = "Rate us"
            image = UIImage(named: "star")
        case .help:
            title = "Help"
            image = UIImage(named: "question")
        case .partners:
            title = "Our partners"
            image = UIImage(named: "disclosure")
        case .legal:
            title = "Legal"
            image = UIImage(named: "disclosure")
        }

        return MenuItemViewModel(item: menuItem, title: title, image: image)
    }

    static func makeAccountHeaderViewModel(profile: Profile) -> AccountHeaderViewModel {
        let viewModel = AccountHeaderViewModel(
            name: profile.firstName,
            email: profile.email,
            avatarURL: profile.avatarURL
        )
        return viewModel
    }
}
