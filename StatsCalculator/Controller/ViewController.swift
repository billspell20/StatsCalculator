//
//  ViewController.swift
//  StatsCalculator
//
//  Created by Kirby Bright on 9/18/20.
//  Copyright © 2020 William Spell. All rights reserved.
//

import UIKit
import GoogleMobileAds
class ViewController: UIViewController {
    
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
    }
    

}

