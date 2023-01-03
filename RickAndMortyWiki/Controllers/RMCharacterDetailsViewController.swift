//
//  RMCharacterDetailsViewController.swift
//  RickAndMortyWiki
//
//  Created by Miroslav Berezovsky on 03.01.2023.
//

import UIKit

final class RMCharacterDetailsViewController: UIViewController
{
	private let viewModel: RMCharacterDetailViewViewModel
	
	init(viewModel: RMCharacterDetailViewViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground
		title = viewModel.title
	}
}
