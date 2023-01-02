//
//  RMCharactersListViewViewModel.swift
//  RickAndMortyWiki
//
//  Created by Miroslav Berezovsky on 02.01.2023.
//
import UIKit

final class RMCharactersListViewViewModel: NSObject
{
	private var characters: [RMCharacter] = []
	
	func fetchCharacters(completion: @escaping () -> Void) {
		RMService.instance.execute(.listCharactersRequest,
								   for: RMGetAllCharactersResponse.self) { [weak self] result in
			switch result {
			case .success(let characters):
				self?.characters = characters.results
				completion()
			case .failure(let error):
				print(error)
			}
		}
	}
}

extension RMCharactersListViewViewModel: UICollectionViewDelegate,
										 UICollectionViewDataSource,
										 UICollectionViewDelegateFlowLayout
{
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return characters.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(
			withReuseIdentifier: RMCharacterCollectionViewCell.cellID,
			for: indexPath
		) as? RMCharacterCollectionViewCell else { return UICollectionViewCell()}
		let character = characters[indexPath.row]
		let viewModel = RMCharacterCollectionViewCellViewModel(
			characterName: character.name,
			characterStatus: character.status,
			characterImageUrl: character.image
		)
		cell.configure(with: viewModel)
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let width = (UIScreen.main.bounds.width - 30) / 2
		return CGSize(width: width, height: width*1.5)
	}
}

