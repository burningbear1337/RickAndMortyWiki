//
//  RMCharacterDetailViewViewModel.swift
//  RickAndMortyWiki
//
//  Created by Miroslav Berezovsky on 03.01.2023.
//

import UIKit

final class RMCharacterDetailViewViewModel: NSObject
{
	private let character: RMCharacter
	
	public enum SectionType: CaseIterable
	{
		case photo
		case inforamtion
		case episodes
	}
	
	public let sections = SectionType.allCases
	
	public var title: String {
		character.name.uppercased()
	}
	
	public var requestUrl: URL? {
		URL(string: character.url)
	}
	
	init(character: RMCharacter) {
		self.character = character
	}
}

extension RMCharacterDetailViewViewModel: UICollectionViewDelegate,
										  UICollectionViewDataSource
{
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		sections.count
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		switch section {
		case 0:
			return 1
		case 1:
			return 2
		case 2:
			return 3
		default:
			return 0
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(
			withReuseIdentifier: "cell",
			for: indexPath
		)
		switch indexPath.section {
		case 0:
			cell.backgroundColor = .systemPink
		case 1:
			cell.backgroundColor = .yellow
		case 2:
			cell.backgroundColor = .red
		default:
			break
		}
		return cell
	}
}

extension RMCharacterDetailViewViewModel
{
	func makeCollectionView() -> UICollectionView {
		let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
			return self.makeSection(for: sectionIndex)
		}
		let collectionView = UICollectionView(frame: .zero,
											  collectionViewLayout: layout)
		collectionView.register(UICollectionViewCell.self,
								forCellWithReuseIdentifier: "cell")
		collectionView.delegate = self
		collectionView.dataSource = self
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		return collectionView
	}
	
	func makeSection(for index: Int) -> NSCollectionLayoutSection {
		switch sections[index] {
		case .photo:
			return makePhotoSection()
		case .inforamtion:
			return makeInforamtionSection()
		case .episodes:
			return makeEpisodesSection()
		}
	}
	
	func makePhotoSection() -> NSCollectionLayoutSection {
		let item = NSCollectionLayoutItem(
			layoutSize: NSCollectionLayoutSize(
				widthDimension: .fractionalWidth(1),
				heightDimension: .fractionalHeight(1)
			)
		)
		
		item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)

		let group = NSCollectionLayoutGroup.vertical(
			layoutSize: NSCollectionLayoutSize(
				widthDimension: .fractionalWidth(1),
				heightDimension: .absolute(150)
			),
			subitems: [item]
		)
		
		let section = NSCollectionLayoutSection(group: group)
		return section
	}
	
	func makeInforamtionSection() -> NSCollectionLayoutSection {
		let item = NSCollectionLayoutItem(
			layoutSize: NSCollectionLayoutSize(
				widthDimension: .fractionalWidth(1),
				heightDimension: .fractionalHeight(1)
			)
		)
		
		item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)

		let group = NSCollectionLayoutGroup.vertical(
			layoutSize: NSCollectionLayoutSize(
				widthDimension: .fractionalWidth(1),
				heightDimension: .absolute(150)
			),
			subitems: [item]
		)
		
		let section = NSCollectionLayoutSection(group: group)
		return section
	}
	
	func makeEpisodesSection() -> NSCollectionLayoutSection {
		let item = NSCollectionLayoutItem(
			layoutSize: NSCollectionLayoutSize(
				widthDimension: .fractionalWidth(1),
				heightDimension: .fractionalHeight(1)
			)
		)
		
		item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)

		let group = NSCollectionLayoutGroup.vertical(
			layoutSize: NSCollectionLayoutSize(
				widthDimension: .fractionalWidth(1),
				heightDimension: .absolute(150)
			),
			subitems: [item]
		)
		
		let section = NSCollectionLayoutSection(group: group)
		return section
	}

}
