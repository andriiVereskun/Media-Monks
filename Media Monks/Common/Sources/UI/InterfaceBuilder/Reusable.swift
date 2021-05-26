//
//  Reusable.swift
//  Media Monks
//
//  Created by Andrii Vereskun on 5/24/21.
//

import UIKit

public protocol Reusable: class {
    static var defaultReuseIdentifier: String { get }
}

extension Reusable {
    static public var defaultReuseIdentifier: String {
        return String(describing: self)
    }
}

// MARK: - UITableView

extension UITableView {
    
    public func register<T: UITableViewCell>(cell: T.Type) where T: Reusable, T: NibLoadableView {
        let nib = UINib(nibName: T.nibName, bundle: Bundle.main)
        register(nib, forCellReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    public func dequeueReusableCell<T: Reusable>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("no cell with identifier \(T.defaultReuseIdentifier) could be dequeued")
        }
        return cell
    }
    
    public func register<T: UITableViewHeaderFooterView>(headerFooterView: T.Type) where T: Reusable, T: NibLoadableView {
        let nib = UINib(nibName: T.nibName, bundle: Bundle.main)
        register(nib, forHeaderFooterViewReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    public func dequeueReusableHeaderFooterView<T: Reusable>() -> T {
        guard let view = dequeueReusableHeaderFooterView(withIdentifier: T.defaultReuseIdentifier) as? T else {
            fatalError("no headerFooterView with identifier \(T.defaultReuseIdentifier) could be dequeued")
        }
        return view
    }
    
}

// MARK: - UICollectionView

extension UICollectionView {
    
    public func register<T: UICollectionViewCell>(cell: T.Type) where T: Reusable, T: NibLoadableView {
        let nib = UINib(nibName: T.nibName, bundle: Bundle.main)
        register(nib, forCellWithReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    public func register<T: UICollectionReusableView>(header: T.Type) where T: Reusable, T: NibLoadableView {
        let nib = UINib(nibName: T.nibName, bundle: Bundle.main)
        register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    public func register<T: UICollectionReusableView>(footer: T.Type) where T: Reusable, T: NibLoadableView {
        let nib = UINib(nibName: T.nibName, bundle: Bundle.main)
        register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    public func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T where T: Reusable {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }
        
        return cell
    }
    
    public func dequeueReusableHeader<T: UICollectionReusableView>(for indexPath: IndexPath) -> T where T: Reusable {
        guard let header = dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                            withReuseIdentifier: T.defaultReuseIdentifier,
                                                            for: indexPath) as? T else
        {
            fatalError("Could not dequeue header with identifier: \(T.defaultReuseIdentifier)")
        }
        
        return header
    }
    
    public func dequeueReusableFooter<T: UICollectionReusableView>(for indexPath: IndexPath) -> T where T: Reusable {
        guard let footer = dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter,
                                                            withReuseIdentifier: T.defaultReuseIdentifier,
                                                            for: indexPath) as? T else
        {
            fatalError("Could not dequeue footer with identifier: \(T.defaultReuseIdentifier)")
        }
        
        return footer
    }
    
}
