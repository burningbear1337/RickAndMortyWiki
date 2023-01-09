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
	
	public enum SectionType
	{
		case photo(_ viewModel: RMPhotoCollectionViewCellViewModel)
		case inforamtion(_ viewModels: [RMInformationCollectionViewCellViewModel])
		case episodes(_ viewModels: [RMEpisodeCollectionViewCellViewModel])
	}
	
	public var sections: [SectionType] = []
	
	public var title: String {
		character.name.uppercased()
	}
	
	public var requestUrl: URL? {
		URL(string: character.url)
	}
	
	init(character: RMCharacter) {
		self.character = character
		super.init()
		self.setUpSections()
	}
}

extension RMCharacterDetailViewViewModel: UICollectionViewDelegate,
										  UICollectionViewDataSource
{
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		sections.count
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		let sectionType = sections[section]
		switch sectionType {
		case .photo(_ ):
			return 1
		case .inforamtion(let viewModels):
			return viewModels.count
		case .episodes(let viewModels):
			return viewModels.count
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let sectionType = sections[indexPath.section]
		switch sectionType {
		case .photo(let viewModel):
			guard
				let cell = collectionView.dequeueReusableCell(
				withReuseIdentifier: RMPhotoCollectionViewCell.id,
				for: indexPath) as? RMPhotoCollectionViewCell
			else {
				return UICollectionViewCell()
			}
			cell.configure(with: viewModel)
			return cell
		case .inforamtion(let viewModels):
			guard
				let cell = collectionView.dequeueReusableCell(
				withReuseIdentifier: RMInformationCollectionViewCell.id,
				for: indexPath) as? RMInformationCollectionViewCell
			else {
				return UICollectionViewCell()
			}
			cell.configure(with: viewModels[indexPath.row])
			return cell
		case .episodes(let viewModels):
			guard
				let cell = collectionView.dequeueReusableCell(
					withReuseIdentifier: RMEpisodeCollectionViewCell.id,
					for: indexPath) as? RMEpisodeCollectionViewCell
			else {
				return UICollectionViewCell()
			}
			cell.configure(with: viewModels[indexPath.row])
			return cell
		}
	}
}

extension RMCharacterDetailViewViewModel
{
	func setUpSections() {
		sections = [
			.photo(.init(urlString: character.image)),
			.inforamtion([
				.init(value: character.status.rawValue, title: "Status"),
				.init(value: character.gender.rawValue, title: "Gender"),
				.init(value: character.type, title: "Type"),
				.init(value: character.species, title: "Species"),
				.init(value: character.origin.name, title: "Origin"),
				.init(value: character.location.name, title: "Location"),
				.init(value: character.created, title: "Created"),
				.init(value: String(character.episode.count), title: "Total Episodes"),
			]),
			.episodes(character.episode.compactMap { RMEpisodeCollectionViewCellViewModel(episode: $0)})
		]
	}
	
	func makeCollectionView() -> UICollectionView {
		let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
			return self.makeSection(for: sectionIndex)
		}
		let collectionView = UICollectionView(frame: .zero,
											  collectionViewLayout: layout)
		collectionView.register(
			RMPhotoCollectionViewCell.self,
			forCellWithReuseIdentifier: RMPhotoCollectionViewCell.id
		)
		collectionView.register(
			RMEpisodeCollectionViewCell.self,
			forCellWithReuseIdentifier: RMEpisodeCollectionViewCell.id
		)
		collectionView.register(
			RMInformationCollectionViewCell.self,
			forCellWithReuseIdentifier: RMInformationCollectionViewCell.id
		)
		
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
		
		item.contentInsets = NSDirectionalEdgeInsets(top: 2,
													 leading: 2,
													 bottom: 2,
													 trailing: 2)

		let group = NSCollectionLayoutGroup.vertical(
			layoutSize: NSCollectionLayoutSize(
				widthDimension: .fractionalWidth(1),
				heightDimension: .fractionalHeight(0.5)
			),
			subitems: [item]
		)
		
		let section = NSCollectionLayoutSection(group: group)
		return section
	}
	
	func makeInforamtionSection() -> NSCollectionLayoutSection {
		let item = NSCollectionLayoutItem(
			layoutSize: NSCollectionLayoutSize(
				widthDimension: .fractionalWidth(0.5),
				heightDimension: .fractionalHeight(1)
			)
		)
		
		item.contentInsets = NSDirectionalEdgeInsets(top: 2,
													 leading: 2,
													 bottom: 2,
													 trailing: 2)

		let group = NSCollectionLayoutGroup.horizontal(
			layoutSize: NSCollectionLayoutSize(
				widthDimension: .fractionalWidth(1),
				heightDimension: .absolute(150)
			),
			subitems: [item, item]
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
		
		item.contentInsets = NSDirectionalEdgeInsets(top: 2,
													 leading: 2,
													 bottom: 2,
													 trailing: 2)

		let group = NSCollectionLayoutGroup.horizontal(
			layoutSize: NSCollectionLayoutSize(
				widthDimension: .fractionalWidth(0.3),
				heightDimension: .absolute(150)
			),
			subitems: [item]
		)
		
		let section = NSCollectionLayoutSection(group: group)
		section.orthogonalScrollingBehavior = .groupPaging
		return section
	}
}
