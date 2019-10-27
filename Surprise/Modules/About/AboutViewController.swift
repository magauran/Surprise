//
//  AboutViewController.swift
//  Surprise
//
//  Created by Alexey Salangin on 10/27/19.
//  Copyright © 2019 Alexey Salangin. All rights reserved.
//

import UIKit

struct AboutItemViewModel {
    let itemTitle: String
    let itemBody: String
}

struct AboutViewModel {
    let appIcon: UIImage?
    let appName: String
    let appDescription: String
    let aboutItems: [AboutItemViewModel]
}

protocol AboutDisplayLogic {
    func displayAboutInfo(viewModel: AboutViewModel)
}

final class AboutViewController: UIViewController {
    typealias ViewModel = AboutViewModel

    var interactor: AboutBusinessLogic!

    @IBOutlet @Rounded(25) private var iconImageView: UIImageView!
    @IBOutlet private var appNameLabel: UILabel!
    @IBOutlet private var appDescriptionLabel: UILabel!
    @IBOutlet private var aboutStackView: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.interactor.fetchAboutInfo()
    }

    private func configure(with viewModel: ViewModel) {
        self.iconImageView.image = viewModel.appIcon
        self.appNameLabel.text = viewModel.appName
        self.appDescriptionLabel.text = viewModel.appDescription
        // TODO: stack view
    }
}

// MARK: - AboutDisplayLogic
extension AboutViewController: AboutDisplayLogic {
    func displayAboutInfo(viewModel: AboutViewModel) {
        self.configure(with: viewModel)
    }
}
