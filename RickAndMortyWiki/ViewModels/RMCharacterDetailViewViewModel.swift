//
//  RMCharacterDetailViewViewModel.swift
//  RickAndMortyWiki
//
//  Created by Miroslav Berezovsky on 03.01.2023.
//

import Foundation

final class RMCharacterDetailViewViewModel
{
	private let character: RMCharacter
	
	public var title: String {
		character.name.uppercased()
	}
	
	init(character: RMCharacter) {
		self.character = character
	}
}
