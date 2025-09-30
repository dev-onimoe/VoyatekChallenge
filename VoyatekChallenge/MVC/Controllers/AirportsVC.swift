//
//  AirportsVC.swift
//  VoyatekChallenge
//
//  Created by FMY-762 on 29/09/2025.
//

import UIKit

class AirportsVC: UIViewController {
    
    @IBOutlet weak var airportTableView: UITableView!
    @IBOutlet weak var airportSearchField: UITextField!
    
    var airports: [AirportCity] = []
    var filterData: [AirportCity] = []
    
    var delegate: ApplyTripCredentials? = nil
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
        registerCell()
        loadTable()
    }
    
    func setup() {
        airportSearchField.delegate = self
        airportSearchField.addTarget(self, action: #selector(searchTextFieldDidChange), for: .editingChanged)
        
        airportSearchField.layer.borderColor = UIColor(hex: "676E7E").cgColor
    }
    
    func registerCell() {
        airportTableView.dataSource = self
        airportTableView.delegate = self
        
    }
    
    func loadTable() {
        airports = airportsData
        airportTableView.reloadData()
    }
    
    @objc func searchTextFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text, !text.isEmpty else {
            loadTable()
            return
        }
        let searchedAirports = airports.filter { airport in
            airport.cityName.localizedCaseInsensitiveContains(text) ||
            airport.airportName.localizedCaseInsensitiveContains(text)
        }
        if !searchedAirports.isEmpty {
            airports = searchedAirports
        }
        airportTableView.reloadData()
    }

    @IBAction func CloseButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    

}

extension AirportsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return airports.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AirportCell", for: indexPath) as! AirportCell
        cell.cityName.text = airports[indexPath.row].cityName
        cell.airportName.text = airports[indexPath.row].airportName
        cell.countryFlag.text = airports[indexPath.row].flagEmoji
        cell.countryCode.text = airports[indexPath.row].countryCode
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = airports[indexPath.row]
        self.navigationController?.popViewController(animated: true)
        delegate?.applyCity(city: item)
    }
}

extension AirportsVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        airportSearchField.layer.borderWidth = 1
        airportSearchField.layer.borderColor = UIColor.blue.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("TextField is no longer active")
    }
}
