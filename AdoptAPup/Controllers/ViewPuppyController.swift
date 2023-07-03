//
//  ViewPuppyController.swift
//  AdoptAPup
//
//  Created by Catherine Shing on 6/29/23.
//

import UIKit

class ViewPuppyController: UIViewController {
    
    let viewModel: ViewPuppyViewModel
    
    // MARK: UI Components
    
    private let scrollView: UIScrollView = {
       let sv = UIScrollView()
        return sv
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let puppyImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "questionMark")
        imageView.tintColor = .label
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.text = "Error"
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.text = "Error"
        return label
    }()
    
    private let ageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.text = "Error"
        return label
    }()
    
    private let genderLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.text = "Error"
        return label
    }()
    
    private let sizeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.text = "Error"
        return label
    }()
    
    private let primaryBreedLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.text = "Error"
        return label
    }()

    private lazy var vStack: UIStackView = {
        let vStack = UIStackView(arrangedSubviews: [nameLabel, descriptionLabel, ageLabel, genderLabel, sizeLabel, primaryBreedLabel])
        vStack.axis = .vertical
        vStack.spacing = 12
        vStack.distribution = .fill
        vStack.alignment = .center
        return vStack
    }()
    
    init(_ viewModel: ViewPuppyViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        
        puppyImage.kf.indicatorType = .activity
        
        self.view.backgroundColor = .systemBackground
//        self.navigationItem.title = self.viewModel.puppy.name
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "Back", style: .done, target: nil, action: nil)
        self.nameLabel.text = self.viewModel.nameLabel
        self.descriptionLabel.text = self.viewModel.descriptionLabel
        self.ageLabel.text = self.viewModel.ageLabel
        self.genderLabel.text = self.viewModel.genderLabel
        self.sizeLabel.text = self.viewModel.sizeLabel
        self.primaryBreedLabel.text = self.viewModel.primaryBreedLabel
        
        if let image = viewModel.puppy.primaryPhotoCropped?.full {
            puppyImage.kf.setImage(with: URL(string: image)!)
        }
    }
    
    func setupUI() {
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(contentView)
        self.contentView.addSubview(puppyImage)
        self.contentView.addSubview(vStack)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        puppyImage.translatesAutoresizingMaskIntoConstraints = false
        vStack.translatesAutoresizingMaskIntoConstraints = false
        
        // make the content view low priority so that the view can scroll
        let height = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        height.priority = UILayoutPriority(1)
        height.isActive = true
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),

            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            puppyImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            puppyImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            puppyImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            puppyImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            puppyImage.heightAnchor.constraint(equalToConstant: 200),

            vStack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            vStack.topAnchor.constraint(equalTo: puppyImage.bottomAnchor, constant: 20),
            vStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            vStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            vStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}
