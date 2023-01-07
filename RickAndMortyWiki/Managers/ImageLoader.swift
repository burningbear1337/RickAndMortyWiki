//
//  ImageLoader.swift
//  RickAndMortyWiki
//
//  Created by Miroslav Berezovsky on 06.01.2023.
//

import UIKit

final class RMImageLoader
{
	static let instance = RMImageLoader()
	
	private init() { }
	
	private let cache = NSCache<NSString, UIImage>()
	
	public func loadImage(for url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) {
		let key = url.absoluteString as NSString
		if let cachedImage = cache.object(forKey: key) {
			completion(.success(cachedImage))
			return
		}
		let request = URLRequest(url: url)
		URLSession.shared.dataTask(with: request) { data, _, error in
			guard let data = data, error == nil else {
				completion(.failure(URLError(.badServerResponse)))
				return
			}
			guard let image = UIImage(data: data) else { return }
			self.cache.setObject(image, forKey: key)
			completion(.success(image))
		}
		.resume()
	}
}
