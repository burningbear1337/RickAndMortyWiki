//
//  Extesions.swift
//  RickAndMortyWiki
//
//  Created by Miroslav Berezovsky on 02.01.2023.
//

import UIKit

extension UIView
{
	public func addSubviews(_ view: UIView...) {
		view.forEach { addSubview($0) }
	}
}
