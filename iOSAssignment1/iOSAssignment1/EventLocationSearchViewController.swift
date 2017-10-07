//
//  EventLocationSearchViewController.swift
//  iOSAssignment1
//
//  Created by Campbell Brobbel on 28/9/17.
//  Copyright © 2017 CampbellRhys. All rights reserved.
//

import UIKit
import MapKit

protocol MapSearchProtocol {
    func mapItemSelected(mapItem : MKMapItem)
}
class EventLocationSearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var searchBar : UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var array : [MKMapItem] = []
    var delegate : MapSearchProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.keyboardDismissMode = .onDrag
        self.searchBar.delegate = self
        self.tableView.tableFooterView = UIView(frame: .zero)
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = .white
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("Did Begin Editing")
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("Search Button Clicked")
        let query = searchBar.text
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = query!
        
        let search = MKLocalSearch(request: request)
        search.start(completionHandler: {response, error in
            
            
            if response == nil {
                print("Response is nil")
                self.array = []
                
            }
            else {
                print("Response is not nil")
                
                self.array = (response?.mapItems)!
                
            }
            self.tableView.reloadData()
        })
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let query = searchText
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = query
        
        let search = MKLocalSearch(request: request)
        search.start(completionHandler: {response, error in
            
            if response == nil {
                print("Response is nil")
                self.array = []

            }
            else {
                print("Response is not nil")

                self.array = (response?.mapItems)!

            }
            self.tableView.reloadData()
        })
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        cell.textLabel?.text = "\(self.array[indexPath.row].name!)"
        cell.detailTextLabel?.text = "\(self.array[indexPath.row].placemark.title ?? "")"
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mapItem = array[indexPath.row]
    
        self.delegate?.mapItemSelected(mapItem: mapItem)
        self.navigationController?.popToRootViewController(animated: true)
        
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
