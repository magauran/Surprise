//
//  AboutAssembler.swift
//  Surprise
//
//  Created by Alexey Salangin on 10/27/19.
//  Copyright © 2019 Alexey Salangin. All rights reserved.
//

import Swinject

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
        }
    }
}
