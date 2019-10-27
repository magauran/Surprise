//
//  SettingsPresenter.swift
//  Surprise
//
//  Created by Alexey Salangin on 10/28/19.
//  Copyright © 2019 Alexey Salangin. All rights reserved.
//

import Foundation

protocol SettingsPresentationLogic {
    func presentSettings(language: TourLanguage)
}

final class SettingsPresenter {
    private let view: SettingsDisplayLogic

    init(view: SettingsDisplayLogic) {
        self.view = view
    }
}

// MARK: - SettingsPresentationLogic
extension SettingsPresenter: SettingsPresentationLogic {
    func presentSettings(language: TourLanguage) {
        self.view.updateLanguageButton(language: language)
    }
}
