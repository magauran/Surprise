//
//  AppRouter.swift
//  Surprise
//
//  Created by Alexey Salangin on 10/27/19.
//  Copyright © 2019 Alexey Salangin. All rights reserved.
//

import UIKit

final class AppRouter {
    func open(url: URL?) {
        guard let url = url, UIApplication.shared.canOpenURL(url) else {
            return assertionFailure("AppStore and Mail is not available on the simulator. Run on a device.")
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }

    func openSettings() {
        guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else {
            return assertionFailure()
        }
        UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
    }
}
