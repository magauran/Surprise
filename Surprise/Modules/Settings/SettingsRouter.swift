//
//  SettingsRouter.swift
//  Surprise
//
//  Created by Alexey Salangin on 10/28/19.
//  Copyright © 2019 Alexey Salangin. All rights reserved.
//

import UIKit

protocol SettingsRoutingLogic {
    func showAlertAndOpenSettings()
    func showChangeNameAlert(currentName: String, then handler: @escaping (String?) -> Void)
}

final class SettingsRouter {
    private weak var transitionHandler: UIViewController?
    private let appRouter: AppRouter

    init(transitionHandler: UIViewController, appRouter: AppRouter) {
        self.transitionHandler = transitionHandler
        self.appRouter = appRouter
    }
}

extension SettingsRouter: SettingsRoutingLogic {
    func showAlertAndOpenSettings() {
        let alertController = UIAlertController(
            title: "Localization usage permission is required",
            message: "Please go to Settings and turn on the permissions",
            preferredStyle: .alert
        )
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.appRouter.openSettings()
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { _ in

        }))

        self.transitionHandler?.present(alertController, animated: true, completion: nil)
    }

    func showChangeNameAlert(currentName: String, then handler: @escaping (String?) -> Void) {
        let alertController = UIAlertController(
            title: "Change name",
            message: "Input new account name",
            preferredStyle: .alert
        )
        alertController.addAction(UIAlertAction(title: "Change", style: .default, handler: { _ in
            handler(alertController.textFields?.first?.text)
        }))

        alertController.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { _ in
            handler(nil)
        }))

        alertController.addTextField { textField in
            textField.text = currentName
        }

        self.transitionHandler?.present(alertController, animated: true, completion: nil)
    }
}
