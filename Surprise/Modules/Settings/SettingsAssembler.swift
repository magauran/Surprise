//
//  SettingsAssembler.swift
//  Surprise
//
//  Created by Alexey Salangin on 10/27/19.
//  Copyright © 2019 Alexey Salangin. All rights reserved.
//

import Swinject

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
        }
    }
}
