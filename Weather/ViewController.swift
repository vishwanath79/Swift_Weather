//
//  ViewController.swift
//  Weather
//
//  Created by Subramanian, Vishwanath on 1/24/16.
//  Copyright © 2016 Vish. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

@IBOutlet var cityTextField: UITextField!


@IBAction func findWeather(sender: AnyObject) {
    
    var wasSuccessful = false
    
    let attempturl = NSURL(string: "http://www.weather-forecast.com/locations/" + cityTextField.text!.stringByReplacingOccurrencesOfString(" ", withString: "-") + "/forecasts/latest")
    
    if let url = attempturl {
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
            if let urlContent = data {
                
                let webContent = NSString(data: urlContent, encoding: NSUTF8StringEncoding)
                
                let websiteArray = webContent?.componentsSeparatedByString("3 Day Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">")
                
                if websiteArray!.count > 1 {
                    
                    //print(websiteArray![1])
                    
                    let weatherArray = websiteArray![1].componentsSeparatedByString("</span>")
                    
                    print(weatherArray[0])
                    
                    if weatherArray.count > 1 {
                        
                        wasSuccessful = true
                        
                        let weatherSummary = weatherArray[0].stringByReplacingOccurrencesOfString("&deg;", withString: "º")
                        
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            self.resultLabel.text = weatherSummary
                        })
                        
                    }
                    
                }
            }
            
            if wasSuccessful == false {
                self.resultLabel.text = "Could not find the weather.Check the city name again."
            } else {
                
                
            }
            
        }
        
        
        task.resume()
        
    } else {
        
        self.resultLabel.text = "Could not find the weather.Check the city name again."
        
        
    }
}

@IBOutlet var resultLabel: UILabel!



override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    
}

override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
}


}

