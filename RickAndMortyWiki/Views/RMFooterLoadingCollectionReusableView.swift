//
//  RMFooterLoadingCollectionReusableView.swift
//  RickAndMortyWiki
//
//  Created by Miroslav Berezovsky on 03.01.2023.
//

import UIKit

final class RMFooterLoadingCollectionReusableView: UICollectionReusableView
{
	static let identifier = "RMFooterLoadingCollectionReusableView"
	
	private let spinner: UIActivityIndicatorView = {
		let spinner = UIActivityIndicatorView(style: .large)
		spinner.translatesAutoresizingMaskIntoConstraints = false
		spinner.hidesWhenStopped = true
		return spinner
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		addConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	public func startAnimating() {
		spinner.startAnimating()
	}
}

private extension RMFooterLoadingCollectionReusableView
{
	func addConstraints() {
		addSubview(spinner)
		NSLayoutConstraint.activate([
			spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
			spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
			spinner.heightAnchor.constraint(equalToConstant: 30),
			spinner.widthAnchor.constraint(equalToConstant: 30),
		])
	}
}
