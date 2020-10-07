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
    var min = "0.0"
    var max = "0.0"
    var sum = "0.0"
    var range = "0.0"
    var median = "0.0"
    var mode = "0.0"
    var geomean = "0.0"
    var stddev = "0.0"
    var variance = "0.0"
    var samplestddev = "0.0"
    var samplevariance = "0.0"
    
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
        banner.adUnitID = "ca-app-pub-1590976018869330/9963539835"
        banner.load(GADRequest())
        banner.backgroundColor = .secondarySystemBackground
        return banner
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        banner.rootViewController = self
        view.addSubview(banner)
        //labels here
        AverageLabel.text = avgValue
        MedianLabel.text = median
        ModeLabel.text = mode
        CountLabel.text = length
        SumLabel.text = sum
        LargestLabel.text = max
        SmallestLabel.text = min
        RangeLabel.text = range
        GeometricMeanLabel.text = geomean
        StandardDeviationLabel.text = stddev
        VarianceLabel.text = variance
        SampleSDLabel.text = samplestddev
        SampleVarianceLabel.text = samplevariance
    }
    override func viewDidLayoutSubviews(){
        super.viewDidLayoutSubviews()
        banner.frame = CGRect(x: 0, y: view.frame.size.height-75, width: view.frame.size.width, height: 75).integral
        
    }
    
    @IBAction func RecalculateButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
