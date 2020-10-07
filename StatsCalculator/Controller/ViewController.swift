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
var value = 0
var count = 0
var geomean = 0.0
var stddev = 0.0
var variance = 0.0
var samplestddev = 0.0
var samplevariance = 0.0
var mycharset = "0123456789.,-"

class ViewController: UIViewController, UITextViewDelegate {
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
        TextValue.delegate = self
        TextValue.text = "Enter values here"
        TextValue.textColor = UIColor.placeholderText
        //code below enables numbers+punctuation keyboard
        self.TextValue.keyboardType = UIKeyboardType.numbersAndPunctuation
    }
    
    override func viewDidLayoutSubviews(){
        super.viewDidLayoutSubviews()
        banner.frame = CGRect(x: 0, y: view.frame.size.height-75, width: view.frame.size.width, height: 75).integral
        
    }
    
    @IBOutlet weak var TextValue: UITextView!
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        /// 1. replacementText is NOT empty means we are entering text or pasting text: perform the logic
        /// 2. replacementText is empty means we are deleting text: return true
        if text.count > 0 {
            let allowedCharacters = CharacterSet.init(charactersIn: mycharset)
            let unwantedStr = text.trimmingCharacters(in: allowedCharacters)
            return unwantedStr.count == 0
        }

        return true
    }
    //UITextView placeholder functionality
    func textViewDidBeginEditing(_ TextValue: UITextView) {
        if TextValue.textColor == UIColor.placeholderText {
            TextValue.text = nil
            TextValue.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ TextValue: UITextView) {
        if TextValue.text.isEmpty {
            TextValue.text = "Enter values here"
            TextValue.textColor = UIColor.placeholderText
        }
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
        //calculations/parsing done here
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
        
        // calculate mode
        var modecounts = [Double: Double]()
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
        
        //geometric mean
        geomean = pow(doubles.reduce(1.0, *), 1.0 / length)
        
        //standard deviation
        let sumOfSquaredAvgDiff = doubles.map { pow($0 - avgValue, 2.0)}.reduce(0, {$0 + $1})
        stddev = sqrt(sumOfSquaredAvgDiff / length)
        
        //variance
        variance = pow(stddev, 2)
        
        //sample standard dev
        samplestddev = sqrt(sumOfSquaredAvgDiff / (length-1))
        
        //sample var
        samplevariance = pow(samplestddev, 2)
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
            destinationVC.geomean = String(format: "%.05f", geomean)
            destinationVC.stddev = String(format: "%.05f", stddev)
            destinationVC.variance = String(format: "%.05f", variance)
            destinationVC.samplestddev = String(format: "%.05f", samplestddev)
            destinationVC.samplevariance = String(format: "%.05f", samplevariance)
        }
    }

}
