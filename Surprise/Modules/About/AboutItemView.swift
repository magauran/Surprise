//
//  AboutItemView.swift
//  Surprise
//
//  Created by Alexey Salangin on 10/27/19.
//  Copyright © 2019 Alexey Salangin. All rights reserved.
//

import UIKit

final class AboutItemView: UIView {
    private let bodyLabel = UILabel()
    private let titleLabel = UILabel()

    init(viewModel: AboutItemViewModel) {
        super.init(frame: .zero)
        self.setupSubviews()
        self.configure(with: viewModel)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        assertionFailure("init(coder:) has not been implemented")
        return nil
    }

    private func setupSubviews() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        self.addSubview(stackView)

        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.leftAnchor.constraint(equalTo: self.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: self.rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])

        stackView.addArrangedSubview(self.titleLabel)
        stackView.addArrangedSubview(self.bodyLabel)

        stackView.spacing = 10
    }

    private func configure(with viewModel: AboutItemViewModel) {
        let titleParagraphStyle = NSMutableParagraphStyle()
        titleParagraphStyle.minimumLineHeight = 22
        titleParagraphStyle.maximumLineHeight = 22

        self.titleLabel.numberOfLines = 0
        self.titleLabel.attributedText = NSMutableAttributedString(
            string: viewModel.itemTitle,
            attributes: [
                .paragraphStyle: titleParagraphStyle,
                .font: UIFont.boldSystemFont(ofSize: 20)
            ]
        )

        let bodyParagraphStyle = NSMutableParagraphStyle()
        bodyParagraphStyle.minimumLineHeight = 20
        bodyParagraphStyle.maximumLineHeight = 20
        self.bodyLabel.numberOfLines = 0
        self.bodyLabel.attributedText = NSMutableAttributedString(
            string: viewModel.itemBody,
            attributes: [
                .paragraphStyle: bodyParagraphStyle,
                .font: UIFont.systemFont(ofSize: 16),
                .foregroundColor: UIColor.gray
            ]
        )
    }
}
