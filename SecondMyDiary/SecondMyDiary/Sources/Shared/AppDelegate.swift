//
//  AppDelegate.swift
//  SecondMyDiary
//
//  Created by 김종서 on 2018. 9. 10..
//  Copyright © 2018년 김종서. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        customizeNavigationBar()
        
        if
            let navigationController = window?.rootViewController as? UINavigationController,
            let timelineViewController = navigationController.topViewController as? TimelineViewController {
            let repo = InMemoryEntryRepository(entries:[
                Entry(text: "일기_1"),
                Entry(text: "일기_2"),
                Entry(text: "일기_3")
                ]
            )
            timelineViewController.environment = Environment(
                entryRepository: repo
            )
        }
        
        return true
    }
    
    private func customizeNavigationBar() {
        if let navigationController = window?.rootViewController as?
            UINavigationController {
            navigationController.navigationBar.prefersLargeTitles = true
            navigationController.navigationBar.barStyle = .black
            navigationController.navigationBar.tintColor = UIColor.white
            
            let bgImage = UIImage.gradientImage(with: [.gradientStart, .gradientEnd], size: CGSize(width: UIScreen.main.bounds.width, height: 1))
            navigationController.navigationBar.barTintColor = UIColor(patternImage: bgImage!)
        }
    }
}

