//
//  AppFramework.swift
//  Surprise
//
//  Created by Alexey Salangin on 10/26/19.
//  Copyright © 2019 Alexey Salangin. All rights reserved.
//

import Swinject
import SwinjectAutoregistration

enum AppAssembler {
    static let assembler = Assembler([AppAssembly(), AccountAssembly()])
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

        container.register(AccountPresentationLogic.self) {
            let presenter = AccountPresenter()
            presenter.viewController = $0 ~> AccountViewController.self
            return presenter
        }
    }
}
