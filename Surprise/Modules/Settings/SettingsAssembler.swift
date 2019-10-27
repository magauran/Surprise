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
        }

        container.register(SettingsPresentationLogic.self) {
            let view = $0 ~> SettingsViewController.self
            let presenter = SettingsPresenter(view: view)
            return presenter
        }

        container.register(SettingsBusinessLogic.self) {
            let presenter = $0 ~> SettingsPresentationLogic.self
            let interactor = SettingsInteractor(presenter: presenter)
            return interactor
        }
    }
}
