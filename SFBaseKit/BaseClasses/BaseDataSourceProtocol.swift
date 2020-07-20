//
//  BaseDataSourceProtocol.swift
//  BaseKit
//
//  Created by Martin Vasilev on 14.11.18.
//  Copyright © 2018 Upnetix. All rights reserved.
//

import UIKit

let DefaultIdentifier = "Default"

public typealias DataWithIdentifier<T> = (value:T, containerIdentifier:String)
/// Protocol establishing the base data source properties and methods in relation with `ViewConfigurator`.
/// Usable by both `UITableView` and `UICollectionView`.
public protocol BaseDataSource: AnyObject {
    
    // Used if you want multiple tableviews to have the same cell/header/footer configuration
    var containerIdentifiersMap:[String:String] { get set }
    
    /// List of reuseIdentifiers of header and footer views.
    var headerFooterReuseIdentifiers: [DataWithIdentifier<[String]>] { get }
    
    /// List of reuseIdentifiers of cell views.
    var reuseIdentifiers: [DataWithIdentifier<[String]>] { get }
    
    /// Provides the number of sections in your table/collection view
    /// Defaults to 1
    var numberOfSections: DataWithIdentifier<Int> { get }
    
    /// Provides the number of table/collection view cells for the given section
    ///
    /// - Parameter section: The given section
    /// - Returns: The number of cells from the viewModel
    func numberOfCellsInSection(_ section: Int, containerIdentifier: String) -> Int?
    
    /// Provides the viewConfigurator for your configurable table/collection view cell
    ///
    /// - Parameter index: The index path for the current cell
    /// - Parameter section: The section path for the current cell
    /// - Returns: A configurator from the viewModel
    func viewConfigurator(at index: Int, in section: Int, containerIdentifier: String) -> ViewConfigurator?
    
    /// Provides the viewConfigurator for your configurable header view.
    /// - Parameter section: The given section
    func headerViewConfigurator(in section: Int, containerIdentifier: String) -> ViewConfigurator?
    
    /// Provides the viewConfigurator for your configurable footer view.
    /// - Parameter section: The given section
    func footerViewConfigurator(in section: Int, containerIdentifier: String) -> ViewConfigurator?
    
    func register(identifier: String, mappedAs:String)
    func unregister(identifier: String)
}

// MARK: - BaseDataSource+Defaults
public extension BaseDataSource {
    var headerFooterReuseIdentifiers: [DataWithIdentifier<[String]>] {
        return []
    }
    
    var reuseIdentifiers: [DataWithIdentifier<[String]>] {
        return []
    }
    
    var numberOfSections: DataWithIdentifier<Int> {
        return (value: 1, containerIdentifier:DefaultIdentifier)
    }
    
    func viewConfigurator(at index: Int, in section: Int, containerIdentifier: String) -> ViewConfigurator? {
        return nil
    }
    
    func headerViewConfigurator(in section: Int, containerIdentifier: String) -> ViewConfigurator? {
        return nil
    }
    
    func footerViewConfigurator(in section: Int, containerIdentifier: String) -> ViewConfigurator? {
        return nil
    }
    
    func register(identifier: String, mappedAs:String) {
        containerIdentifiersMap[identifier] = mappedAs
    }
    
    func unregister(identifier: String) {
        if identifier.count == 0 { return }
        containerIdentifiersMap[identifier] = nil
    }
}
