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
}
