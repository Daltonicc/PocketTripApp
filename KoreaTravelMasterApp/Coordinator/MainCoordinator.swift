//
//  MainCoordinator.swift
//  KoreaTravelMasterApp
//
//  Created by 박근보 on 2022/07/16.
//

import UIKit

final class MainCoordinator: Coordinator {

    weak var parentCoordinator: Coordinator?

    var presenter: UINavigationController
    var childCoordinators: [Coordinator]

    init(presenter: UINavigationController) {
        self.presenter = presenter
        self.childCoordinators = []
    }

    func start() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        viewController.coordinator = self
        presenter.pushViewController(viewController, animated: true)
    }
}
