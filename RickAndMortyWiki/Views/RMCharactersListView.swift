//
//  RMCharactersListView.swift
//  RickAndMortyWiki
//
//  Created by Miroslav Berezovsky on 02.01.2023.
//

import UIKit

final class RMCharactersListView: UIView
{
	
	private let viewModel = RMCharactersListViewViewModel()
	
	private let spinner: UIActivityIndicatorView = {
		let spinner = UIActivityIndicatorView(style: .large)
		spinner.translatesAutoresizingMaskIntoConstraints = false
		spinner.hidesWhenStopped = true
		return spinner
	}()
	
	private let collectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical
		layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.register(RMCharacterCollectionViewCell.self,
								forCellWithReuseIdentifier: RMCharacterCollectionViewCell.cellID)
		collectionView.isHidden = true
		collectionView.alpha = 0
		return collectionView
	}()

	init() {
		super.init(frame: .zero)
		viewModel.delegate = self
		addSubViews()
		setupSpinner()
		spinner.startAnimating()
		setupCollectionView()
		viewModel.fetchCharacters()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension RMCharactersListView: RMCharactersListViewViewModelDelegate
{
	func didLoadInitialCharacters() {
		DispatchQueue.main.async {
			self.spinner.stopAnimating()
			UIView.animate(withDuration: 0.4) {
				self.collectionView.isHidden = false
				self.collectionView.alpha = 1
			}
			self.collectionView.reloadData()
		}
	}
}

private extension RMCharactersListView
{
	func addSubViews() {
		addSubviews(spinner, collectionView)
	}
	
	func setupSpinner() {
		NSLayoutConstraint.activate([
			spinner.heightAnchor.constraint(equalToConstant: 100),
			spinner.widthAnchor.constraint(equalToConstant: 100),
			spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
			spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
		])
	}
	
	func setupCollectionView() {
		collectionView.delegate = viewModel
		collectionView.dataSource = viewModel
		
		NSLayoutConstraint.activate([
			collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
			collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
			collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
			collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
		])
	}
}
