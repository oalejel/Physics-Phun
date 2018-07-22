//
//  MainNavigationController.swift
//  Physics Phun
//
//  Created by Omar Al-Ejel on 7/22/18.
//  Copyright © 2018 omaralejel. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationBar.barTintColor = .themeDeepBlue
        addCustomTitleLabel()
        // remove the 1 pixel line beneat the navigation bar
        navigationBar.shadowImage = UIImage()
        
    }
    
    func addCustomTitleLabel() {
        let navBarHeight = navigationBar.frame.size.height
        let statusBarHeight = UIApplication.shared.statusBarFrame.size.height
        
        let customTitleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        customTitleLabel.textAlignment = .left
        customTitleLabel.text = "Physics Phun"
        customTitleLabel.textColor = .white
        
        let labelTopBottomPadding: CGFloat = 8
        let labelLeftPadding: CGFloat = 16
        
        // iterate through our fonts to get the height that
        // has 8 points between itself, the status bar, and the bottom of the navigation bar
        let fonts: [UIFont] = Array(10..<30).map { (testFontSize) -> UIFont in
            return UIFont.systemFont(ofSize: CGFloat(testFontSize), weight: .bold)
        }
        
        let goalHeight = navBarHeight - (labelTopBottomPadding * 2) - statusBarHeight
        let sortedFonts = fonts.sorted { (f1, f2) -> Bool in
            // sort by the font that is closest to the goal height
            abs(f1.lineHeight - goalHeight) > abs(f2.lineHeight - goalHeight)
        }
        
        customTitleLabel.font = sortedFonts.first
        customTitleLabel.sizeToFit()
        customTitleLabel.center = CGPoint(x: labelLeftPadding + customTitleLabel.frame.size.width / 2, y: navBarHeight / 2)
        navigationItem.titleView = customTitleLabel
        navigationBar.addSubview(customTitleLabel)
    }
   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
