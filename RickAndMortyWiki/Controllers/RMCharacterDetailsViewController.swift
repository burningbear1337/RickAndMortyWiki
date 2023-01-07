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
	private lazy var ui = RMCharacterDetailView(characterViewModel: self.viewModel)
	
	init(viewModel: RMCharacterDetailViewViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func loadView() {
		super.loadView()
		view = ui
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupNav()
	}
}

private extension RMCharacterDetailsViewController
{
	func setupNav() {
		title = viewModel.title
		navigationItem.rightBarButtonItem = UIBarButtonItem(
			image: UIImage(systemName: "square.and.arrow.up"),
			style: .plain,
			target: self,
			action: #selector(didTapShare)
		)
	}
	
	@objc
	func didTapShare() {
		print("sharing")
	}
}
