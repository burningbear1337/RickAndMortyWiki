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
	}
}

private extension RMCharacterViewController
{
	func setupNav() {
		title = "Characters"
		navigationController?.navigationBar.prefersLargeTitles = true
		navigationItem.largeTitleDisplayMode = .automatic
	}
}
