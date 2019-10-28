//
//  AccountHeaderView.swift
//  Surprise
//
//  Created by Alexey Salangin on 10/27/19.
//  Copyright © 2019 Alexey Salangin. All rights reserved.
//

import UIKit
import Kingfisher

final class AccountHeaderView: UIView {
    typealias ViewModel = AccountHeaderViewModel

    @IBOutlet private var avatarImageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var emailLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.clearStoryboardDefaults()
    }

    func configure(with viewModel: ViewModel) {
        self.nameLabel.text = viewModel.name
        self.emailLabel.text = viewModel.email

        let processor = self.makeImageProcessor()
        self.avatarImageView.kf.indicatorType = .activity
        self.avatarImageView.kf.setImage(
            with: viewModel.avatarURL,
            placeholder: nil,
            options: [
                .processor(processor),
                .backgroundDecode,
            ]
        )
    }

    private func clearStoryboardDefaults() {
        self.nameLabel.text = nil
        self.emailLabel.text = nil
    }
}

// MARK: - Factory
extension AccountHeaderView {
    private func makeImageProcessor() -> ImageProcessor {
        return DownsamplingImageProcessor(size: self.avatarImageView.frame.size)
            |> RoundCornerImageProcessor(cornerRadius: self.avatarImageView.frame.size.width / 2)
    }
}
