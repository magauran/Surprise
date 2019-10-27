//
//  SettingsViewController.swift
//  Surprise
//
//  Created by Alexey Salangin on 10/27/19.
//  Copyright © 2019 Alexey Salangin. All rights reserved.
//

import UIKit

protocol SettingsDisplayLogic {

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
}

// MARK: - SettingsDisplayLogic
extension SettingsViewController: SettingsDisplayLogic {
    
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
}
