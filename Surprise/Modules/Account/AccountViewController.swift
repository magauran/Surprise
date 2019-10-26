//
//  AccountViewController.swift
//  Surprise
//
//  Created by Alexey Salangin on 10/26/19.
//  Copyright © 2019 Alexey Salangin. All rights reserved.
//

import UIKit

protocol AccountDispayLogic: UIViewController {
    func displayMenu(viewModel: MenuViewModel)
}

final class AccountViewController: UIViewController {
    var interactor: AccountBusinessLogic!

    @IBOutlet private var tableView: UITableView!
    private var menuSections: MenuViewModel = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.interactor.fetchMenuItems()
    }
}

// MARK: - AccountDisplayLogic
extension AccountViewController: AccountDispayLogic {
    func displayMenu(viewModel: MenuViewModel) {
        self.menuSections = viewModel
        self.tableView.reloadData()
    }
}

// MARK: - UITableViweDataSource
extension AccountViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.menuSections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard self.menuSections.indices.contains(section) else { return 0 }
        let menuSection = self.menuSections[section]
        return menuSection.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard self.menuSections.indices.contains(indexPath.section) else { return UITableViewCell() }
        let menuSection = self.menuSections[indexPath.section]
        let menuItems = menuSection.items
        guard menuItems.indices.contains(indexPath.row) else { return UITableViewCell() }
        let menuItem = menuItems[indexPath.row]

        let cell = UITableViewCell()
        cell.textLabel?.text = menuItem.title
        return cell
    }
}

// MARK: - UITableViewDelegate
extension AccountViewController: UITableViewDelegate {

}