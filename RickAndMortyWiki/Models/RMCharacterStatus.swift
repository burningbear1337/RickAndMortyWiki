//
//  RMCharacterStatus.swift
//  RickAndMortyWiki
//
//  Created by Miroslav Berezovsky on 01.01.2023.
//

enum RMCharacterStatus:String, Codable
{
	case dead = "Dead"
	case alive = "Alive"
	case `unknown` = "unknown"
	
	var text: String {
		switch self {
		case .dead, .alive:
			return rawValue
		case .unknown:
			return "Unknown"
		}
	}
}
