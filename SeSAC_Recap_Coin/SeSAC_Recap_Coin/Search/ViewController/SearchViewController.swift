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
    
    let titleLabel = UILabel()
    let tableView = UITableView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureHierarchy() {
        view.addSubviews(titleLabel, tableView)
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(12)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        titleLabel.text = "Search"
        titleLabel.font = .title
        configureTableView()
    }
    
    override func configureNavigationBar() {
        navigationItem.searchController = UISearchController(searchResultsController: nil)
        searchController?.searchResultsUpdater = self
    }
    
    func configureTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as! SearchTableViewCell
        
        return cell
    }
}

// MARK: - UISearchResultsUpdating

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text, !text.isEmpty else {
            // TODO: 바인딩할 데이터 초기화
            return
        }
        
        guard !text.removeWhitespaces.isEmpty else {
            return
        }
        
        print(text.refineForSearch)
    }
}


