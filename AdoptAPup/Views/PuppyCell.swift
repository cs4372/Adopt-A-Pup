//
//  PuppyCell.swift
//  AdoptAPup
//
//  Created by Catherine Shing on 6/28/23.
//

import UIKit
import Kingfisher

class PuppyCell: UITableViewCell {
    
    static let identifier = "PuppyCell"
    
    private var imageURL: URL?

    private(set) var puppy: Puppy!
    
    private let puppyPhoto: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.tintColor = .black
        return image
    }()
    
    
    private let puppyName: UILabel = {
        let label = UILabel()
        label.textColor = .label
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.puppy = nil
        puppyPhoto.kf.indicatorType = .activity
    }
    
    public func configure(with puppy: Puppy) {
        if let name = puppy.name, let image = puppy.primaryPhotoCropped?.full {
            self.puppy = puppy
            self.puppyName.text = name
            
            puppyPhoto.kf.cancelDownloadTask()
            
            puppyPhoto.kf.indicatorType = .activity
            puppyPhoto.kf.setImage(with: URL(string: image)!)
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
