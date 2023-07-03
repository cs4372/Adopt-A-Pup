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
        print("inside home vm init")
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        self.setupView()

        self.viewModel.onPuppiesUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
            print("home vc reload")
        }
    }
    
    private func setupView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.scrollView.delegate = self
        self.tableView.prefetchDataSource = self
    }
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(PuppyCell.self, forCellReuseIdentifier: PuppyCell.identifier)
        return tableView
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
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
        cell.configure(with: puppy)
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        let puppy = self.viewModel.puppies[indexPath.row]
        let viewModel = ViewPuppyViewModel(puppy)
        let vc = ViewPuppyController(viewModel)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
        for index in indexPaths {
            if index.row >= viewModel.puppies.count - 3 && !viewModel.isLoading {
                viewModel.fetchAccessToken()
                break
            }
        }
    }
}
