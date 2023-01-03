//
//  RMLocationViewController.swift
//  RickAndMortyWiki
//
//  Created by Miroslav Berezovsky on 31.12.2022.
//

import UIKit

final class RMLocationViewController: UIViewController
{	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupNav()
		setupView()
	}
}

private extension RMLocationViewController
{
	func setupNav() {
		title = "Locations"
		navigationController?.navigationBar.prefersLargeTitles = true
		navigationItem.largeTitleDisplayMode = .automatic
	}

	func setupView() {
		view.backgroundColor = .systemBackground
	}
}
