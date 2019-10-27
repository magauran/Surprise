//
//  AppConfig.swift
//  Surprise
//
//  Created by Alexey Salangin on 10/27/19.
//  Copyright © 2019 Alexey Salangin. All rights reserved.
//

import Foundation

struct AppConfig {
    // swiftlint:disable:next force_unwrapping
    static let baseURL = URL(string: "https://app.surprizeme.ru/api/")!
}

extension AppConfig: TokenSource {
    var token: String? { "b08ec419bc777ba24264ec5cd426b874c89e4c34" }
}
