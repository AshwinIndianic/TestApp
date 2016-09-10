//
//  ViewController.swift
//  TestApp
//
//  Created by indianic on 07/09/16.
//  Copyright © 2016 indianic. All rights reserved.
//

import UIKit

class ViewController: UIViewController,BTDropInViewControllerDelegate {

    var braintreeClient: BTAPIClient?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let clientTokenURL = NSURL(string: "https://braintree-sample-merchant.herokuapp.com/client_token")!
        let clientTokenRequest = NSMutableURLRequest(URL: clientTokenURL)
        clientTokenRequest.setValue("text/plain", forHTTPHeaderField: "Accept")
        
        NSURLSession.sharedSession().dataTaskWithRequest(clientTokenRequest) { (data, response, error) -> Void in
            // TODO: Handle errors
//            NSLog("Data %@", data!)
//            NSLog("response %@", response!)
            
            let clientToken = String(data: data!, encoding: NSUTF8StringEncoding)
//            NSLog("clientToken %@", clientToken!)
            self.braintreeClient = BTAPIClient(authorization: clientToken!)
            // As an example, you may wish to present our Drop-in UI at this point.
            // Continue to the next section to learn more...
            }.resume()
        
    }

    override func viewWillAppear(animated: Bool) {
        self.showAnAlert()
    }
    
    
    @IBAction func btnTapped(sender : UIButton) -> Void {
//        self.showAnAlert()
        self.tappedMyPayButton()
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

    func postNonceToServer(paymentMethodNonce: String) {
        let paymentURL = NSURL(string: "https://your-server.example.com/payment-methods")!
        let request = NSMutableURLRequest(URL: paymentURL)
        request.HTTPBody = "payment_method_nonce=\(paymentMethodNonce)".dataUsingEncoding(NSUTF8StringEncoding)
        request.HTTPMethod = "POST"
        
        NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
            // TODO: Handle success or failure
//            NSLog("Data %@", data!)
//            NSLog("response %@", response!)
            print(error)
            }.resume()
    }
    
    func dropInViewController(viewController: BTDropInViewController, didSucceedWithTokenization paymentMethodNonce: BTPaymentMethodNonce) {
        postNonceToServer(paymentMethodNonce.nonce)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func dropInViewControllerDidCancel(viewController: BTDropInViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func tappedMyPayButton() {
        
        // If you haven't already, create and retain a `BTAPIClient` instance with a
        // tokenization key OR a client token from your server.
        // Typically, you only need to do this once per session.
        // braintreeClient = BTAPIClient(authorization: CLIENT_AUTHORIZATION)
        
        // Create a BTDropInViewController
        let dropInViewController = BTDropInViewController(APIClient: braintreeClient!)
        dropInViewController.delegate = self
        
        // This is where you might want to customize your view controller (see below)
        
        // The way you present your BTDropInViewController instance is up to you.
        // In this example, we wrap it in a new, modally-presented navigation controller:
        dropInViewController.navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: UIBarButtonSystemItem.Cancel,
            target: self, action: #selector(ViewController.userDidCancelPayment))
        let navigationController = UINavigationController(rootViewController: dropInViewController)
        presentViewController(navigationController, animated: true, completion: nil)
    }
    
    func userDidCancelPayment() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    

}

