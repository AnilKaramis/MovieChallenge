//
//  MovieListViewController.swift
//  MovieChallenge
//
//  Created by AnılKaramış on 26.12.2024.
//

import UIKit

class MovieListViewController: UIViewController {
    
    private lazy var collectionViewMain: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 10, height: 100)
        layout.minimumInteritemSpacing = 10
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: Constants.UIConstants.movieCollectionViewListCellID)
        collectionView.backgroundColor = .systemBackground
        
        return collectionView
    }()
    
    private lazy var tableViewMain: UITableView = {
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
    
    private var currentPage = 1
    private var isLoadingMore = false
    private lazy var categoriesMenu: UIMenu = .init(menuTitle: Constants.UIConstants.categoriesMenuTitle, titles: viewModel.genres,handler: { self.viewModel.categoriesMenuHandler(title: $0) })
    
    private let viewModel = MovieListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionViewMain.dataSource = self
        collectionViewMain.delegate = self
        
        viewModel.output = self
        
        configure()
        fetchData(vc: view)
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
        
        view.addSubview(tableViewMain)
        view.addSubview(collectionViewMain)
        
        
        tableViewMain.pinTable(to: view)
        collectionViewMain.pinCollection(to: view)
    }
    func fetchData(vc: UIView) {
        
        LoadingManager.shared.showLoading(in: vc)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            guard self != nil else { return }
            LoadingManager.shared.hideLoading()
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY >= contentHeight - (2 * height){
            
        }
    }
//    private func loadMoreData() {
//        isLoadingMore = true
//        currentPage += 1
//
//        viewModel.loadMoreMovies(page: currentPage) { [weak self] success in
//            self?.isLoadingMore = false
//            if success {
//                self?.tableViewMain.reloadData()
//            }
//        }
//    }
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
        tableViewMain.reloadData()
    }
}

extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.UIConstants.movieTableViewListCellID,
                                                       for: indexPath) as? MovieListCell
        else { fatalError("MovieTableViewListCell Error") }
        //        if indexPath.row == 0 && indexPath.section == 0 {
        //            self.fetchData(vc: tableViewMain)
        //        }
        
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
//MARK: -CollectionViewController

extension MovieListViewController:UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.UIConstants.movieCollectionViewListCellID, for: indexPath) as? CollectionViewCell else { fatalError("MovieCollectionViewCell Error") }
        cell.setMovie(movie: viewModel.movieForCell(filterStatus: isFiltering, section: indexPath.section, index: indexPath.row))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 40, height: 200)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = MovieDetailViewController()
        vc.setMovie(movie: viewModel.movieForCell(filterStatus: isFiltering, section: indexPath.section, index: indexPath.row))
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

