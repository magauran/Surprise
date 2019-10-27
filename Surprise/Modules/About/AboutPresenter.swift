//
//  AboutPresenter.swift
//  Surprise
//
//  Created by Alexey Salangin on 10/27/19.
//  Copyright © 2019 Alexey Salangin. All rights reserved.
//

import UIKit

protocol AboutPresentationLogic {
    func presentAboutInfo()
}

final class AboutPresenter {
    private let view: AboutDisplayLogic

    init(view: AboutDisplayLogic) {
        self.view = view
    }
}

extension AboutPresenter: AboutPresentationLogic {
    func presentAboutInfo() {
        let viewModel = Self.makeViewModel()
        self.view.displayAboutInfo(viewModel: viewModel)
    }
}

// MARK: - View Model Generator
extension AboutPresenter {
    private static func makeViewModel() -> AboutViewModel {
        let viewModel = AboutViewModel(
            appIcon: UIApplication.appIcon,
            appName: UIApplication.appName ?? "",
            appDescription: "Your personal interactive tour guide",
            aboutItems: []
        )
        return viewModel
    }
}
