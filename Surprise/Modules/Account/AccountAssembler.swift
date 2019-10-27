//
//  AccountAssembler.swift
//  Surprise
//
//  Created by Alexey Salangin on 10/27/19.
//  Copyright © 2019 Alexey Salangin. All rights reserved.
//

import Swinject
import SwinjectAutoregistration

struct AccountAssembler {
    var resolver: Resolver { self.assembler.resolver }
    let assembler: Assembler

    init(parent: Assembler?) {
        self.assembler = Assembler([AccountAssembly()], parent: parent)
    }
}

private struct AccountAssembly: Assembly {
    func assemble(container: Container) {
        container.register(AccountViewController.self) { _ in
            UIStoryboard.account.instantiate()
        }.initCompleted {
            $1.interactor = $0 ~> AccountBusinessLogic.self
        }

        container.register(AccountBusinessLogic.self) {
            let interactor = AccountInteractor()
            interactor.presenter = $0 ~> AccountPresentationLogic.self
            return interactor
        }

        container.register(AboutAssembler.self) {
            let appAssembler = $0 ~> AppAssembler.self
            return AboutAssembler(parent: appAssembler.assembler)
        }

        container.register(SettingsAssembler.self) {
            let appAssembler = $0 ~> AppAssembler.self
            return SettingsAssembler(parent: appAssembler.assembler)
        }

        container.register(AccountRoutingLogic.self) {
            let viewController = $0 ~> AccountViewController.self
            let appRouter = $0 ~> AppRouter.self
            let aboutAssembler = $0 ~> AboutAssembler.self
            let settingsAssembler = $0 ~> SettingsAssembler.self
            return AccountRouter(
                transitionHandler: viewController,
                appRouter: appRouter,
                aboutAssembler: aboutAssembler.assembler,
                settingsAssembler: settingsAssembler.assembler
            )
        }

        container.register(AccountPresentationLogic.self) {
            let presenter = AccountPresenter()
            presenter.viewController = $0 ~> AccountViewController.self
            presenter.router = $0 ~> AccountRoutingLogic.self
            return presenter
        }
    }
}
