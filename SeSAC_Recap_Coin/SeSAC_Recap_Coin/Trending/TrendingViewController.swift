//
//  TrendingViewController.swift
//  SeSAC_Recap_Coin
//
//  Created by 박희지 on 2/27/24.
//

import UIKit
import SnapKit

struct SectionItem {
    var type: SectionType
    var items: [Any]
    var title: String
}

enum SectionType {
    case favorite
    case top
}

struct RankInfo {
    let id: String?
    let rank: Int
    let name: String
    let symbol: String
    let iconStr: String
    let currentPrice: String
    let isIncresedPriceChangePer: Bool
    let priceChangePer24h: String
}

final class TrendingViewController: BaseViewController {
    private var sections: [SectionItem] = []
        
        private lazy var collectionView: UICollectionView = {
            var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collectionView.delegate = self
            collectionView.dataSource = self
            
            //cell
            collectionView.register(TrendingFavoriteCollectionViewCell.self, forCellWithReuseIdentifier: TrendingFavoriteCollectionViewCell.identifier)
            collectionView.register(TrendingTopCollectionViewCell.self, forCellWithReuseIdentifier: TrendingTopCollectionViewCell.identifier)
            
            //header
            collectionView.register(TrendingCollectionViewHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TrendingCollectionViewHeaderView.identifier)
            return collectionView
        }()
        
        private lazy var layout: UICollectionViewLayout = {
            return UICollectionViewCompositionalLayout { [weak self] section, _ -> NSCollectionLayoutSection? in
                guard let sectionType = self?.sections[section].type else {
                    return nil
                }
                
                switch sectionType {
                case .favorite:
                    return self?.createFavoriteItemSection()
                    
                case .top:
                    return self?.createTopItemSection()
                }
            }
        }()
    
    private let viewModel = TrendingViewModel()
    private var input: TrendingViewModel.Input!
    private var output: TrendingViewModel.Output!

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setSections()
    }
    
    private func bindViewModel() {
        input = TrendingViewModel.Input(
            viewDidLoadEvent: Observable(nil),
            viewDidAppearEvent: Observable(nil),
            collectionViewCellDidSelectItemAtEvent: Observable(-1)
        )
        
        output = viewModel.transform(from: input)
        
        output.favoriteCoins.bind { favorites in
            guard !favorites.isEmpty else { return }
            self.sections[0].items = favorites
            self.collectionView.reloadData()
        }
        
        output.topCoins.bind { coins in
            guard !coins.isEmpty else { return }
            self.sections[1].items = coins
            self.collectionView.reloadData()
        }
        
        output.topNFTs.bind { nfts in
            guard !nfts.isEmpty else { return }
            self.sections[2].items = nfts
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
    }
    
    override func configureNavigationBar() {
        super.configureNavigationBar()
        navigationItem.title = "Crypto Coin"
    }
}

extension TrendingViewController {
    private func createFavoriteItemSection() -> NSCollectionLayoutSection {
        let sectionMargin: CGFloat = 10
        let groupMargin: CGFloat = 6
        
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        //group
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.55), heightDimension: .estimated(140)), subitems: [item])
        group.contentInsets = .init(top: 0, leading: groupMargin, bottom: 0, trailing: groupMargin)
        
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = .init(top: 0, leading: sectionMargin, bottom: sectionMargin + groupMargin, trailing: sectionMargin)
        
        //header
        let sectionHeader = self.createSectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }
    
    private func createTopItemSection() -> NSCollectionLayoutSection {
        //item
        let itemMargin: CGFloat = 4
        let groupMargin: CGFloat = 8
        let sectionMargin: CGFloat = 12
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: itemMargin, bottom: 0, trailing: itemMargin)
        
        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .estimated(250))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 3)
        group.contentInsets = .init(top: 0, leading: itemMargin + groupMargin, bottom: 0, trailing: itemMargin + groupMargin)
        
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = .init(top: 0, leading: sectionMargin, bottom: 0, trailing: sectionMargin)
        
        //header
        let sectionHeader = self.createSectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]

        return section
    }
    
    private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        //section header 사이즈
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(30))
        
        //section header Layout
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        return sectionHeader
     }
}

// MARK: - extension UICollectionViewDataSource, UICollectionViewDataSource

extension TrendingViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionType = sections[indexPath.section].type
        switch sectionType {
        case .favorite:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendingFavoriteCollectionViewCell.identifier, for: indexPath) as! TrendingFavoriteCollectionViewCell
            
            let data = output.favoriteCoins.value[indexPath.item]
            cell.bindData(data: data )
            return cell
            
        case .top:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendingTopCollectionViewCell.identifier, for: indexPath) as! TrendingTopCollectionViewCell
            if indexPath.section == 1 {
                let data = output.topCoins.value[indexPath.row]
                cell.bindData(data: data)
                return cell
            } else {
                let data = output.topNFTs.value[indexPath.row]
                cell.bindData(data: data)
                return cell
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TrendingCollectionViewHeaderView.identifier, for: indexPath) as? TrendingCollectionViewHeaderView else {
                return UICollectionReusableView()
            }
            let item = sections[indexPath.section]
            headerView.setTitle(title: item.title)
            return headerView
        }
        return UICollectionReusableView()
    }
}

extension TrendingViewController {
    private func setSections() {
        sections = [
            SectionItem(
                type: .favorite,
                items: output.favoriteCoins.value,
                title: "My Favorite"
            ),
            SectionItem(
                type: .top,
                items: output.topCoins.value,
                title: "Top 15 Coin"
            ),
            SectionItem(
                type: .top,
                items: output.topNFTs.value,
                title: "Top 7 NFT"
            )
        ]
    }
}

