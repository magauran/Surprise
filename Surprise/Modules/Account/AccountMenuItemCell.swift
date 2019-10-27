//
//  AccountMenuItemCell.swift
//  Surprise
//
//  Created by Alexey Salangin on 10/27/19.
//  Copyright © 2019 Alexey Salangin. All rights reserved.
//

import UIKit

final class AccountMenuItemCell: UITableViewCell {
    typealias ViewModel = MenuItemViewModel

    private enum Style {
        static let accessoryViewSize = CGSize(width: 20, height: 20)
        static let accessoryViewColor = UIColor.black
    }

    func configure(with viewModel: ViewModel) {
        self.textLabel?.text = viewModel.title
        if let image = viewModel.image {
            let accessoryView = UIImageView(frame: CGRect(origin: .zero, size: Style.accessoryViewSize))
            accessoryView.image = image
            self.accessoryView = accessoryView
        }
        self.accessoryView?.tintColor = Style.accessoryViewColor
    }
}
