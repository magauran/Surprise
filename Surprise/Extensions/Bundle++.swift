//
//  Bundle++.swift
//  Surprise
//
//  Created by Alexey Salangin on 10/28/19.
//  Copyright © 2019 Alexey Salangin. All rights reserved.
//

import Foundation

extension Bundle {
    var versionString: String {
        guard
            let version = self.object(
                forInfoDictionaryKey: "CFBundleShortVersionString"
            ) as? String
        else {
            assertionFailure()
            return ""
        }
        return version
    }
}
