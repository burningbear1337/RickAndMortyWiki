//
//  RMSettingsViewController.swift
//  RickAndMortyWiki
//
//  Created by Miroslav Berezovsky on 31.12.2022.
//

import UIKit

final class RMSettingsViewController: UIViewController
{
	override func viewDidLoad() {
		super.viewDidLoad()
		setupNav()
	}
}

private extension RMSettingsViewController
{
	func setupNav() {
		title = "Settings"
		navigationController?.navigationBar.prefersLargeTitles = true
		navigationItem.largeTitleDisplayMode = .automatic
	}
}
