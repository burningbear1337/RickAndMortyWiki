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
		static let baseUrl = "https://rickandmortyapi.com/api/"
	}
	
	private let enpoint: RMEndpoint
	private let pathComponents: [String]
	private let queryParameters: [URLQueryItem]
	
	private var urlString: String {
		var string = Constants.baseUrl
		string += "\(enpoint.rawValue)/"
		
		if pathComponents.isEmpty == false {
			pathComponents.forEach { string += "\($0)/" }
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
	
	convenience init?(url: URL) {
		let string = url.absoluteString
		if string.contains(Constants.baseUrl) == false {
			return nil
		}
		let trimmed = string
			.replacingOccurrences(of: Constants.baseUrl, with: "")
			.replacingOccurrences(of: "/", with: "")
		if trimmed.contains("/") && trimmed.contains("?") == false {
			let components = trimmed.components(separatedBy: "/")
			if components.isEmpty == false {
				if
					let endpoint = components.first,
					let rmEndpoint = RMEndpoint(rawValue: endpoint) {
					self.init(enpoint: rmEndpoint)
					return
				}
			}
		}
		else if trimmed.contains("?") {
			let components = trimmed.components(separatedBy: "?")
			if components.isEmpty == false {
				guard
					let endpoint = components.first,
					let queryItemsString = components.last
				else {
					return nil
				}
				let queryItems: [URLQueryItem] =
				queryItemsString.components(separatedBy: "&").compactMap {
					guard $0.contains("=") else { return URLQueryItem(name: "", value: nil) }
					let parts = $0.components(separatedBy: "=")
					return URLQueryItem(name: parts.first ?? "", value: parts.last ?? nil)
				}
				
				if let rmEndpoint = RMEndpoint(rawValue: endpoint) {
					self.init(enpoint: rmEndpoint, queryParameters: queryItems)
					return 
				}
			}
		}
		
		return nil
	}
}

extension RMRequest
{
	static let listCharactersRequest = RMRequest(enpoint: .character)
}
