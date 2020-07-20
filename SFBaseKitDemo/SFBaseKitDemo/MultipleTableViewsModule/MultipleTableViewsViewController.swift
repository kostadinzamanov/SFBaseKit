//
//  MultipleTableViewsViewController.swift
//  SFBaseKitDemo
//
//  Created by Kostadin Zamanov on 30.06.20.
//  Copyright © 2020 Upnetix. All rights reserved.
//

import SFBaseKit

protocol MultipleTableViewsSceneDelegate: Coordinator {
    func homeSceneShouldContinueToLogOut()
    func homeSceneShouldContinueToNextScreen()
}

protocol MultipleTableViewsViewModel: BaseDataSource {
    
}

enum MTVViewType: String, CaseIterable {
    case simple = "Simple"
    case image = "Image"
    case detailed = "Detailed"
    
    static var random: String {
           return allCases.randomElement()!.rawValue
       }
}

class MultipleTableViewsViewController: UIViewController {
    
    unowned var sceneDelegate: MultipleTableViewsSceneDelegate!

    @IBOutlet weak var stackView:UIStackView!
    
    var viewModel:MultipleTableViewsViewModel! = MTVViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stackView.arrangedSubviews.first?.removeFromSuperview()
    }
    
    @IBAction func plusButtonAction(_ sender: Any) {
        addSubview()
    }
    
    @IBAction func minusButtonAction(_ sender: Any) {
        guard stackView.arrangedSubviews.count > 0,
            let viewToRemove = stackView.arrangedSubviews.last as? ExampleContentView else { return }
        
        viewModel.unregister(identifier: viewToRemove.tableView.accessibilityIdentifier ?? "")
        viewToRemove.removeFromSuperview()
    }
    
    func addSubview() {
        let newView = ExampleContentView(frame: CGRect(x: 0, y: 0, width: 390, height:  170))
        newView.tableView.accessibilityIdentifier = "TableView " + String(stackView.arrangedSubviews.count)
        let type = MTVViewType.random
        viewModel.register(identifier: newView.tableView.accessibilityIdentifier ?? "", mappedAs:type)
        
        switch type {
        case MTVViewType.simple.rawValue:
                newView.tableView.register(MTVSimpleCell.self, forCellReuseIdentifier: "MTVSimpleCell")
            case MTVViewType.detailed.rawValue:
                newView.tableView.register(MTVDetailCell.self, forCellReuseIdentifier: "MTVDetailCell")
            case MTVViewType.image.rawValue:
                newView.tableView.register(MTVImageCell.self, forCellReuseIdentifier: "MTVImageCell")
        default:
            print("Unknown type!")
        
        }
        
        newView.tableView.register(with: viewModel)
        newView.tableView.delegate = self
        newView.tableView.dataSource = self
        newView.alpha = 0.0
        self.stackView.addArrangedSubview(newView)
        newView.heightAnchor.constraint(equalToConstant: 170).isActive = true
        UIView.animate(withDuration: 0.4) {
            newView.alpha = 1.0
        }
    }
}

// MARK: - StoryboardInstantiatable
extension MultipleTableViewsViewController: StoryboardInstantiatable {
    static var storyboardName: String {
        return "MultipleTableViews"
    }
}

extension MultipleTableViewsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCellsInSection(section, containerIdentifier: tableView.accessibilityIdentifier ?? "Unknown") ?? 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let configurator = viewModel.viewConfigurator(at: indexPath.row, in: indexPath.section, containerIdentifier: tableView.accessibilityIdentifier ?? "Unknown") else {
                       return UITableViewCell()
        }
        let cell = tableView.configureCell(for: configurator, at: indexPath)
        return cell
    }
    
    
}
