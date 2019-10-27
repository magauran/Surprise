//
//  UIApplication++.swift
//  Surprise
//
//  Created by Alexey Salangin on 10/27/19.
//  Copyright © 2019 Alexey Salangin. All rights reserved.
//

import UIKit

extension UIApplication {
    static var appName: String? {
        guard let name = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String else {
            assertionFailure()
            return nil
        }
        return name
    }
}

extension UIApplication {
    static var appIcon: UIImage? {
        guard
            let iconsDictionary = Bundle.main.infoDictionary?["CFBundleIcons"] as? [String: Any],
            let primaryIconsDictionary = iconsDictionary["CFBundlePrimaryIcon"] as? [String: Any],
            let iconFiles = primaryIconsDictionary["CFBundleIconFiles"] as? [String],
            let lastIcon = iconFiles.last
        else { return nil }
        return UIImage(named: lastIcon)
    }
}
