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
    func updateGeolocationStatus(isEnabled: Bool)
    func openGeoSettings()
}

final class SettingsPresenter {
    private let view: SettingsDisplayLogic
    private let router: SettingsRoutingLogic

    init(view: SettingsDisplayLogic, router: SettingsRoutingLogic) {
        self.view = view
        self.router = router
    }
}

// MARK: - SettingsPresentationLogic
extension SettingsPresenter: SettingsPresentationLogic {
    func presentSettings(language: TourLanguage) {
        self.view.updateLanguageButton(language: language)
    }

    func updateGeolocationStatus(isEnabled: Bool) {
        self.view.updateGeolocationSwitch(isOn: isEnabled)
    }

    func openGeoSettings() {
        self.router.showAlertAndOpenSettings()
    }
}
