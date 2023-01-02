//
//  RMRequest.swift
//  RickAndMortyWiki
//
//  Created by Miroslav Berezovsky on 31.12.2022.
//

import Foundation

final class RMRequest
{
	private enum Constants
	{
		static let baseUrl = "https://rickandmortyapi.com/api"
	}
	
	private let enpoint: RMEndpoint
	private let pathComponents: [String]
	private let queryParameters: [URLQueryItem]
	
	private var urlString: String {
		var string = Constants.baseUrl
		string += "/\(enpoint.rawValue)"
		
		if pathComponents.isEmpty == false {
			pathComponents.forEach { string += "/\($0)" }
		}
		
		if queryParameters.isEmpty == false {
			string += "/?"
			let argumentString = queryParameters.compactMap({
				guard let value = $0.value else { return nil }
				return "\($0.name)=\(value)"
			}).joined(separator: "&")
			string += argumentString
		}
		return string
	}
	
	public var url: URL? {
		URL(string: urlString)
	}
	
	init(
		enpoint: RMEndpoint = .character,
		pathComponents: [String] = [],
		queryParameters: [URLQueryItem] = []) {
		self.enpoint = enpoint
		self.pathComponents = pathComponents
		self.queryParameters = queryParameters
	}
}

extension RMRequest
{
	static let listCharactersRequest = RMRequest(enpoint: .character)
}
