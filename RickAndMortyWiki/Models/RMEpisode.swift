//
//  RMEpisode.swift
//  RickAndMortyWiki
//
//  Created by Miroslav Berezovsky on 31.12.2022.
//

struct RMEpisode: Codable
{
	let id: Int
	let name: String
	let air_date: String
	let episode: String
	let characters: [String]
	let url: String
	let created: String
}
