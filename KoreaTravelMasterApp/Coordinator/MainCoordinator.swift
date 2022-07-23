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
    private let storyboard = UIStoryboard(name: "Main", bundle: nil)

    init(presenter: UINavigationController) {
        self.presenter = presenter
        self.childCoordinators = []
    }

    func start() {
        let viewController = storyboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        viewController.coordinator = self
        presenter.pushViewController(viewController, animated: true)
    }

    func pushTravelMapView() {
        let viewController = storyboard.instantiateViewController(withIdentifier: "TravelMapViewController") as! TravelMapViewController
        viewController.coordinator = self
        presenter.pushViewController(viewController, animated: true)
    }

    func pop() {
        presenter.popViewController(animated: true)
    }

    func dismiss() {
        presenter.dismiss(animated: true)
    }
}
