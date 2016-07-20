//
//  PPCollectionController.swift
//  Trumpean Proverbs
//
//  Created by Omar Alejel on 1/31/16.
//  Copyright © 2016 omaralejel. All rights reserved.
//

import UIKit
import AVFoundation

private let reuseIdentifier = "cell"
let numberOfItems = 19

class PPCollectionController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var imageIndex = 0
    let bounds = UIScreen.mainScreen().bounds
    let offset: CGFloat = 5
//    var titles: [String!] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.whiteColor()
        collectionView?.backgroundColor = UIColor.whiteColor()
        
        
        //set images array
//        for i in 0...11 {
//            let image = UIImage(named: "\(i).png")
//            faceImages.append(image!)
//            
//            let session = AVAudioSession()
//            try! session.setActive(true)
//            try! session.setCategory(AVAudioSessionCategoryPlayback)
//        }
        
        //set sounds array
//        for soundIndex in 0...18 {
//            let soundName = "s\(soundIndex)"//has an s before the number
//            let p = NSBundle.mainBundle().pathForResource(soundName, ofType: "mp3")
//            let player = try! AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: p!))
//            soundPlayers.append(player)
//        }
//        
//        //set titles array
//        titles = ["Great again", "A small loan", "God's creation", "I'm very rich", "Stupid", "I'm really smart!", "When do we beat Mexico?", "They're laughing at us", "They're bringing drugs", "Wall builder", "Mexico pays", "Like Dogs", "They love me", "You're fired!", "I would bomb...", "I LIKE CHINA!", "Bicycle Race", "American dream is dead", "Great again (2)"]
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
//        let bgNames = ["b1.jpg", "b2.jpg", "b3.jpg", "b4.jpg", "b0.jpg"]
//        var images: [UIImage] = []
//        
//        for name in bgNames {
//            let image = UIImage(named: name)
//            images.append(image!)
//        }
        

    }
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let x = (bounds.size.width / 3) - (3 * offset)
        return CGSizeMake(x, x)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
        
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 20
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! PPCell
    
//        // Configure the cell
////        cell.imageView.image = faceImages[imageIndex]
//        cell.layer.cornerRadius = 10
//        
//       // cell.backgroundColor = UIColor.redColor()
//        imageIndex += 1
//        if imageIndex == faceImages.count {
//            imageIndex = 0
//        }
//        
//        if indexPath.row < titles.count {
////            cell.textView.text = titles[indexPath.row]
//        }
    
        return cell
    }
    


    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        print("select")
//        if indexPath.row < soundPlayers.count {
//            soundPlayers[indexPath.row].play()
//        }
        return false
    }
    

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
