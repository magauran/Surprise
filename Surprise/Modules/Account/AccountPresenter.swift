//
//  AccountPresenter.swift
//  Surprise
//
//  Created by Alexey Salangin on 10/26/19.
//  Copyright © 2019 Alexey Salangin. All rights reserved.
//

import Foundation

protocol AccountPresentationLogic {
    func presentMenu(_ menuItems: [[MenuItem]])
}

final class AccountPresenter {
    weak var viewController: AccountDispayLogic?
}

extension AccountPresenter: AccountPresentationLogic {
    func presentMenu(_ menuItems: [[MenuItem]]) {
        let menuSections = menuItems.map { items in
            MenuSectionViewModel(items: items.map(Self.makeMenuItemViewModel))
        }
        self.viewController?.displayMenu(viewModel: menuSections)
    }

    // MARK: - ViewModelBuilder
    static func makeMenuItemViewModel(menuItem: MenuItem) -> MenuItemViewModel {
        let title: String
//        let imageName: String

        switch menuItem {
        case .about:
            title = "About us"
        case .settings:
            title = "Settings"
        case .rate:
            title = "Rate us"
        case .help:
            title = "Help"
        case .partners:
            title = "Our partners"
        case .legal:
            title = "Legal"
        }

        return MenuItemViewModel(title: title)
    }
}
