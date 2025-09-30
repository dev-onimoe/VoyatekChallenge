//
//  TableViewCell.swift
//  VoyatekChallenge
//
//  Created by FMY-762 on 29/09/2025.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var borderView = UIView()

    var bigImage = UIImageView()

    var bookingTitle = UILabel()
    
    var bookingDate = UILabel()
    
    var bookingDuration = UILabel()
    
    var viewButton = UIButton()

    var hstack = UIStackView()
    
    var stack = UIStackView()

    var countryLabel = UILabel()
    // MARK: - Setup
    private func setupViews() {
        borderView = UIView()
        borderView.backgroundColor = .white
        borderView.layer.cornerRadius = 10
        borderView.layer.borderWidth = 1
        borderView.layer.borderColor = UIColor(hex: "E4E7EC").cgColor
        
        bigImage = UIImageView()
        bigImage.layer.cornerRadius = 10
        bigImage.image = UIImage(named: "destination")
        
        bookingTitle = UILabel()
        bookingTitle.font = UIFont(name: "Satoshi-Medium", size: 18)
        
        bookingDate = UILabel()
        bookingDate.font = UIFont(name: "Satoshi-Regular", size: 18)
        bookingDate.textAlignment = .left
        
        bookingDuration = UILabel()
        bookingDuration.font = UIFont(name: "Satoshi-Regular", size: 18)
        bookingDuration.textColor = UIColor(hex: "676E7E")
        bookingDuration.textAlignment = .right
        
        viewButton = UIButton()
        viewButton.tintColor = .white
        viewButton.backgroundColor = UIColor(hex: "0D6EFD")
        viewButton.setTitle("View", for: .normal)
        viewButton.layer.cornerRadius = 8
        viewButton.titleLabel?.font = UIFont(name: "Satoshi-Regular", size: 18)
        viewButton.constraint(height: 60)
        
        hstack = UIStackView(arrangedSubviews: [bookingDate, bookingDuration])
        hstack.axis = .horizontal
        hstack.distribution = .fillEqually
        hstack.spacing = 16
        
        stack = UIStackView(arrangedSubviews: [bookingTitle, hstack, viewButton])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 16
        
        countryLabel = UILabel()
        countryLabel.text = "Paris"
        countryLabel.textColor = .white
        countryLabel.font = UIFont(name: "Satoshi-Regular", size: 16)
        
        contentView.addSubview(borderView)
        borderView.constraint(equalToTop: contentView.topAnchor, equalToBottom: contentView.bottomAnchor, equalToLeft: contentView.leadingAnchor, equalToRight: contentView.trailingAnchor, paddingTop: 8, paddingBottom: 8, paddingLeft: 8, paddingRight: 8)
    
        borderView.addSubview(bigImage)
        bigImage.constraint(equalToTop: borderView.topAnchor, equalToLeft: borderView.leadingAnchor, equalToRight: borderView.trailingAnchor, paddingTop: 16, paddingBottom: 16, paddingLeft: 16, paddingRight: 16, height: 250)
        
        borderView.addSubview(stack)
        stack.constraint(equalToTop: bigImage.bottomAnchor, equalToBottom:  borderView.bottomAnchor, equalToLeft: borderView.leadingAnchor, equalToRight: borderView.trailingAnchor, paddingTop: 12, paddingBottom: 12, paddingLeft: 16, paddingRight: 16)
        
//        let blurView = makeGreyBlurView()
//        //blurView.addSubview(countryLabel)
//        borderView.addSubview(blurView)
//        blurView.constraint(equalToTop: bigImage.topAnchor, equalToRight: bigImage.rightAnchor, paddingTop: 24, paddingRight: 16, height: 60)
//        countryLabel.centre(centerX: blurView.centerXAnchor, centreY: blurView.centerYAnchor)
    }

    func makeGreyBlurView(tintAlpha: CGFloat = 0.35, blurStyle: UIBlurEffect.Style = .systemMaterial) -> UIVisualEffectView {
        let blur = UIBlurEffect(style: blurStyle)
        let blurView = UIVisualEffectView(effect: blur)

        let tint = UIView()
        tint.translatesAutoresizingMaskIntoConstraints = false

        tint.backgroundColor = UIColor { trait in
            if trait.userInterfaceStyle == .dark {
                return UIColor(white: 0.12, alpha: tintAlpha)
            } else {
                return UIColor(white: 0.85, alpha: tintAlpha)
            }
        }

        blurView.contentView.addSubview(tint)
        NSLayoutConstraint.activate([
            tint.leadingAnchor.constraint(equalTo: blurView.contentView.leadingAnchor),
            tint.trailingAnchor.constraint(equalTo: blurView.contentView.trailingAnchor),
            tint.topAnchor.constraint(equalTo: blurView.contentView.topAnchor),
            tint.bottomAnchor.constraint(equalTo: blurView.contentView.bottomAnchor),
        ])

        blurView.layer.cornerRadius = 12
        blurView.clipsToBounds = true

        return blurView
    }

}
