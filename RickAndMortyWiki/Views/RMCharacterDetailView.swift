//
//  RMCharacterDetailView.swift
//  RickAndMortyWiki
//
//  Created by Miroslav Berezovsky on 03.01.2023.
//

import UIKit

final class RMCharacterDetailView: UIView
{
	private let characterViewModel: RMCharacterDetailViewViewModel
	
//	private var collectionView: UICollectionView?
	
	private let spinner: UIActivityIndicatorView = {
		let spinner = UIActivityIndicatorView(style: .large)
		spinner.translatesAutoresizingMaskIntoConstraints = false
		spinner.hidesWhenStopped = true
		return spinner
	}()
	
	init(characterViewModel: RMCharacterDetailViewViewModel) {
		self.characterViewModel = characterViewModel
		super.init(frame: .zero)
		backgroundColor = .systemBackground
		setupView()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

private extension RMCharacterDetailView
{
	func setupView() {
		let collectionView = makeCollectionView()
		addSubviews(collectionView, spinner)
		collectionView.backgroundColor = .yellow
		NSLayoutConstraint.activate([
			collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
			collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
			collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
			collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
		])
	}
	
	func makeCollectionView() -> UICollectionView {
		let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
			return self.makeSection(for: sectionIndex)
		}
		let collectionView = UICollectionView(frame: .zero,
											  collectionViewLayout: layout)
		collectionView.register(UICollectionViewCell.self,
								forCellWithReuseIdentifier: "cell")
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		return collectionView
	}
	
	func makeSection(for index: Int) -> NSCollectionLayoutSection {
		let item = NSCollectionLayoutItem(
			layoutSize: NSCollectionLayoutSize(
				widthDimension: .fractionalWidth(1),
				heightDimension: .fractionalHeight(1)
			)
		)
		let group = NSCollectionLayoutGroup.vertical(
			layoutSize: NSCollectionLayoutSize(
				widthDimension: .absolute(150),
				heightDimension: .absolute(150)
			),
			subitems: [item]
		)
		let section = NSCollectionLayoutSection(group: group)
		return section
	}
}
