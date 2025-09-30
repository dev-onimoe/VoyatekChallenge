//
//  InputTripDetails.swift
//  VoyatekChallenge
//
//  Created by FMY-762 on 30/09/2025.
//

import UIKit

class InputTripDetails: UIView {
    
    @IBAction func hideButton(_ sender: Any) {
        hideFromBottom()
    }
    
    @IBOutlet weak var tripName: UITextField!
    @IBOutlet weak var tripStyle: UILabel!
    @IBOutlet weak var tripStyleView: UIView!
    @IBOutlet weak var styleOptionsView: UIView!
    @IBOutlet weak var styleOptionsStack: UIStackView!
    
    @IBOutlet weak var soloView: UIView!
    @IBOutlet weak var coupleView: UIView!
    @IBOutlet weak var familyView: UIView!
    @IBOutlet weak var groupView: UIView!
    
    @IBOutlet weak var tripDescription: UITextField!
    
    @IBOutlet weak var nextButton: UIButton!
    
}
