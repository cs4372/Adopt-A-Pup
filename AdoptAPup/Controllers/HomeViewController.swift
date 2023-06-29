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
        
        self.scrollView.delegate = self

        self.viewModel.onPuppiesUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    // MARK: - UI Components
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(PuppyCell.self, forCellReuseIdentifier: PuppyCell.identifier)
        return tableView
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        // Configure the scroll view as needed
        return scrollView
    }()

    private func setupUI() {
        self.navigationItem.title = "Puppies"
        self.view.backgroundColor = .systemGray
        
        self.view.addSubview(scrollView)
        self.view.addSubview(tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.puppies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PuppyCell.identifier, for: indexPath) as? PuppyCell else {
            fatalError("Unable to dequeue PuppyCell in HomeViewController")
        }
        
        let puppy = self.viewModel.puppies[indexPath.row]
        print("puppy", puppy)
        cell.configure(with: puppy)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)

    }
}

extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
         let contentOffsetY = scrollView.contentOffset.y
         let contentHeight = scrollView.contentSize.height
         let scrollViewHeight = scrollView.frame.size.height

         if contentOffsetY > contentHeight - scrollViewHeight {
             if viewModel.currentPage < viewModel.totalPages {
                 viewModel.fetchPuppies()
             }
         }
     }
}

