//
//  BackgroundImageViewController.swift
//  iOSAssignment1
//
//  Created by Campbell Brobbel on 8/8/17.
//  Copyright © 2017 CampbellRhys. All rights reserved.
//

import UIKit

class BackgroundImageViewController: UIViewController {
    
    
    // MARK: - IBOutlets/Variables
    var weatherType : WeatherType?
    @IBOutlet weak var imageView : UIImageView!
    
    // MARK: - View Methods
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
    
    override func viewWillAppear(_ animated: Bool) {
        print("Background Will Appear")
        self.updateBackgroundImage()
        
    }
    
    // MARK: - Other Functions
    /// Updates the image based on weather type.
    func updateBackgroundImage() {
        if self.weatherType == .Rain  || self.weatherType == .Clouds {
            self.imageView.image = #imageLiteral(resourceName: "Storm")
        }
        else {
            self.imageView.image = #imageLiteral(resourceName: "Sunny Day")
        }
    }

}
