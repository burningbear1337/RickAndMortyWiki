//
//  RMPhotoCollectionViewCell.swift
//  RickAndMortyWiki
//
//  Created by Miroslav Berezovsky on 09.01.2023.
//

import UIKit

class RMPhotoCollectionViewCell: UICollectionViewCell
{
	static let id = "RMPhotoCollectionViewCell"
	
	private let imageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFill
		imageView.clipsToBounds = true
		return imageView
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		imageView.image = nil
	}
	
	public func configure(with viewModel: RMPhotoCollectionViewCellViewModel) {
		viewModel.fetchImage { [weak self] result in
			switch result {
			case .success(let image):
				DispatchQueue.main.async {
					self?.imageView.image = image
				}
			case .failure(let error):
				print(error)
			}
		}
	}
}

private extension RMPhotoCollectionViewCell
{
	func setupView() {
		contentView.addSubview(imageView)
		NSLayoutConstraint.activate([
			imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
			imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
		])
	}
}
