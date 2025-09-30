//
//  ViewController.swift
//  VoyatekChallenge
//
//  Created by FMY-762 on 29/09/2025.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    @IBOutlet weak var tripsTableView: UITableView!
    
    var trips: [PlannedTrip] = []
    var popup: InputTripDetails? = nil
    var loader: CustomLoader? = nil
    let viewModel = ViewModel()
    var trip: Trip? = nil
    
    var tripStyle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setup()
        registerCell()
        reloadTable()
        binds()
    }
    
    func setup() {
        loader = Bundle.main.loadNibNamed("CustomLoader", owner: nil, options: nil)?.first as? CustomLoader
    }

    func registerCell() {
        tripsTableView.delegate = self
        tripsTableView.dataSource = self
        
        let cell = TableViewCell()
        tripsTableView.register(TableViewCell.self, forCellReuseIdentifier: "TripCell")
        tripsTableView.register(UINib(nibName: "TableViewHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "TripHeader")
    }
    
    func reloadTable() {
        trips = MockData.getPlannedTripsmock()
        tripsTableView.reloadData()
    }
    
    func binds() {
        viewModel.responseObserver.bind(completion: { [weak self] response in
            if let successful = response?.successful {
                if successful {
                    if let trip = response?.object as? Trip {
                        self!.trip = trip
                        DispatchQueue.main.async {
                            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TripDetailsVC") as! TripDetailsVC
                            vc.trip = trip
                            self!.navigationController?.pushViewController(vc, animated: true)
                            self!.loader?.hideFromBottom()
                        }
                    }
                }
            }
        })
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        trips.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TripCell", for: indexPath) as! TableViewCell
        cell.bookingDate.text = trips[indexPath.row].startDate
        cell.bookingDuration.text = String(trips[indexPath.row].durationDays) + " Days"
        cell.bookingTitle.text = trips[indexPath.row].destination
        
        cell.viewButton.addTarget(self, action: #selector(handleViewButtonTapped), for: .touchUpInside)
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "TripHeader") as? TableViewHeader else {
            return nil
        }
        let cityTap = UITapGestureRecognizer(target: self, action: #selector(handleCityTap))
        header.cityView.addGestureRecognizer(cityTap)

        let dateTap = UITapGestureRecognizer(target: self, action: #selector(handleDateTap))
        header.startDateView.addGestureRecognizer(dateTap)
        header.endDateView.addGestureRecognizer(dateTap)
        header.startDateView.addGestureRecognizer(dateTap)
        
        header.CreateTripButton.addTarget(self, action: #selector(handleCreateTripButton), for: .touchUpInside)
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 800 
    }
}

extension ViewController {
    @objc func handleViewButtonTapped() {
        //
    }
    
    @objc func handleCreateTripButton() {
        if let header = tripsTableView.headerView(forSection: 0) as? TableViewHeader{
            if header.cityLabel.text?.lowercased() == "select city" || header.startDateLabel.text?.lowercased() == "enter date" || header.endDateLabel.text?.lowercased() == "enter date" {
                return
            }
        }
        popup = Bundle.main.loadNibNamed("InputTripDetails", owner: nil, options: nil)?.first as? InputTripDetails
        if let popup = popup {
            popup.frame = CGRect.init(x: 0, y: screenHeight, width: screenWidth, height: screenHeight)
            popup.showFromBottom()
            
            popup.tripStyleView.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(handleOptionsVisibility))
            popup.tripStyleView.addGestureRecognizer(tap)
            
            for views in popup.styleOptionsStack.arrangedSubviews {
                let tap = UITapGestureRecognizer(target: self, action: #selector(handleStackOption))
                views.backgroundColor = .white
                views.addGestureRecognizer(tap)
            }
            
            popup.tripName.addTarget(self, action: #selector(handleFieldEdit), for: .editingChanged)
            popup.tripDescription.addTarget(self, action: #selector(handleFieldEdit), for: .editingChanged)
            
            popup.nextButton.addTarget(self, action: #selector(handleNextButton), for: .touchUpInside)
            self.view.addSubview(popup)
        }
    }
    
    @objc func handleNextButton() {
        if let popup = popup {
            if popup.nextButton.alpha == 1 {
                popup.hideFromBottom()
                let params = [
                    "tripName": "Summer Escape in Barcelona",
                    "country": "Spain",
                    "city": "Barcelona",
                    "startDate": "2025-07-10",
                    "endDate": "2025-07-20",
                    "tripVolume": "Couple"
                ] as [String : Any]
                popup.frame = CGRect.init(x: 0, y: screenHeight, width: screenWidth, height: screenHeight)
                popup.showFromBottom()
                if let loader = loader {
                    self.view.addSubview(loader)
                }
                viewModel.createTrip(param: params, as: Trip.self)
            }
        }
    }
    
    @objc func handleOptionsVisibility() {
        if let popup = popup {
            popup.styleOptionsView.isHidden.toggle()
        }
    }
    
    @objc func handleStackOption(recognizer: UITapGestureRecognizer) {
        if let view = recognizer.view {
            if let popup = popup {
                for views in popup.styleOptionsStack.arrangedSubviews {
                    views.backgroundColor = .white
                }
                popup.styleOptionsView.isHidden.toggle()
                if let label = view.subviews.first as? UILabel {
                    tripStyle = label.text ?? ""
                    popup.tripStyle.text = tripStyle
                    popup.tripStyle.textColor = .black
                    if !popup.tripName.text!.isEmpty && !popup.tripDescription.text!.isEmpty && !tripStyle.isEmpty {
                        popup.nextButton.alpha = 1
                    }
                }
            }
            view.backgroundColor = .systemBlue
        }
    }
    
    @objc func handleCityTap() {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AirportsVC") as! AirportsVC
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @objc func handleDateTap() {
        let vc = UIHostingController(rootView: DatePickerView(onDatesSelected: { startDate, endDate in
            self.navigationController?.popViewController(animated: true)
            self.applyDate(startDate: startDate, endDate: endDate)
        }))
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func handleFieldEdit(field: UITextField) {
        if let popup = popup {
            if field == popup.tripName {
                if !field.text!.isEmpty && !popup.tripDescription.text!.isEmpty && !tripStyle.isEmpty {
                    popup.nextButton.alpha = 1
                }
            } else {
                if !field.text!.isEmpty && !popup.tripName.text!.isEmpty && !tripStyle.isEmpty {
                    popup.nextButton.alpha = 1
                }
            }
        }
    }

    func validate() -> Bool {
        return true
    }
}

extension ViewController: ApplyTripCredentials {
    func applyCity(city: AirportCity) {
        if let header = tripsTableView.headerView(forSection: 0) as? TableViewHeader{
            header.cityLabel.text = city.cityName
        }
    }
    
    func applyDate(startDate: Date?, endDate: Date?) {
        if let header = tripsTableView.headerView(forSection: 0) as? TableViewHeader{
            if let startDate = startDate {
                header.startDateLabel.text = formatDate(startDate)
            }
            if let endDate = endDate {
                header.endDateLabel.text = formatDate(endDate)
            }
        }
    }
    
    func showDatepicker() {
        //
        
    }

    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, MMM d"
        return formatter.string(from: date)
    }
}
