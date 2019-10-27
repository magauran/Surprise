//
//  AccountHeaderView.swift
//  Surprise
//
//  Created by Alexey Salangin on 10/27/19.
//  Copyright © 2019 Alexey Salangin. All rights reserved.
//

import UIKit

final class AccountHeaderView: UIView {
    typealias ViewModel = AccountHeaderViewModel

    @IBOutlet private var avatarImageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var emailLabel: UILabel!

    func configure(with viewModel: ViewModel) {
        self.nameLabel.text = viewModel.name
        self.emailLabel.text = viewModel.email
    }
}
