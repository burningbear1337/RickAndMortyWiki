//
//  RMCharactersListViewViewModel.swift
//  RickAndMortyWiki
//
//  Created by Miroslav Berezovsky on 02.01.2023.
//
import UIKit

protocol RMCharactersListViewViewModelDelegate: AnyObject
{
	func didLoadInitialCharacters()
	func didSelectCharacter(_ character: RMCharacter)
}

final class RMCharactersListViewViewModel: NSObject
{
	private var characters: [RMCharacter] = [] {
		didSet {
			for character in characters {
				let viewModel = RMCharacterCollectionViewCellViewModel(
					characterName: character.name,
					characterStatus: character.status,
					characterImageUrl: character.image
				)
				cellViewModels.append(viewModel)
			}
		}
	}
	
	private var cellViewModels: [RMCharacterCollectionViewCellViewModel] = []
	
	private var info: RMGetAllCharactersResponse.RMGetAllCharactersResponseInfo?
	
	public weak var delegate: RMCharactersListViewViewModelDelegate?
	
	public var shouldShowLoadMoreIndicator: Bool {
		info?.next != nil
	}
	
	public func fetchAdditionalCharacters() {
		let request = RMRequest(enpoint: .character)
		RMService.instance.execute(request, for: [RMCharacter].self) {[weak self] result in
			switch result {
			case .success(let characters):
				self?.characters.append(contentsOf: characters)
			case .failure(let error):
				print(error)
				break
			}
		}
	}
	
	public func fetchCharacters() {
		RMService.instance.execute(.listCharactersRequest,
								   for: RMGetAllCharactersResponse.self) { [weak self] result in
			switch result {
			case .success(let characters):
				self?.characters = characters.results
				self?.info = characters.info
				self?.delegate?.didLoadInitialCharacters()
			case .failure(let error):
				print(error)
			}
		}
	}
}

extension RMCharactersListViewViewModel: UICollectionViewDelegate,
										 UICollectionViewDataSource,
										 UICollectionViewDelegateFlowLayout,
										 UIScrollViewDelegate
{
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return cellViewModels.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(
			withReuseIdentifier: RMCharacterCollectionViewCell.cellID,
			for: indexPath
		) as? RMCharacterCollectionViewCell else { return UICollectionViewCell()}
		let viewModel = cellViewModels[indexPath.row]
		cell.configure(with: viewModel)
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let width = (UIScreen.main.bounds.width - 30) / 2
		return CGSize(width: width, height: width*1.5)
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let character = characters[indexPath.row]
		delegate?.didSelectCharacter(character)
	}
	
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		guard shouldShowLoadMoreIndicator else { return }
		
	}
}

