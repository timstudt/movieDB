//
//  MovieCollectionViewController.swift
//
//  Created by Tim Studt on 13/03/2018.
//  Copyright © 2018 Tim Studt. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class MovieCollectionViewController: View {
    // MARK: - Models
    let queryText = BehaviorRelay<String>(value: "") // does not emit completed nor error

    // MARK: - subiews
    lazy var collectionView: UICollectionView = {
        let collectionViewLayout = layout(for: traitCollection)
        return .init(frame: view.bounds,
                     collectionViewLayout: collectionViewLayout)
    }()

    // MARK: - subcontrollers
    let searchController = UISearchController(searchResultsController: nil)

    // MARK: - data sources
    let collectionViewDataSource: MovieCollectionViewDataSource = {
        return .init(
            cellConfigurator: MovieCollectionViewCellConfigurator()
        )
    }()

    private let disposeBag = DisposeBag()

    // MARK: - ViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupSearchController()
        setupConstraints()
        dataSource?.loadData()
    }

    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView.collectionViewLayout = layout(for: newCollection)
        collectionView.reloadData()
        super.willTransition(to: newCollection, with: coordinator)
    }

    // MARK: - View override
    override func render(state: ViewStateProtocol) {
        guard let state = state as? MovieCollectionViewState else { return }
        collectionViewDataSource.data = state.data
    }

    // MARK: - private methods
    private func setupViews() {
        collectionViewDataSource.collectionView = collectionView
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.contentInsetAdjustmentBehavior = .always
        view.addSubview(collectionView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func setupSearchController() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Movies"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        setupSearchBarBindings()
    }

    private func setupSearchBarBindings() {
        searchController.searchBar
            .rx.text
            .orEmpty
            .asDriver().drive(queryText)
            .disposed(by: disposeBag)

        searchController.searchBar
            .rx.cancelButtonClicked
            .map { "" }
            .bind(to: queryText)
            .disposed(by: disposeBag)
    }

    private func layout(
        for traitCollection: UITraitCollection
    ) -> UICollectionViewLayout {
        let sizeClass = traitCollection.horizontalSizeClass

        switch sizeClass {
        case .compact,
             .unspecified:
            return type(of: self).makeCompactFlowLayout()
        case .regular:
            return type(of: self).makeRegularFlowLayout()
        @unknown default:
            fatalError("unhandled traitCollection size class: \(sizeClass)")
        }
    }
}

extension MovieCollectionViewController {
    static func makeCompactFlowLayout() -> UICollectionViewLayout {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.estimatedItemSize = CGSize(width: 80, height: 135)
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = 8.0
        flowLayout.minimumLineSpacing = 8.0
        flowLayout.sectionInset = .init(top: 8, left: 8, bottom: 8, right: 8)
        return flowLayout
    }

    static func makeRegularFlowLayout() -> UICollectionViewLayout {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.estimatedItemSize = CGSize(width: 100, height: 150)
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = 12.0
        flowLayout.minimumLineSpacing = 12.0
        flowLayout.sectionInset = .init(top: 12, left: 12, bottom: 12, right: 12)
        return flowLayout
    }
}
