//
//  AddEventViewController.swift
//  iOSAssignment1
//
//  Created by Campbell Brobbel on 27/9/17.
//  Copyright © 2017 CampbellRhys. All rights reserved.
//

import UIKit

class AddEventViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView : UITableView!
    
    @IBAction func dismissView() {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "datePickerCell") as! EventDatePickerTableViewCell
            cell.datePicker.setValue(UIColor.white, forKey: "textColor")
            cell.datePicker.perform("setHighlightsToday:", with: UIColor.white)
            return cell
        }
        if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell")!
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell") as! EventTextFieldTableViewCell
        cell.textField.placeholder = "Event Title e.g. Basketball Game"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
            
        // Date Picker Cell
        case 1:
            return 200
        default:
            return 40
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 40
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
