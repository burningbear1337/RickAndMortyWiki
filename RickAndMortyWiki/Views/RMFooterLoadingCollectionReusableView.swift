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
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		addConstraints() 
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

private extension RMFooterLoadingCollectionReusableView
{
	func addConstraints() {
		
	}
}
