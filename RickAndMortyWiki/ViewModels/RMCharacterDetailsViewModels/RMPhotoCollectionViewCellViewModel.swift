//
//  RMPhotoCollectionViewCellViewModel.swift
//  RickAndMortyWiki
//
//  Created by Miroslav Berezovsky on 09.01.2023.
//
import UIKit

final class RMPhotoCollectionViewCellViewModel
{
	private let urlString: String
	
	init(urlString: String) {
		self.urlString = urlString
	}
	
	public func fetchImage(completion: @escaping (Result<UIImage, Error>) -> Void) {
		guard let url = URL(string: urlString) else { return }
		RMImageLoader.instance.loadImage(for: url) { result in
			switch result {
			case .success(let image):
				completion(.success(image))
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}
}
