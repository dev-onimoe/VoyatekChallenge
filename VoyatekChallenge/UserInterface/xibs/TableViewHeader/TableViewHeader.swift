//
//  TableViewHeader.swift
//  VoyatekChallenge
//
//  Created by FMY-762 on 29/09/2025.
//

import UIKit

class TableViewHeader: UITableViewHeaderFooterView {
    
    
    @IBOutlet weak var cityView: UIView!
    @IBOutlet weak var startDateView: UIView!
    @IBOutlet weak var endDateView: UIView!
    @IBOutlet weak var CreateTripButton: UIButton!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func commonInit() {
        cityView.isUserInteractionEnabled = true
        startDateView.isUserInteractionEnabled = true
        endDateView.isUserInteractionEnabled = true
    }

}
