//
//  MovieListViewController.swift
//  MovieChallenge
//
//  Created by AnılKaramış on 26.12.2024.
//

import UIKit

class MovieListViewController: UIViewController {
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()

    private lazy var tableView: UITableView = {
        var table = UITableView()
        table.register(MovieListCell.self, forCellReuseIdentifier: Constants.UIConstants.movieTableViewListCellID)
        table.delegate = self
        table.dataSource = self
        table.rowHeight = 220
        return table
    }()
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = Constants.UIConstants.searchBarPlaceholder
        definesPresentationContext = true
        return searchController
    }()
    
    private lazy var categoriesMenu: UIMenu = .init(menuTitle: Constants.UIConstants.categoriesMenuTitle, titles: viewModel.genres,
                                                    handler: { self.viewModel.categoriesMenuHandler(title: $0) })
    
    private let viewModel = MovieListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.output = self
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
    }
    
    private func configure() {
        navigationItem.searchController = searchController
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: Constants.UIConstants.categoryMenuImage),
                                                            menu: categoriesMenu)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = Constants.UIConstants.movieListTitle
        
        view.addSubview(tableView)
        view.addSubview(collectionView)
        
        tableView.pinTable(to: view)
        collectionView.pinCollection(to: view)
    }
}

// MARK: Implement filter control methods
extension MovieListViewController {
    private var isSearchBarEmpty: Bool {
      return searchController.searchBar.text!.isEmpty
    }
    private var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }
}

extension MovieListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        viewModel.searchMovie(title: searchBar.text!)
    }
}

extension MovieListViewController: MovieListOutput {
    func refresh() {
        tableView.reloadData()
    }
}

extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.UIConstants.movieTableViewListCellID,
                                                       for: indexPath) as? MovieListCell
        else { fatalError("MovieTableViewListCell Error") }
        
        cell.setMovie(movie: viewModel.movieForCell(filterStatus: isFiltering,
                                                    section: indexPath.section,
                                                    index: indexPath.row))
        
        cell.bookmarkAction = { self.viewModel.bookmarkButtonAction(filterStatus: self.isFiltering,
                                                                          section: indexPath.section,
                                                                          index: indexPath.row) }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(filterStatus: isFiltering, section: section)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return MovieListEndpoint.allCases.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.titleForHeaderInSection(filterStatus: isFiltering, section: section)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MovieDetailViewController()
        vc.setMovie(movie: viewModel.movieForCell(filterStatus: isFiltering,
                                                  section: indexPath.section, index: indexPath.row))
        navigationController?.pushViewController(vc, animated: true)
    }
}
//MARK: CollectionViewController

extension MovieListViewController:UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.UIConstants.movieCollectionViewListCellID, for: indexPath) as? MovieListCell else { fatalError("MovieCollectionViewCell Error") }
        
        return cell
    }
}

//MARK: -Preview

#if DEBUG
import SwiftUI

struct MovieListViewController_Previews: PreviewProvider {
   static var previews: some View {
       NavigationController_Preview {
           let vc = MovieListViewController()
           return vc
       }
   }
}

struct NavigationController_Preview<ViewController: UIViewController>: UIViewControllerRepresentable {
   let viewControllerFactory: () -> ViewController
   
   init(_ viewControllerFactory: @escaping () -> ViewController) {
       self.viewControllerFactory = viewControllerFactory
   }
   
   func makeUIViewController(context: Context) -> UINavigationController {
       let vc = viewControllerFactory()
       return UINavigationController(rootViewController: vc)
   }
   
   func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {}
}
#endif
