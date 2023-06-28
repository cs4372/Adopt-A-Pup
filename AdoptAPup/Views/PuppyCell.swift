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
    
    private let puppyName: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
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
    }
    
    private func setupUI() {
        self.addSubview(puppyName)
        
        puppyName.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            puppyName.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            puppyName.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
}
