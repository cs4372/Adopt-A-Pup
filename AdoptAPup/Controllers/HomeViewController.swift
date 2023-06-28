//
//  HomeViewController.swift
//  AdoptAPup
//
//  Created by Catherine Shing on 6/27/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let viewModel: HomeControllerViewModel
    
    init(_ viewModel: HomeControllerViewModel = HomeControllerViewModel()) {
        print("inside pup vm init")
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
    }
    
    // MARK: - UI Components
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(PuppyCell.self, forCellReuseIdentifier: PuppyCell.identifier)
        return tableView
    }()
    
    private func setupUI() {
        self.navigationItem.title = "Puppies"
        self.view.backgroundColor = .systemGray
        
        self.view.addSubview(tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PuppyCell.identifier, for: indexPath) as? PuppyCell else {
            fatalError("Unable to dequeue PuppyCell in HomeViewController")
        }
        
        cell.textLabel?.text = "Pup"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)

    }
}

