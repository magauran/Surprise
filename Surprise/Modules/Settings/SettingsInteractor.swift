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
    func requestChangeName(currentName: String)
    func changeAccountName(newName: String)
}

enum TourLanguage: String {
    case english = "en_US"
    case russian = "ru_RU"
}

final class SettingsInteractor {
    private let presenter: SettingsPresentationLogic
    private let languageSource: LanguageSource
    private let geolocationSource: GeolocationSource
    private let geolocationService: GeolocationService
    private let accountService: AccountService

    init(
        presenter: SettingsPresentationLogic,
        languageSource: LanguageSource,
        geolocationSource: GeolocationSource,
        geolocationService: GeolocationService,
        accountService: AccountService
    ) {
        self.presenter = presenter
        self.languageSource = languageSource
        self.geolocationSource = geolocationSource
        self.geolocationService = geolocationService
        self.accountService = accountService
    }
}

// MARK: - SettingsBusinessLogic
extension SettingsInteractor: SettingsBusinessLogic {
    func fetchSettingsState() {
        let language = self.languageSource.currentLanguage
        guard let tourLanguage = TourLanguage(rawValue: language) else { return assertionFailure() }
        self.presenter.presentSettings(language: tourLanguage)

        let geolocationEnabled = self.geolocationSource.isGeolocationEnabled
        self.presenter.updateGeolocationStatus(isEnabled: geolocationEnabled)

        self.fetchAccountInfo()
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
            self.geolocationService.requestPermission { [weak self] geolocationEnabled in
                guard let self = self else { return }
                self.updateGeolocationStatus(isEnabled: geolocationEnabled)
            }
        } else {
            self.updateGeolocationStatus(isEnabled: false)
        }
    }

    func requestChangeName(currentName: String) {
        self.presenter.presentChangeNameAlert(currentName: "")
    }

    func changeAccountName(newName: String) {

    }
}

extension SettingsInteractor {
    private func updateGeolocationStatus(isEnabled: Bool) {
        self.geolocationSource.isGeolocationEnabled = isEnabled
        self.presenter.updateGeolocationStatus(isEnabled: isEnabled)
    }

    private func fetchAccountInfo() {
        self.accountService.fetchAccount { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let profile):
                DispatchQueue.main.async {
                    self.presenter.updateAccountInfo(profile)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
