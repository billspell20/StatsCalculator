//
//  ViewController.swift
//  StatsCalculator
//
//  Created by William Spell on 9/18/20.
//  Copyright © 2020 William Spell. All rights reserved.
//

import UIKit
import GoogleMobileAds
class ViewController: UIViewController {
    var avgValue = "0.0"
    private let banner: GADBannerView = {
        let banner = GADBannerView()
        banner.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        banner.load(GADRequest())
        banner.backgroundColor = .secondarySystemBackground
        return banner
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        banner.rootViewController = self
        view.addSubview(banner)
    }
    override func viewDidLayoutSubviews(){
        super.viewDidLayoutSubviews()
        banner.frame = CGRect(x: 0, y: view.frame.size.height-75, width: view.frame.size.width, height: 75).integral
        
    }
    @IBOutlet weak var textValue: UITextView!
    @IBAction func submitButton(_ sender: UIButton) {
        //calculate here, need to grab text values, perform on csv's
        self.performSegue(withIdentifier: "GoToResults", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToResults"{
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.avgValue = "0.0"
        }
    }

}

