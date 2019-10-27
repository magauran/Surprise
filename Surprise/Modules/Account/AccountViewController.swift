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
    func displayHeader(viewModel: AccountHeaderViewModel)
}

final class AccountViewController: UIViewController {
    var interactor: AccountBusinessLogic!

    @IBOutlet private var headerView: AccountHeaderView!
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var footerView: AccountBottomView!

    private var menuSections: MenuViewModel = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.interactor.fetchMenuItems()
        self.interactor.fetchUserInfo()
    }

    private func setupTableView() {
        self.tableView.setAndLayoutTableHeaderView(header: self.headerView)
        self.tableView.setAndLayoutTableFooterView(footer: self.footerView)
    }
}

// MARK: - AccountDisplayLogic
extension AccountViewController: AccountDispayLogic {
    func displayMenu(viewModel: MenuViewModel) {
        self.menuSections = viewModel
        self.tableView.reloadData()
    }

    func displayHeader(viewModel: AccountHeaderViewModel) {
        self.headerView.configure(with: viewModel)
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

        let cell: AccountMenuItemCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configure(with: menuItem)

        return cell
    }
}

// MARK: - UITableViewDelegate
extension AccountViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard self.menuSections.indices.contains(indexPath.section) else { return }
        let menuSection = self.menuSections[indexPath.section]
        let menuItems = menuSection.items
        guard menuItems.indices.contains(indexPath.row) else { return }
        let menuItem = menuItems[indexPath.row].item

        self.interactor.openMenuItem(menuItem)

        self.tableView.deselectRow(at: indexPath, animated: true)
    }
}
