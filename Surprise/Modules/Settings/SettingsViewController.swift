//
//  SettingsViewController.swift
//  Surprise
//
//  Created by Alexey Salangin on 10/27/19.
//  Copyright © 2019 Alexey Salangin. All rights reserved.
//

import UIKit
import SPStorkController

protocol SettingsDisplayLogic: AnyObject {
    func updateLanguageButton(language: TourLanguage)
    func updateGeolocationSwitch(isOn: Bool)
    func updateAccount(viewModel: SettingsAccountSectionViewModel)
    func displayChangeNameAlert(currentName: String)
    func showAlertAndOpenSettings()
}

final class SettingsViewController: UIViewController {
    var interactor: SettingsBusinessLogic!
    var router: SettingsRoutingLogic!

    var onClose: (() -> Void)?

    @IBOutlet @Rounded(20) private var englishButton: UIButton!
    @IBOutlet @Rounded(20) private var russianButton: UIButton!
    @IBOutlet private var locationSwitch: UISwitch!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var emailLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.clearStoryboardDefaults()
        self.interactor.fetchSettingsState()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.onClose?()
    }

    @IBAction private func didTapEnglishButton() {
        self.interactor.didSelectLanguage(.english)
    }

    @IBAction private func didTapRussianButton() {
        self.interactor.didSelectLanguage(.russian)
    }

    @IBAction private func switchLocation(_ sender: UISwitch) {
        self.interactor.didChangeGeolocationState(sender.isOn)
    }

    @IBAction private func didTapChangeNameButton() {
        self.interactor.requestChangeName(currentName: self.nameLabel.text ?? "")
    }

    private func clearStoryboardDefaults() {
        self.nameLabel.text = nil
        self.emailLabel.text = nil
    }
}

// MARK: - SettingsDisplayLogic
extension SettingsViewController: SettingsDisplayLogic {
    func updateLanguageButton(language: TourLanguage) {
        switch language {
        case .english:
            self.englishButton.backgroundColor = Style.selectedLanguageButtonColor
            self.russianButton.backgroundColor = Style.normalLanguageButtonColor
        case .russian:
            self.englishButton.backgroundColor = Style.normalLanguageButtonColor
            self.russianButton.backgroundColor = Style.selectedLanguageButtonColor
        }
    }

    func updateGeolocationSwitch(isOn: Bool) {
        self.locationSwitch.isOn = isOn
    }

    func updateAccount(viewModel: SettingsAccountSectionViewModel) {
        self.nameLabel.text = viewModel.name
        self.emailLabel.text = viewModel.email
    }

    func displayChangeNameAlert(currentName: String) {
        self.router.showChangeNameAlert(currentName: currentName) { newName in
            if let newName = newName {
                self.interactor.changeAccountName(newName: newName)
            }
        }
    }

    func showAlertAndOpenSettings() {
        self.router.showAlertAndOpenSettings()
    }
}

// MARK: - UIScrollViewDelegate
extension SettingsViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        SPStorkController.scrollViewDidScroll(scrollView)
    }
}

// MARK: - Style
extension SettingsViewController {
    private enum Style {
        static let selectedLanguageButtonColor = UIColor(named: "languageButton")
        static let normalLanguageButtonColor = UIColor.clear
    }
}
