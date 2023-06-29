//
//  PuppyCell.swift
//  AdoptAPup
//
//  Created by Catherine Shing on 6/28/23.
//

import UIKit

class PuppyCell: UITableViewCell {
    
    static let identifier = "PuppyCell"
    
    private(set) var puppy: Puppy!
    
    private let puppyPhoto: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(systemName: "questionmark")
        image.tintColor = .black
        return image
    }()
    
    
    private let puppyName: UILabel = {
        let label = UILabel()
        label.textColor = .label
//        label.textAlignment = .left
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.text = "Unknown"
        return label
    }()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with puppy: Puppy) {
        self.puppy = puppy
        self.puppyName.text = puppy.name
        if let imageUrl = URL(string: puppy.primaryPhotoCropped?.full ?? "") {
            print("imageUrl", imageUrl)
            self.puppyPhoto.sd_setImage(with: imageUrl)
        }
    }
    
    private func setupUI() {
        self.addSubview(puppyPhoto)
        self.addSubview(puppyName)
        
        puppyPhoto.translatesAutoresizingMaskIntoConstraints = false
        puppyName.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            puppyName.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            puppyName.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            puppyPhoto.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            puppyPhoto.topAnchor.constraint(equalTo: self.puppyName.bottomAnchor, constant: 10),
            puppyPhoto.widthAnchor.constraint(equalToConstant: 230),
            puppyPhoto.heightAnchor.constraint(equalToConstant: 230),
        ])
    }
}
