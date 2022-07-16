//
//  AppCoordinator.swift
//  KoreaTravelMasterApp
//
//  Created by 박근보 on 2022/07/16.
//

import UIKit

final class AppCoordinator: NSObject, Coordinator {

    var presenter: UINavigationController
    var childCoordinators: [Coordinator]

    let window: UIWindow

    init(window: UIWindow) {
        self.window = window
        self.presenter = UINavigationController()
        self.childCoordinators = []
    }

    func start() {

        window.rootViewController = presenter

        let coordinator = MainCoordinator(presenter: presenter)
        childCoordinators.append(coordinator)

        coordinator.parentCoordinator = self
        coordinator.start()

        window.makeKeyAndVisible()
    }

    func childDidFinish(_ child: Coordinator?, completion: () -> Void) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                completion()
                break
            }
        }
    }
}

