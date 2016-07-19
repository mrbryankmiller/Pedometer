//
//  ViewController.swift
//  Pedometer
//
//  Created by Bryan  Miller on 7/19/16.
//  Copyright © 2016 Bryan  Miller. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {

    var pedometer :CMPedometer!
    
    var numberOfSteps :[NSNumber]!
    
    
    @IBOutlet weak var graphView :GraphView!
    
   // var anotherGraphView :GraphView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // self.anotherGraphView.backgroundColor = UIColor.yellowColor()
        
        self.numberOfSteps = [NSNumber]()
        self.pedometer = CMPedometer()
        
        gatherHistoricalData()
        
    }
    
    private func drawThePoints() {
        print("draw the points")
    }
    
    private func gatherHistoricalData() {
        
        //NSDate() fecth the date
        
        //run a loop below (included these values)
        
        for day in 1...7 {
            
            let calendar = NSCalendar.currentCalendar()
            guard let startDate = calendar.dateByAddingUnit(.Day, value: -1 * day, toDate: NSDate(), options: []) else {
                fatalError("Unable to get date")
            }
            
            self.pedometer.queryPedometerDataFromDate(startDate, toDate: NSDate()) { (data :CMPedometerData?, error :NSError?) in
                
                if error == nil {
                    
                    if let data = data {
                        
                        if self.numberOfSteps.count > 0 {
                            
                            let previousSteps = self.numberOfSteps[self.numberOfSteps.count - 1]
                            
                            let currentSteps =  data.numberOfSteps.intValue - previousSteps.intValue
                            
                            self.numberOfSteps.append(NSNumber(int: currentSteps))
                            
                            if self.numberOfSteps.count == 7 {
                                // call a different method
                                
                                dispatch_async(dispatch_get_main_queue(), {
                                    //self.GraphView = GraphView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
                                    
                                    //self.view.addSubview(self.anotherGraphView)
                                    
                                    self.graphView.plot(self.numberOfSteps)
                                    
                                })
                                
                                
                                // self.graphView.plot(self.numberOfSteps)
                            }
                            
                            
                        } else {
                            self.numberOfSteps.append(data.numberOfSteps)
                        }
                    }
                }
            }
            
            // accessing the array
            
            
            
        }
    }
    
    @IBAction func publishHistoricalRecords() {
        
        self.graphView.plot(self.numberOfSteps)
        
        for data in self.numberOfSteps {
            print(data)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}