//
//  AccountRouter.swift
//  Surprise
//
//  Created by Alexey Salangin on 10/27/19.
//  Copyright © 2019 Alexey Salangin. All rights reserved.
//

import UIKit

protocol AccountRoutingLogic {
    func open(url: URL?)
}

final class AccountRouter {
    private let transitionHandler: UIViewController
    private let appRouter: AppRouter

    init(transitionHandler: UIViewController, appRouter: AppRouter) {
        self.transitionHandler = transitionHandler
        self.appRouter = appRouter
    }
}

extension AccountRouter: AccountRoutingLogic {
    func open(url: URL?) {
        self.appRouter.open(url: url)
    }
}
