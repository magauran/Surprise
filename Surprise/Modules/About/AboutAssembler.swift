//
//  AboutAssembler.swift
//  Surprise
//
//  Created by Alexey Salangin on 10/27/19.
//  Copyright © 2019 Alexey Salangin. All rights reserved.
//

import Swinject
import SwinjectAutoregistration

struct AboutAssembler {
    var resolver: Resolver { self.assembler.resolver }
    let assembler: Assembler

    init(parent: Assembler?) {
        self.assembler = Assembler([AboutAssembly()], parent: parent)
    }
}

private struct AboutAssembly: Assembly {
    func assemble(container: Container) {
        container.register(AboutViewController.self) { _ in
            UIStoryboard.about.instantiate()
        }.initCompleted {
            $1.interactor = $0 ~> AboutBusinessLogic.self
        }

        container.register(AboutBusinessLogic.self) {
            let presenter = $0 ~> AboutPresentationLogic.self
            let interactor = AboutInteractor(presenter: presenter)
            return interactor
        }

        container.register(AboutPresentationLogic.self) {
            let view = $0 ~> AboutViewController.self
            let presenter = AboutPresenter(view: view)
            return presenter
        }
    }
}
