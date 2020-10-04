//
//  ResultsViewController.swift
//  StatsCalculator
//
//  Created by William Spell on 9/30/20.
//  Copyright © 2020 William Spell. All rights reserved.
//
import GoogleMobileAds
import UIKit

class ResultsViewController: UIViewController {
    var avgValue = "0.0"
    var length = "0.0"
    
    
    
    
    
    
    @IBOutlet weak var AverageLabel: UILabel!
    @IBOutlet weak var MedianLabel: UILabel!
    @IBOutlet weak var ModeLabel: UILabel!
    @IBOutlet weak var CountLabel: UILabel!
    @IBOutlet weak var SumLabel: UILabel!
    @IBOutlet weak var LargestLabel: UILabel!
    @IBOutlet weak var SmallestLabel: UILabel!
    @IBOutlet weak var RangeLabel: UILabel!
    @IBOutlet weak var GeometricMeanLabel: UILabel!
    @IBOutlet weak var StandardDeviationLabel: UILabel!
    @IBOutlet weak var VarianceLabel: UILabel!
    @IBOutlet weak var SampleSDLabel: UILabel!
    @IBOutlet weak var SampleVarianceLabel: UILabel!
    
    
    
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
        
        // add labels/calculations here
        AverageLabel.text = avgValue
        CountLabel.text = length
    }
    override func viewDidLayoutSubviews(){
        super.viewDidLayoutSubviews()
        banner.frame = CGRect(x: 0, y: view.frame.size.height-75, width: view.frame.size.width, height: 75).integral
        
    }
    
    @IBAction func RecalculateButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
