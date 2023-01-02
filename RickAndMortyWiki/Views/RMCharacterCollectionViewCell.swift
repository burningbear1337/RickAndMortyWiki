//
//  RMCharacterCollectionViewCell.swift
//  RickAndMortyWiki
//
//  Created by Miroslav Berezovsky on 02.01.2023.
//

import UIKit

final class RMCharacterCollectionViewCell: UICollectionViewCell
{
	static let cellID = "RMCharacterCollectionViewCell"
	
	private let imageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFit
		return imageView
	}()
	
	private let nameLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = .label
		label.font = .systemFont(ofSize: 18, weight: .semibold)
		return label
	}()
	
	private let statusLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = .secondaryLabel
		label.font = .systemFont(ofSize: 16, weight: .regular)
		return label
	}()

	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupStyle()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	public func configure(with viewModel: RMCharacterCollectionViewCellViewModel) {
		nameLabel.text = viewModel.characterName
		statusLabel.text = viewModel.characterStatusText
		viewModel.fetchImage { [weak self] result in
			switch result {
			case .success(let image):
				DispatchQueue.main.async {				
					self?.imageView.image = image
				}
			case .failure(let error):
				print(error)
				break
			}
		}
	}
}

private extension RMCharacterCollectionViewCell
{
	func setupStyle() {
		contentView.backgroundColor = .secondarySystemBackground
		contentView.addSubviews(imageView, nameLabel, statusLabel)
		
		NSLayoutConstraint.activate([
			statusLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
			statusLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
			statusLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
			statusLabel.heightAnchor.constraint(equalToConstant: 40),
			
			nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
			nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
			nameLabel.bottomAnchor.constraint(equalTo: statusLabel.topAnchor, constant: -5),
			nameLabel.heightAnchor.constraint(equalToConstant: 40),
			
			imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
			imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
			imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
			imageView.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -5),
		])
	}
}
