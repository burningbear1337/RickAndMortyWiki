//
//  RMAllCharactersType.swift
//  RickAndMortyWiki
//
//  Created by Miroslav Berezovsky on 02.01.2023.
//

struct RMGetAllCharactersResponse: Codable
{
	let info: RMGetAllCharactersResponseInfo
	let results: [RMCharacter]
}

struct RMGetAllCharactersResponseInfo: Codable
{
	let count: Int
	let pages: Int
	let next: String?
	let prev: String?
}
