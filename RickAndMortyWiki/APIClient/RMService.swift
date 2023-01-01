//
//  RMService.swift
//  RickAndMortyWiki
//
//  Created by Miroslav Berezovsky on 31.12.2022.
//

final class RMService
{
	static let instance = RMService()
	
	private init() { }
	
	public func execute(_ request: RMRequest,
						comepltion: @escaping (Result<String, Error>) -> Void) {
		
	}
}
