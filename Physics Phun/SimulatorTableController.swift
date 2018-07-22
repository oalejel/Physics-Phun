//
//  MasterViewController.swift
//  Physics Phun
//
//  Created by Omar Al-Ejel on 7/14/18.
//  Copyright © 2018 omaralejel. All rights reserved.
//

import UIKit

class SimulatorTableController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let statusBarHeight = UIApplication.shared.statusBarFrame.size.height
        let navBarHeight = navigationController!.navigationBar.frame.size.height
        let bounds = UIScreen.main.bounds
        var collectionViewFrame = bounds
        let layout = customFlowLayout()
        collectionViewFrame.size.height = bounds.height - (statusBarHeight + navBarHeight)
        collectionView = UICollectionView(frame: collectionViewFrame, collectionViewLayout: layout)
        view.addSubview(collectionView)
    }
    
    
    var didLayoutOnce = false
    override func viewDidLayoutSubviews() {
        if !didLayoutOnce {
            addGradient()
            didLayoutOnce = true
        }
    }
    

    
    func addGradient() {
//        let navBarHeight = navigationController!.navigationBar.frame.size.height
        let statusBarHeight = UIApplication.shared.statusBarFrame.size.height
        let bounds = UIScreen.main.bounds
        #warning("check to make sure that our defined origin works on all kinds of screens")
        let gradLayer = CAGradientLayer()
        gradLayer.frame = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height - statusBarHeight)
        gradLayer.colors = [UIColor.themeDeepBlue.cgColor, UIColor.themeBrightBlue.cgColor]
        view.layer.addSublayer(gradLayer)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Collection View Datasource and Delegate
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    // MARK: - Visual cusomization
    
    func customFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: 200, height: 200)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        
        return layout
    }
    
    
    
    
    
    
    
    // MARK: - Other / Unused
    
    func addCustomTitleLabel() {
        let navBarHeight = navigationController!.navigationBar.frame.size.height
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
        navigationController!.navigationBar.addSubview(customTitleLabel)
    }

}
