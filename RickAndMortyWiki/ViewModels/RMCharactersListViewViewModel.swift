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
	func didLoadNewCharacters()
	func didSelectCharacter(_ character: RMCharacter)
}

final class RMCharactersListViewViewModel: NSObject
{
	private var characters: [RMCharacter] = []
	private var cellViewModels: [RMCharacterCollectionViewCellViewModel] = []
	
	private var info: RMGetAllCharactersResponse.RMGetAllCharactersResponseInfo?
	
	private var isLoadingMoreCharacters = false
	
	public weak var delegate: RMCharactersListViewViewModelDelegate?
	
	public var shouldShowLoadMoreIndicator: Bool {
		info?.next != nil
	}
	
	public func fetchAdditionalCharacters() {
		isLoadingMoreCharacters = true
		guard
			let urlString = info?.next,
			let url = URL(string: urlString),
			let request = RMRequest(url: url)
		else {
			return
		}
		print(request.url)
		RMService.instance.execute(
			request, for: RMGetAllCharactersResponse.self
		) { [weak self] result in
			switch result {
			case .success(let characters):
				self?.characters = characters.results
				self?.info = characters.info
				characters.results.forEach {
					if let model = self?.makeRMCharacterCollectionViewCellViewModel($0) {
						self?.cellViewModels.append(model)
					}
				}
				self?.delegate?.didLoadNewCharacters()
				self?.isLoadingMoreCharacters = false
			case .failure(let error):
				print(error)
				self?.isLoadingMoreCharacters = false
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
				print(self?.info?.next)
				characters.results.forEach {
					guard let model = self?.makeRMCharacterCollectionViewCellViewModel($0) else {
						return
					}
					self?.cellViewModels.append(model)
				}
				self?.delegate?.didLoadInitialCharacters()
			case .failure(let error):
				print(error)
			}
		}
	}
	
	private func makeRMCharacterCollectionViewCellViewModel(
		_ character: RMCharacter
	) -> RMCharacterCollectionViewCellViewModel {
		return RMCharacterCollectionViewCellViewModel(characterName: character.name,
													  characterStatus: character.status,
													  characterImageUrl: character.image)
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
	
	func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		guard let footer = collectionView.dequeueReusableSupplementaryView(
			ofKind: UICollectionView.elementKindSectionFooter,
			withReuseIdentifier: RMFooterLoadingCollectionReusableView.identifier,
			for: indexPath
		) as? RMFooterLoadingCollectionReusableView else { return UICollectionReusableView()}
		footer.startAnimating()
		return footer
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
		guard shouldShowLoadMoreIndicator else { return .zero }
		return CGSize(width: UIScreen.main.bounds.width, height: 55)
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let character = characters[indexPath.row]
		delegate?.didSelectCharacter(character)
	}
	
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		guard shouldShowLoadMoreIndicator, isLoadingMoreCharacters == false else { return }
		let offset = scrollView.contentOffset.y
		let contentHeight = scrollView.contentSize.height
		let scrollHeight = scrollView.frame.size.height
		if offset + scrollHeight + 120 > contentHeight {
			self.fetchAdditionalCharacters()
		}
	}
}

