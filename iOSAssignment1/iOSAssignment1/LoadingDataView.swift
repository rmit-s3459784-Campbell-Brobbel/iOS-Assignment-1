//
//  LoadingDataView.swift
//  iOSAssignment1
//
//  Created by Campbell Brobbel on 6/10/17.
//  Copyright © 2017 CampbellRhys. All rights reserved.
//

import UIKit

class LoadingDataView: UIView {

    // MARK:- IBOutlets

    @IBOutlet weak var textLabel : UILabel!
    @IBOutlet weak var activityIndicator : UIActivityIndicatorView!
   
    
    // MARK:- Custom Methods

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
