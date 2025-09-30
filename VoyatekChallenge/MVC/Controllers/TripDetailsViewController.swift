//
//  AirportsVC.swift
//  VoyatekChallenge
//
//  Created by FMY-762 on 29/09/2025.
//

import UIKit

class TripDetailsVC: UIViewController {
    
    var trip: Trip? = nil
    
    @IBOutlet weak var startDate: UILabel!
    @IBOutlet weak var endDate: UILabel!
    @IBOutlet weak var tripName: UILabel!
    @IBOutlet weak var tripSpecs: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        startDate.text = trip?.startDate
        endDate.text = trip?.endDate
        tripName.text = trip?.tripName
        tripSpecs.text = "\(trip?.city ?? ""), \(trip?.country ?? "") | \(trip?.tripVolume ?? "") trip "
    }

    @IBAction func backButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    

}
