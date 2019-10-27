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
            aboutItems: [
                AboutItemViewModel(itemTitle: "Our mission", itemBody: self.mockItemBody),
                AboutItemViewModel(itemTitle: "Second line", itemBody: self.mockItemBody),
            ]
        )
        return viewModel
    }

    // swiftlint:disable line_length
    private static var mockItemBody: String = """
    A walk through Rome for the ones who want to jump into ancient times and explore them carefully. Let's go back to the ages of B.C. to see how lived the immortal city then, how it was born and what happened to it.
    Visit the world-famous Colosseum where gladiator fights once were held. You'll have a chance to see the ancient temple of Venus and Roma and the house of Vestal Virgins. Take a look at the Roman Forum, the former political center of the city, and Trajan's market, which was a giant shopping mall in the past.
    Put on your sunglasses, prepare your cameras for spectacular views and amazing pictures and get ready to travel to the past!
    """
    // swiftlint:enable line_length
}
