//
//  AppFramework.swift
//  Surprise
//
//  Created by Alexey Salangin on 10/26/19.
//  Copyright © 2019 Alexey Salangin. All rights reserved.
//

import Swinject
import SwinjectAutoregistration

struct AppAssembler {
    var resolver: Resolver { self.assembler.resolver }
    let assembler: Assembler

    init(parent: Assembler?) {
        self.assembler = Assembler([AppAssembly(), AccountAssembly()], parent: parent)
    }
}

private struct AppAssembly: Assembly {
    func assemble(container: Container) {
        container.register(UIViewController.self) {
            let viewController0 = UIViewController()
            viewController0.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "albums"), tag: 0)

            let viewController1 = UIViewController()
            viewController1.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "search"), tag: 1)

            let viewController2 = $0 ~> AccountViewController.self
            viewController2.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "user_male"), tag: 2)

            let tabBarController = UITabBarController()
            tabBarController.viewControllers = [viewController0, viewController1, viewController2]
            tabBarController.selectedIndex = 2
            return tabBarController
        }

        container.autoregister(AppRouter.self, initializer: AppRouter.init)
        container.autoregister(AppAssembler.self) {
            guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
                fatalError("Could not cast delegate to type AppDelegate.")
            }
            return delegate.assembler
        }
    }
}

private struct AccountAssembly: Assembly {
    func assemble(container: Container) {
        container.register(AccountViewController.self) { _ in
            UIStoryboard.main.instantiate()
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

        container.register(AccountRoutingLogic.self) {
            let viewController = $0 ~> AccountViewController.self
            let appRouter = $0 ~> AppRouter.self
            let aboutAssembler = $0 ~> AboutAssembler.self
            return AccountRouter(
                transitionHandler: viewController,
                appRouter: appRouter,
                aboutAssembler: aboutAssembler.assembler
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
