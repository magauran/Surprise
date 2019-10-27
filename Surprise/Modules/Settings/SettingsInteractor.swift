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
}

enum TourLanguage: String {
    case english = "en_US"
    case russian = "ru_RU"
}

final class SettingsInteractor {
    private let presenter: SettingsPresentationLogic
    private let languageSource: LanguageSource

    init(presenter: SettingsPresentationLogic, languageSource: LanguageSource) {
        self.presenter = presenter
        self.languageSource = languageSource
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
}
