//
//  Scene+ViewController.swift
//  Simple Todo
//
//  Created by Khoi Lai on 4/17/17.
//  Copyright © 2017 khoi.io. All rights reserved.
//

// swiftlint:disable force_cast

import UIKit

extension Scene {
    func viewController() -> UIViewController {
        switch self {
        case .authentication(let viewModel):
            let navigationVC = R.storyboard.authentication().instantiateInitialViewController() as! UINavigationController
            var authenticationVC = navigationVC.viewControllers.first as? AuthenticationViewController
            authenticationVC?.bindViewModel(to: viewModel)
            return navigationVC
        case .taskList(let viewModel):
            let navigationVC = R.storyboard.task().instantiateInitialViewController() as! UINavigationController
            var taskVC = navigationVC.viewControllers.first as? ListsViewController
            taskVC?.bindViewModel(to: viewModel)
            return navigationVC
        case .tasks(let viewModel):
            var tasksVC = R.storyboard.task.tasksViewController()!
            tasksVC.bindViewModel(to: viewModel)
            return tasksVC
        case .createTask(let viewModel):
            var createTaskVC = R.storyboard.task.createTaskViewController()!
            createTaskVC.bindViewModel(to: viewModel)
            return createTaskVC
        }

    }
}
