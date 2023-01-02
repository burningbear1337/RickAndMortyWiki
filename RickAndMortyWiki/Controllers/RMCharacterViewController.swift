//
//  RMCharacterViewController.swift
//  RickAndMortyWiki
//
//  Created by Miroslav Berezovsky on 31.12.2022.
//

import UIKit

final class RMCharacterViewController: UIViewController
{
	override func viewDidLoad() {
		super.viewDidLoad()
		setupNav()
		setupView()
		RMService.instance.execute(.listCharactersRequest, for: RMGetAllCharactersResponse.self) { result in
			switch result {
			case .success(let character):
				print(character)
			case .failure(let failure):
				print(failure)
			}
		}
	}
}

private extension RMCharacterViewController
{
	func setupNav() {
		title = "Characters"
		navigationController?.navigationBar.prefersLargeTitles = true
		navigationItem.largeTitleDisplayMode = .automatic
	}
	
	func setupView() {
		view.backgroundColor = .systemBackground
	}
}
