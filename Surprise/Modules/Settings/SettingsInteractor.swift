//
//  SettingsInteractor.swift
//  Surprise
//
//  Created by Alexey Salangin on 10/28/19.
//  Copyright © 2019 Alexey Salangin. All rights reserved.
//

import Foundation

protocol SettingsBusinessLogic {
    func fetchSettingsState()
    func didSelectLanguage(_ language: TourLanguage)
    func didChangeGeolocationState(_ isEnabled: Bool)
}

enum TourLanguage: String {
    case english = "en_US"
    case russian = "ru_RU"
}

final class SettingsInteractor {
    private let presenter: SettingsPresentationLogic
    private let languageSource: LanguageSource
    private let geolocationSource: GeolocationSource
    private let geolocationService: GeolocationService = GeolocationServiceImpl()

    init(
        presenter: SettingsPresentationLogic,
        languageSource: LanguageSource,
        geolocationSource: GeolocationSource
    ) {
        self.presenter = presenter
        self.languageSource = languageSource
        self.geolocationSource = geolocationSource
    }
}

// MARK: - SettingsBusinessLogic
extension SettingsInteractor: SettingsBusinessLogic {
    func fetchSettingsState() {
        let language = self.languageSource.currentLanguage
        guard let tourLanguage = TourLanguage(rawValue: language) else { return assertionFailure() }
        self.presenter.presentSettings(language: tourLanguage)
    }

    func didSelectLanguage(_ language: TourLanguage) {
        self.languageSource.currentLanguage = language.rawValue
        self.presenter.presentSettings(language: language)
    }

    func didChangeGeolocationState(_ isEnabled: Bool) {
        guard !self.geolocationService.isDenied else {
            self.presenter.openGeoSettings()
            self.presenter.updateGeolocationStatus(isEnabled: false)
            return
        }

        if isEnabled {
            let geolocationEnabled = self.geolocationService.requestPermission()
            if geolocationEnabled {
                self.geolocationSource.isGeolocationEnabled = true
                self.presenter.updateGeolocationStatus(isEnabled: true)
            } else {
                self.presenter.updateGeolocationStatus(isEnabled: false)
            }
        } else {
            self.geolocationSource.isGeolocationEnabled = false
            self.presenter.updateGeolocationStatus(isEnabled: false)
        }
    }
}
