//
//  RMEpisodeCollectionViewCell.swift
//  RickAndMortyWiki
//
//  Created by Miroslav Berezovsky on 09.01.2023.
//

import UIKit

class RMEpisodeCollectionViewCell: UICollectionViewCell {
	static let id = "RMEpisodeCollectionViewCell"
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
	}
	
	public func configure(with viewModel: RMEpisodeCollectionViewCellViewModel) {
		
	}
}

private extension RMEpisodeCollectionViewCell
{
	func setupView() {
		contentView.backgroundColor = .tertiarySystemBackground
		contentView.layer.cornerRadius = 8
	}
}

