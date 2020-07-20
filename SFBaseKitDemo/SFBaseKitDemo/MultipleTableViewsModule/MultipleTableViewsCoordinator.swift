//
//  MultipleTableViewsCoordinator.swift
//  SFBaseKitDemo
//
//  Created by Kostadin Zamanov on 30.06.20.
//  Copyright © 2020 Upnetix. All rights reserved.
//

import SFBaseKit

class MultipleTableViewsCoordinator: Coordinator {
    
    unowned private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() {
        guard let rootVC = MultipleTableViewsViewController.instantiateFromStoryboard() else { return }
        rootVC.sceneDelegate = self
        navigationController.pushViewController(rootVC, animated: true)
    }
}

// MARK: HomeScreenDelegate
extension MultipleTableViewsCoordinator: MultipleTableViewsSceneDelegate {
    func homeSceneShouldContinueToLogOut() {
        finish()
        appCoordinator?.shouldShowLoginScene()
    }
    
    func homeSceneShouldContinueToNextScreen() {
        finish()
        appCoordinator?.shouldShowMultipleTableViewsScreen()
    }
}
