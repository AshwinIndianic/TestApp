//
//  ViewController.swift
//  TestApp
//
//  Created by indianic on 07/09/16.
//  Copyright © 2016 indianic. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(animated: Bool) {
        self.showAnAlert()
    }
    
    
    @IBAction func btnTapped(sender : UIButton) -> Void {
        self.showAnAlert()
    }
    
    func showAnAlert() -> Void {
        let alert = UIAlertController(title: "Alert", message: "Hello ashwin this build is seems okay up to now", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

