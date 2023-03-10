//
//  RMLocation.swift
//  RickAndMortyWiki
//
//  Created by Miroslav Berezovsky on 31.12.2022.
//

struct RMLocation: Codable
{
	let id: Int
	let name: String
	let type: String
	let dimension: String
	let residents: [String]
	let url: String
	let created: String
}

