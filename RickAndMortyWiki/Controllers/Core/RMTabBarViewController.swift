//
//  ViewController.swift
//  RickAndMortyWiki
//
//  Created by Miroslav Berezovsky on 31.12.2022.
//

import UIKit

class RMTabBarViewController: UITabBarController {

	override func viewDidLoad() {
		super.viewDidLoad()
		setupTabBar()
	}
}

private extension RMTabBarViewController
{
	func setupTabBar() {
		let characterVC = UINavigationController(rootViewController: RMCharacterViewController())
		let locationVC = UINavigationController(rootViewController: RMLocationViewController())
		let episodeVC = UINavigationController(rootViewController: RMEpisodeViewController())
		let settingsVC = UINavigationController(rootViewController: RMSettingsViewController())
		
		characterVC.tabBarItem = UITabBarItem(title: "Characters",
											  image: UIImage(systemName: "person"),
											  tag: 1)
		locationVC.tabBarItem = UITabBarItem(title: "Locations",
											  image: UIImage(systemName: "globe"),
											  tag: 2)
		episodeVC.tabBarItem = UITabBarItem(title: "Episdoes",
											  image: UIImage(systemName: "tv"),
											  tag: 3)
		settingsVC.tabBarItem = UITabBarItem(title: "Settings",
											  image: UIImage(systemName: "gear"),
											  tag: 4)
		
		setViewControllers([characterVC,
						   locationVC,
						   episodeVC,
						   settingsVC],
						   animated: true)
	}
}

