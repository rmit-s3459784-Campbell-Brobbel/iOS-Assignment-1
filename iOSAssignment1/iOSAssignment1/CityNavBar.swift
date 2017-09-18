//
//  CityNavBar.swift
//  iOSAssignment1
//
//  Created by Campbell Brobbel on 23/8/17.
//  Copyright © 2017 CampbellRhys. All rights reserved.
//

import UIKit

protocol CityNavBarDelegate {
    func cancelButtonPressed()
}

class CityNavBar: UIVisualEffectView {

    @IBOutlet weak var cancelButton : UIButton!
    
    var delegate : CityNavBarDelegate?
    
    @IBAction func cancelPressed(sender: Any) {
        self.delegate?.cancelButtonPressed()
        
    }

}
