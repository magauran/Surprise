//
//  AboutInteractor.swift
//  Surprise
//
//  Created by Alexey Salangin on 10/27/19.
//  Copyright © 2019 Alexey Salangin. All rights reserved.
//

import Foundation

protocol AboutBusinessLogic {
    func fetchAboutInfo()
}

final class AboutInteractor {
    private let presenter: AboutPresentationLogic

    init(presenter: AboutPresentationLogic) {
        self.presenter = presenter
    }
}

extension AboutInteractor: AboutBusinessLogic {
    func fetchAboutInfo() {
        // Do nothing, because we show static data
        self.presenter.presentAboutInfo()
    }
}
