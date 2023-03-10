//
//  RMCharacterViewController.swift
//  RickAndMortyWiki
//
//  Created by Miroslav Berezovsky on 31.12.2022.
//

import UIKit

final class RMCharacterViewController: UIViewController
{
	private let ui = RMCharactersListView()
	
	override func loadView() {
		super.loadView()
		view = ui
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		ui.delegate = self
		setupNav()
		setupView()
	}
}

extension RMCharacterViewController: RMCharactersListViewDelegate
{
	func rmCharacterListView(_ view: RMCharactersListView,
							 didSelectCharacter character: RMCharacter) {
		let viewModel = RMCharacterDetailViewViewModel(character: character)
		let vc = RMCharacterDetailsViewController(viewModel: viewModel)
		vc.navigationItem.largeTitleDisplayMode = .never
		navigationController?.pushViewController(vc, animated: true)
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
