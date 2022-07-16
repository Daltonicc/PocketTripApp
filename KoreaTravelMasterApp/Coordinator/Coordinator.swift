//
//  Coordinator.swift
//  KoreaTravelMasterApp
//
//  Created by 박근보 on 2022/07/16.
//

import UIKit

protocol Coordinator: AnyObject {

    var presenter: UINavigationController { get set }

    var childCoordinators: [Coordinator] { get set }

    func start()
}

