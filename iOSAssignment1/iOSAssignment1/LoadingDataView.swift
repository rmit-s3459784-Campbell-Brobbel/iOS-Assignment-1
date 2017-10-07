//
//  LoadingDataView.swift
//  iOSAssignment1
//
//  Created by Campbell Brobbel on 6/10/17.
//  Copyright © 2017 CampbellRhys. All rights reserved.
//

import UIKit

class LoadingDataView: UIView {

    @IBOutlet weak var textLabel : UILabel!
    @IBOutlet weak var activityIndicator : UIActivityIndicatorView!
        
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    func showView() {
        self.alpha = 1
    }
    
    func hideView() {
        UIView.animate(withDuration: 0.5, animations: {self.alpha = 0}, completion: { finished in
            self.removeFromSuperview()
        
        })
    }
    
    func changeLabelTextTo(string : String) {
        self.textLabel.text = string
    }
    
    func startAnimatingIndicator() {
        self.activityIndicator.startAnimating()
    }
    func stopAnimatingIndicator() {
        self.activityIndicator.stopAnimating()
    }

}
