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
    
    /// Button for cancelling a city selection.
    @IBOutlet weak var cancelButton : UIButton!
    
    /// reference to a CityNavBarDelegate Object.
    var delegate : CityNavBarDelegate?
    
    // MARK:- IBActions
    
    /// Sends a method to the delegate to say that the cancel button was pressed.
    @IBAction func cancelPressed(sender: Any) {
        self.delegate?.cancelButtonPressed()
        
    }

}
