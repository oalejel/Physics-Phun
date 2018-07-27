//
//  MasterViewController.swift
//  Physics Phun
//
//  Created by Omar Al-Ejel on 7/14/18.
//  Copyright © 2018 omaralejel. All rights reserved.
//

import UIKit

class SimulatorCollectionController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, CALayerDelegate {

    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var physicistHeaderView: PhysicistHeaderView?
    
    var maskGradient: CAGradientLayer?
    
    // we do not have enough content to necessitate continuous dequeuing of the headerview and cell
    var headerViews: [IndexPath:UICollectionReusableView] = [:]
//    var cells: [IndexPath:UICollectionViewCell] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let statusBarHeight = UIApplication.shared.statusBarFrame.size.height
        let navBarHeight = navigationController!.navigationBar.frame.size.height
        let bounds = UIScreen.main.bounds
        var collectionViewFrame = bounds
        let layout = customFlowLayout()
        collectionViewFrame.size.height = bounds.height - (statusBarHeight + navBarHeight)
//        collectionView = UICollectionView(frame: collectionViewFrame, collectionViewLayout: layout)
        collectionView.setCollectionViewLayout(layout, animated: false)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.delaysContentTouches = false
        
        // register collection view nibs
        collectionView.register(UINib(nibName: "NewExperimentCell", bundle:  nil), forCellWithReuseIdentifier: "experimentCell")
        collectionView.register(UINib(nibName: "PhysicistHeaderView", bundle:  nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerView")
        collectionView.register(UINib(nibName: "ExperimentHeaderView", bundle:  nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "experimentView")
        view.addSubview(collectionView)
        
        // make our screen fade away on top and bottom edges
        addMaskGradient()
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
        let gradLayer = CAGradientLayer()
        gradLayer.frame = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height - statusBarHeight)
        gradLayer.colors = [UIColor.themeDeepBlue.cgColor, UIColor.themeBrightBlue.cgColor]
        view.layer.insertSublayer(gradLayer, at: 0)
    }
    
    func addMaskGradient() {
        let statusBarHeight = UIApplication.shared.statusBarFrame.size.height
        let bounds = UIScreen.main.bounds
        maskGradient = CAGradientLayer()
        let gradFrame = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height - statusBarHeight)
        maskGradient!.frame = gradFrame
        maskGradient!.delegate = self
        maskGradient!.colors = [UIColor.clear.cgColor, UIColor.white.cgColor, UIColor.white.cgColor, UIColor.white.cgColor, UIColor.white.cgColor, UIColor.clear.cgColor]
        
        collectionView.layer.mask = maskGradient
    }
    
    // must update the mask
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        maskGradient?.frame = CGRect(
            x: 0,
            y: scrollView.contentOffset.y,
            width: scrollView.bounds.width,
            height: scrollView.bounds.height
        )
    }
    
    // MARK: - Collection View Datasource and Delegate
    //NOTE: assigning the physicist header view to the first section, and everything else to section 1 onward
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // number of themes == number of sections
        return Experiments.list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? 0 : Experiments.list[section - 1].simulations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let experimentCell = collectionView.dequeueReusableCell(withReuseIdentifier: "experimentCell", for: indexPath)
        
        return experimentCell
    }
    
    // need a header for the "Physicist of the day" section
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionElementKindSectionHeader {
            // first check if we already have one. no reason to dequeue the few headers we have
            if let hv = headerViews[indexPath] {
                return hv
            }
            
            var headerView: UICollectionReusableView!
            if indexPath.section == 0 {
                physicistHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerView", for: indexPath) as? PhysicistHeaderView
                headerView = physicistHeaderView
                physicistHeaderView?.newPhysicist()
            } else {
                // should be going here after row 0 for physics view
                // header view for a specific physics theme
                let experimentHeader = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "experimentView", for: indexPath) as? ExperimentHeaderView
                experimentHeader?.titleLabel.text = Experiments.list[indexPath.section - 1].title
                headerView = experimentHeader!
            }
            
            // add to our dictionary and return
            headerViews[indexPath] = headerView
            return headerView
        } else {
            return UICollectionReusableView()
        }
    }
    
    
    // MARK: - Visual cusomization
    
    @objc func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        // for the physicist info header, we return this size. otherwise, we are dealing with a title header
        let bounds = UIScreen.main.bounds
        if section == 0 {
            return CGSize(width: bounds.size.width, height: bounds.size.height / 2)
        } else {
            return CGSize(width: bounds.size.width, height: 30)
        }
    }

    
    func customFlowLayout() -> UICollectionViewFlowLayout {
        
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: 200, height: 200)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        
        return layout
    }
    
    
    
    
    
    // MARK: - CALayer (mainly for gradient mask and avoiding animation lag)
    
    func action(for layer: CALayer, forKey event: String) -> CAAction? {
        return NSNull()
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