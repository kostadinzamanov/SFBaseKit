//
//  MTVViewModel.swift
//  SFBaseKitDemo
//
//  Created by Kostadin Zamanov on 30.06.20.
//  Copyright © 2020 Upnetix. All rights reserved.
//

import SFBaseKit

public struct MTVSimpleData {
    var title: String
    var subTitle: String
}

class MTVViewModel: BaseDataSource, MultipleTableViewsViewModel {
    var containerIdentifiersMap:[String:String] = [:]
    
    func numberOfCellsInSection(_ section: Int, containerIdentifier: String) -> Int? {
        return 3
    }
    
    func viewConfigurator(at index: Int, in section: Int, containerIdentifier: String) -> ViewConfigurator? {
        let mappedIdentifier = MTVViewType(rawValue: containerIdentifiersMap[containerIdentifier] ?? "Simple") ?? .simple
        switch mappedIdentifier {
        case .simple:
            return BaseViewConfigurator<MTVSimpleCell>(data: "Simple")
        case .image:
            if containerIdentifier == "" {
                
            }
            let image = UIImage(named: "icons8-ios-50")
            return BaseViewConfigurator<MTVImageCell>(data: image ?? UIImage())
        case .detailed:
            return BaseViewConfigurator<MTVDetailCell>(data: MTVSimpleData(title: "Detailed", subTitle: "Subtext"))
        }
    }
}


class MTVSimpleCell:UITableViewCell, Configurable {
    typealias DataType = String
    
    public func configureWith(_ data: String) {
        self.textLabel?.text = data
    }
}

class MTVImageCell:UITableViewCell, Configurable {
    typealias DataType = UIImage
    
    public func configureWith(_ data: UIImage) {
        self.imageView?.image = data
    }
}

class MTVDetailCell:UITableViewCell, Configurable {
    typealias DataType = MTVSimpleData
    
    public func configureWith(_ data: MTVSimpleData) {
        self.textLabel?.text = data.title
        self.detailTextLabel?.text = data.subTitle
    }
}
