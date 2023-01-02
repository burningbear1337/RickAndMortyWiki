//
//  RMService.swift
//  RickAndMortyWiki
//
//  Created by Miroslav Berezovsky on 31.12.2022.
//
import Foundation

final class RMService
{
	static let instance = RMService()
	
	private init() { }
	
	public func execute<T: Codable>(_ request: RMRequest,
									for type: T.Type,
									completion: @escaping (Result<T, Error>) -> Void) {
		guard let urlRequest = self.request(from: request) else {
			completion(.failure(RMServiceError.failedToCreateRequest))
			return
		}
		URLSession.shared.dataTask(with: urlRequest) { data, _, error in
			guard let data = data, error == nil else {
				completion(.failure(error ?? RMServiceError.failedToGetData))
				return
			}
			do {
				let result = try JSONDecoder().decode(type.self, from: data)
				completion(.success(result))
			}
			catch let error {
				completion(.failure(error))
			}
		}
		.resume()
	}
	
	private func request(from request: RMRequest) -> URLRequest? {
		guard let url = request.url else { return nil}
		var request = URLRequest(url: url)
		request.httpMethod = "GET"
		return request
	}
}
