//
//  SettingsViewController.swift
//  Surprise
//
//  Created by Alexey Salangin on 10/27/19.
//  Copyright © 2019 Alexey Salangin. All rights reserved.
//

import UIKit
import SPStorkController

protocol SettingsDisplayLogic {
    func updateLanguageButton(language: TourLanguage)
    func updateGeolocationSwitch(isOn: Bool)
}

final class SettingsViewController: UITableViewController {
    var interactor: SettingsBusinessLogic!

    @IBOutlet @Rounded(20) private var englishButton: UIButton!
    @IBOutlet @Rounded(20) private var russianButton: UIButton!
    @IBOutlet private var switch1: UISwitch!
    @IBOutlet private var switch2: UISwitch!
    @IBOutlet private var nameTextField: UITextField!
    @IBOutlet private var emailLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.interactor.fetchSettingsState()
    }

    @IBAction private func didTapEnglishButton() {
        self.interactor.didSelectLanguage(.english)
    }

    @IBAction private func didTapRussianButton() {
        self.interactor.didSelectLanguage(.russian)
    }

    @IBAction private func switchSomething(_ sender: UISwitch) {
        self.interactor.didChangeGeolocationState(sender.isOn)
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
        self.switch1.isOn = isOn
    }
}

// MARK: - UITableViewDelegate
extension SettingsViewController {
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    override func tableView(
        _ tableView: UITableView,
        willDisplayHeaderView view: UIView,
        forSection section: Int
    ) {
        guard let headerView = view as? UITableViewHeaderFooterView else { return }
        headerView.textLabel?.font = .systemFont(ofSize: 18, weight: .heavy)
        headerView.textLabel?.text = headerView.textLabel?.text?.lowercased().capitalized
        headerView.textLabel?.textColor = .black
    }

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
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
