//
//  InfoTextViewController.swift
//  Physics Phun
//
//  Created by Omar Alejel on 7/30/16.
//  Copyright © 2016 omaralejel. All rights reserved.
//

import UIKit

class InfoTextViewController: UIViewController {
    
    @IBOutlet var textView: UITextView!
    var textViewString = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        textView.text = textViewString
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
