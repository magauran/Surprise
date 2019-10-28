//
//  AppConfig.swift
//  Surprise
//
//  Created by Alexey Salangin on 10/27/19.
//  Copyright © 2019 Alexey Salangin. All rights reserved.
//

import Foundation

protocol LanguageSource: AnyObject {
    var currentLanguage: String { get set }
}

protocol GeolocationSource: AnyObject {
    var isGeolocationEnabled: Bool { get set }
}

final class AppConfig: LanguageSource, GeolocationSource {
    // swiftlint:disable:next force_unwrapping
    static let baseURL = URL(string: "https://app.surprizeme.ru/api/")!

    // MARK: - LanguageSource
    @UserDefault("current_language", defaultValue: "en_US")
    var currentLanguage: String

    // MARK: - GeolocationSource
    @UserDefault("geolocation", defaultValue: false)
    var isGeolocationEnabled: Bool
}

extension AppConfig: TokenSource {
    var token: String? { "b08ec419bc777ba24264ec5cd426b874c89e4c34" }
}
