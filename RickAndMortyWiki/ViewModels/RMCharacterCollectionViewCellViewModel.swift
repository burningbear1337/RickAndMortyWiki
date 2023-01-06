//
//  RMCharacterCollectionViewCellViewModel.swift
//  RickAndMortyWiki
//
//  Created by Miroslav Berezovsky on 02.01.2023.
//
import UIKit

final class RMCharacterCollectionViewCellViewModel
{
	public let characterName: String
	public var characterStatusText: String {
		"Status: \(characterStatus.text)"
	}
	
	private let characterStatus: RMCharacterStatus
	private let characterImageUrl: String
	
	init(characterName: String,
		 characterStatus: RMCharacterStatus,
		 characterImageUrl: String
	) {
		self.characterName = characterName
		self.characterStatus = characterStatus
		self.characterImageUrl = characterImageUrl
	}
	
	public func fetchImage(completion: @escaping (Result<UIImage, Error>) -> Void) {
		guard let imageUrl = URL(string: characterImageUrl) else {
			completion(.failure(URLError(.badURL)))
			return
		}
		RMImageLoader.instance.loadImage(for: imageUrl) { result in
			switch result {
			case .success(let image):
				completion(.success(image))
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}
}
