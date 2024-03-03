//
//  SearchViewController.swift
//  SeSAC_Recap_Coin
//
//  Created by 박희지 on 2/27/24.
//

import UIKit
import SnapKit

// TODO: 검색 전 "코인을 검색해보세요" 레이블 보여주고, 검색할 때는 숨겨둔 테이블뷰 보이게 하기
final class SearchViewController: BaseViewController {
    lazy var searchController = navigationItem.searchController
    
    let tableView = UITableView()
    
    let viewModel = SearchViewModel()
    var input: SearchViewModel.Input!
    var output: SearchViewModel.Output!

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        input.viewDidAppearEvent.value = ()
    }
    
    func bindViewModel() {
        input = SearchViewModel.Input(
            viewDidLoadEvent: Observable(nil), 
            viewDidAppearEvent: Observable(nil),
            searchControllerUpdateSearchResultsEvent: Observable(""),
            tableViewCellDidSelectRowAtEvent: Observable(-1),
            tableViewCellFavoriteButtonClickedEvent: Observable(nil)
        )
        
        output = viewModel.transform(from: input)
        
        output.searchResult.bind { _ in
            self.tableView.reloadData()
        }
        
        output.favoriteCoins.bind { _ in
            self.tableView.reloadData()
        }
        
        output.coinIdForChart.bind { id in
            guard let id else { return }
            
            let chartVC = ChartViewController()
            chartVC.bindViewModel(id: id)
            
            self.navigationController?.pushViewController(chartVC, animated: true)
        }
        
        output.tableViewCellFavoriteButtonClickedEvent.bind { _ in
            self.tableView.reloadData()
        }
        
        output.completedUpdateFavorites.bind { message in
            guard !message.isEmpty else { return }
            self.showToast(message)
        }
    }
    
    override func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        configureTableView()
    }
    
    override func configureNavigationBar() {
        super.configureNavigationBar()
        navigationItem.title = "Search"
        navigationItem.searchController = UISearchController(searchResultsController: nil)
        searchController?.searchResultsUpdater = self
    }
    
    func configureTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        tableView.separatorStyle = .none
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output.searchResult.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as! SearchTableViewCell
        
        let data = output.searchResult.value[indexPath.row]
        let isFavorite = output.favoriteCoins.value.contains { favorite in
            favorite.coinId == data.id
        }
        cell.bindData(data: data, isFavorite: isFavorite)
        cell.changeColorBySearchKeyword(searchController?.searchBar.text)
        cell.favoriteButtonHandler = { isSelected in
            self.input.tableViewCellFavoriteButtonClickedEvent.value = (isSelected, indexPath.row)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        input.tableViewCellDidSelectRowAtEvent.value = indexPath.row
    }
}

// MARK: - UISearchResultsUpdating

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        input.searchControllerUpdateSearchResultsEvent.value = searchController.searchBar.text
    }
}


