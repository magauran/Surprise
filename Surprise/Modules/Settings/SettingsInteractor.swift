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
}

final class SettingsInteractor {
    private let presenter: SettingsPresentationLogic

    init(presenter: SettingsPresentationLogic) {
        self.presenter = presenter
    }
}

// MARK: - SettingsBusinessLogic
extension SettingsInteractor: SettingsBusinessLogic {
    func fetchSettingsState() {

    }
}
