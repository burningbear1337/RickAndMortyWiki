//
//  RMEpisodeViewController.swift
//  RickAndMortyWiki
//
//  Created by Miroslav Berezovsky on 31.12.2022.
//

import UIKit

final class RMEpisodeViewController: UIViewController
{
	override func viewDidLoad() {
		super.viewDidLoad()
		setupNav()
	}
}

private extension RMEpisodeViewController
{
	func setupNav() {
		title = "Episodes"
		navigationController?.navigationBar.prefersLargeTitles = true
		navigationItem.largeTitleDisplayMode = .automatic
	}
}
