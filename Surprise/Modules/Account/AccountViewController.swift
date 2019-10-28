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
    func displayFooter(viewModel: AccountFooterViewModel)
    func showAboutScreen()
    func showSettingsScreen()
    func open(url: URL?)
}

final class AccountViewController: UIViewController {
    var interactor: AccountBusinessLogic!
    var router: AccountRoutingLogic!

    @IBOutlet private var headerView: AccountHeaderView!
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var footerView: AccountBottomView!
    private let chatButton = UIButton()

    private var menuSections: MenuViewModel = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.setupChatButton()
        self.interactor.fetchMenuItems()
        self.interactor.fetchUserInfo()
        self.interactor.fetchAppInfo()
    }

    private func setupTableView() {
        self.tableView.setAndLayoutTableHeaderView(header: self.headerView)
        self.tableView.setAndLayoutTableFooterView(footer: self.footerView)
    }

    private func setupChatButton() {
        // TODO: Custom view or extract to Style
        self.chatButton.setImage(UIImage(named: "chat"), for: .normal)
        self.chatButton.tintColor = UIColor(named: "chatButton")
        self.chatButton.addTarget(self, action: #selector(self.didTapChatButton), for: .touchUpInside)
        self.chatButton.imageEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        self.chatButton.layer.cornerRadius = 30
        self.chatButton.layer.masksToBounds = false
        self.chatButton.backgroundColor = .white
        self.chatButton.layer.shadowColor = UIColor.lightGray.cgColor
        self.chatButton.layer.shadowRadius = 2
        self.chatButton.layer.shadowOpacity = 0.3
        self.chatButton.layer.shadowOffset = .zero
        self.chatButton.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(self.chatButton)

        NSLayoutConstraint.activate([
            self.chatButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16),
            self.chatButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor,
                                                    constant: -24),
            self.chatButton.heightAnchor.constraint(equalToConstant: 60),
            self.chatButton.widthAnchor.constraint(equalToConstant: 60),
        ])
    }

    @objc
    private func didTapChatButton() {
        self.router.openMailApp()
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

    func displayFooter(viewModel: AccountFooterViewModel) {
        self.footerView.configure(with: viewModel)
    }

    func showAboutScreen() {
        self.router.showAboutScreen()
    }

    func showSettingsScreen() {
        self.router.showSettingsScreen {
            self.interactor.fetchUserInfo()
        }
    }

    func open(url: URL?) {
        self.router.open(url: url)
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
