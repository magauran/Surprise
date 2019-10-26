//
//  AccountInteractor.swift
//  Surprise
//
//  Created by Alexey Salangin on 10/26/19.
//  Copyright © 2019 Alexey Salangin. All rights reserved.
//

import Foundation

protocol AccountBusinessLogic {
    func fetchMenuItems()
    func openMenuItem(_ menuItem: MenuItem)
}

enum MenuItem {
    case about, settings, rate, help, partners, legal
}

final class AccountInteractor {
    var presenter: AccountPresentationLogic!
}

extension AccountInteractor: AccountBusinessLogic {
    func fetchMenuItems() {
        let menuItems = [[MenuItem.about, .settings, .rate, .help], [.partners, .legal]]
        self.presenter.presentMenu(menuItems)
    }

    func openMenuItem(_ menuItem: MenuItem) {
        switch menuItem {
        case .about:
            self.presenter.showAboutScreen()
        case .settings:
            self.presenter.showSettingsScreen()
        case .rate:
            let appStoreURL = URL(string: "itms-apps://itunes.apple.com/app/id1054189818")
            self.presenter.open(url: appStoreURL)
        case .help:
            let url = URL(string: "https://surprizeme.ru/support/")
            self.presenter.open(url: url)
        case .partners:
            let url = URL(string: "https://surprizeme.ru/privacy-policy/")
            self.presenter.open(url: url)
        case .legal:
            let url = URL(string: "https://surprizeme.ru/partners/")
            self.presenter.open(url: url)
        }
    }
}
