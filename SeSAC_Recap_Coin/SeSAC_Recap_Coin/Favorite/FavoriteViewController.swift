//
//  FavoriteViewController.swift
//  SeSAC_Recap_Coin
//
//  Created by 박희지 on 2/27/24.
//

import UIKit
import SnapKit

final class FavoriteViewController: BaseViewController {
    private lazy var collectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        cv.setLayout(inset: 16, spacing: 20, ratio: 0.9, colCount: 2)
        cv.register(FavoriteCollectionViewCell.self, forCellWithReuseIdentifier: FavoriteCollectionViewCell.identifier)
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    private let viewModel = FavoriteViewModel()
    private var input: FavoriteViewModel.Input!
    private var output: FavoriteViewModel.Output!

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        input.viewDidLoadEvent.value = ()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        input.viewDidAppearEvent.value = ()
    }
    
    private func bindViewModel() {
        input = FavoriteViewModel.Input(
            viewDidLoadEvent: Observable(nil),
            viewDidAppearEvent: Observable(nil),
            collectionViewCellDidSelectItemAtEvent: Observable(-1)
        )
        
        output = viewModel.transform(from: input)
        
        output.favoriteCoins.bind { _ in
            self.collectionView.reloadData()
        }
        
        output.coinIdForChart.bind { id in
            guard let id else { return }
            
            let chartVC = ChartViewController()
            chartVC.bindViewModel(id: id)
            
            self.navigationController?.pushViewController(chartVC, animated: true)
        }
    }
    
    override func configureHierarchy() {
        view.addSubview(collectionView)
    }

    override func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        // TODO: 즐겨찾기 코인 없으면 컬렉션뷰 숨기기
    }
    
    override func configureNavigationBar() {
        super.configureNavigationBar()
        navigationItem.title = "Favorite Coin"
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension FavoriteViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return output.favoriteCoins.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteCollectionViewCell.identifier, for: indexPath) as! FavoriteCollectionViewCell
        
        let data = output.favoriteCoins.value[indexPath.item]
        cell.bindData(data: data)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        input.collectionViewCellDidSelectItemAtEvent.value = indexPath.item
    }
}
