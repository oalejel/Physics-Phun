//
//  ExperimentViewController.swift
//  Physics Phun
//
//  Created by Omar Al-Ejel on 8/14/18.
//  Copyright © 2018 omaralejel. All rights reserved.
//

import UIKit

@IBDesignable class ExperimentViewController: UIViewController {
    
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
