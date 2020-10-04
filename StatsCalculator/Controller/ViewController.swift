//
//  ViewController.swift
//  StatsCalculator
//
//  Created by William Spell on 9/18/20.
//  Copyright © 2020 William Spell. All rights reserved.
//

import UIKit
import GoogleMobileAds

var content = "0.0"
var avgValue = 0.0
var length = 0.0
var doubles = [0]
var sum = 0.0
var min = 0.0
var max = 0.0
var range = 0.0
var median = 0.0
var mode = "0.0"
var modecounts = [Double: Double]()
var value = 0
var count = 0

class ViewController: UIViewController {
    private let banner: GADBannerView = {
        let banner = GADBannerView()
        banner.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        banner.load(GADRequest())
        banner.backgroundColor = .secondarySystemBackground
        return banner
    }()
    
    @IBOutlet weak var TextValue: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        banner.rootViewController = self
        view.addSubview(banner)
    }
    
    override func viewDidLayoutSubviews(){
        super.viewDidLayoutSubviews()
        banner.frame = CGRect(x: 0, y: view.frame.size.height-75, width: view.frame.size.width, height: 75).integral
        
    }
    
    
    func calculateMedian(array: [Double]) -> Double {
        guard length > 0 else {return 0}
        let sorted = array.sorted()
        if sorted.count % 2 == 0 {
            return Double((sorted[(sorted.count / 2)] + sorted[(sorted.count / 2) - 1])) / 2
        } else {
            return Double(sorted[(sorted.count - 1) / 2])
        }
    }
    
    
    
    @IBAction func submitButton(_ sender: UIButton) {
        //calculations done here
        content = TextValue.text
        let parsedCSV: [String] = content.components(separatedBy: (","))// parse
        let doubles = parsedCSV.compactMap(Double.init)
        length =   Double(doubles.count)
        sum = Double(doubles.reduce(0, +))
        min = doubles.min() ?? 0.0
        max = doubles.max() ?? 0.0
        avgValue = sum / length
        range = max - min
        median = calculateMedian(array: doubles)
        
        // calculate mode directly
        
        doubles.forEach { modecounts[$0] = (modecounts[$0] ?? 0) + 1 }
        if let (_, count) = modecounts.max(by: { $0.1 < $1.1 }) {
            if count == 1 {
                mode = "There are no repeated items."
            } else {
                let all = modecounts.compactMap { $1 == count ? $0 : nil }
                if all.count == 1 {
                    mode = "\(all.first!) is repeated \(count) times."
                } else {
                    mode = "The items \(all.sorted()) are repeated \(count) times each."
                }
            }
        } else {
            mode = "0.0"
        }
        //end mode calculation
        
        print(median)
        print(doubles)
        //print(parsedCSV)
        self.performSegue(withIdentifier: "GoToResults", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToResults"{
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.avgValue = String(avgValue)
            destinationVC.length = String(length)
            destinationVC.sum = String(sum)
            destinationVC.median = String(median)
            destinationVC.min = String(min)
            destinationVC.max = String(max)
            destinationVC.range = String(range)
            destinationVC.mode = mode
        }
    }

}

