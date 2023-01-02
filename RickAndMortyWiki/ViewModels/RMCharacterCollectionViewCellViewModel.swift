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
		characterStatus.rawValue
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
		let request = URLRequest(url: imageUrl)
		URLSession.shared.dataTask(with: request) { data, _, error in
			guard let data = data, error == nil else {
				completion(.failure(URLError(.badServerResponse)))
				return
			}
			guard let image = UIImage(data: data) else { return }
			completion(.success(image))
		}
		.resume()
	}
}
