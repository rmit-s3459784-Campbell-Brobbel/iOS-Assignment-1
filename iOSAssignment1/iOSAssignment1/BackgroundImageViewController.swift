//
//  BackgroundImageViewController.swift
//  iOSAssignment1
//
//  Created by Campbell Brobbel on 8/8/17.
//  Copyright © 2017 CampbellRhys. All rights reserved.
//

import UIKit

class BackgroundImageViewController: UIViewController {
    
    var weatherType : WeatherType?
    @IBOutlet weak var imageView : UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Background Image Loaded")
        if self.weatherType == .Rain {
            self.imageView.image = #imageLiteral(resourceName: "Storm")
        }
        else {
            self.imageView.image = #imageLiteral(resourceName: "Sunny Day")
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("Background Will Appear")
        self.updateBackgroundImage()
        
    }
    
    func updateBackgroundImage() {
        if self.weatherType == .Rain  || self.weatherType == .Clouds {
            self.imageView.image = #imageLiteral(resourceName: "Storm")
        }
        else {
            self.imageView.image = #imageLiteral(resourceName: "Sunny Day")
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
