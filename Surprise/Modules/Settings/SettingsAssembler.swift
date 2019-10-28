//
//  SettingsAssembler.swift
//  Surprise
//
//  Created by Alexey Salangin on 10/27/19.
//  Copyright © 2019 Alexey Salangin. All rights reserved.
//

import Swinject
import SwinjectAutoregistration

struct SettingsAssembler {
    var resolver: Resolver { self.assembler.resolver }
    let assembler: Assembler

    init(parent: Assembler?) {
        self.assembler = Assembler([SettingsAssembly()], parent: parent)
    }
}

private struct SettingsAssembly: Assembly {
    func assemble(container: Container) {
        container.register(SettingsViewController.self) { _ in
            UIStoryboard.settings.instantiate()
        }.initCompleted {
            $1.interactor = $0 ~> SettingsBusinessLogic.self
            $1.router = $0 ~> SettingsRoutingLogic.self
        }

        container.register(SettingsPresentationLogic.self) {
            let view = $0 ~> SettingsViewController.self
            let presenter = SettingsPresenter(view: view)
            return presenter
        }

        container.register(SettingsBusinessLogic.self) {
            let presenter = $0 ~> SettingsPresentationLogic.self
            let languageSource = $0 ~> LanguageSource.self
            let geolocationSource = $0 ~> GeolocationSource.self
            let geolocationService = GeolocationServiceImpl()
            let accountService = $0 ~> AccountService.self
            let interactor = SettingsInteractor(
                presenter: presenter,
                languageSource: languageSource,
                geolocationSource: geolocationSource,
                geolocationService: geolocationService,
                accountService: accountService
            )
            return interactor
        }

        container.register(SettingsRoutingLogic.self) {
            let view = $0 ~> SettingsViewController.self
            let appRouter = $0 ~> AppRouter.self
            let router = SettingsRouter(transitionHandler: view, appRouter: appRouter)
            return router
        }
    }
}
