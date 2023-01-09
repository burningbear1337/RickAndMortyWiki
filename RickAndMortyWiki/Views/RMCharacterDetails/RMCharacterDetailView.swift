//
//  RMCharacterDetailView.swift
//  RickAndMortyWiki
//
//  Created by Miroslav Berezovsky on 03.01.2023.
//

import UIKit

final class RMCharacterDetailView: UIView
{
	private let viewModel: RMCharacterDetailViewViewModel
	
//	private var collectionView: UICollectionView?
	
	private let spinner: UIActivityIndicatorView = {
		let spinner = UIActivityIndicatorView(style: .large)
		spinner.translatesAutoresizingMaskIntoConstraints = false
		spinner.hidesWhenStopped = true
		return spinner
	}()
	
	init(characterViewModel: RMCharacterDetailViewViewModel) {
		self.viewModel = characterViewModel
		super.init(frame: .zero)
		backgroundColor = .systemBackground
		setupView()
		
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

private extension RMCharacterDetailView
{
	func setupView() {
		let collectionView = viewModel.makeCollectionView()
		addSubviews(collectionView, spinner)
		NSLayoutConstraint.activate([
			collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
			collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
			collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
			collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
		])
	}
}
