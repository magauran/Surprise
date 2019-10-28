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
}
