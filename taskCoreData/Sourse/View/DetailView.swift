//
//  DetailView.swift
//  taskCoreData
//
//  Created by admin on 30.03.2023.
//

import UIKit

class DetailView: UIViewController {
    
    // MARK: - Outlets
    
    private lazy var photo: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = image.frame.height / 2
        image.image = UIImage(systemName: "cycle.fill")
        return image
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupHierarchy()
        setupLayout()
    }
    
    // MARK: - Setups
    
    private func setupView() {
        view.backgroundColor = .white
    }
    
    private func setupHierarchy() {
        view.addSubview(photo)
        view.addSubview(tableView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            photo.heightAnchor.constraint(equalToConstant: 150),
            photo.widthAnchor.constraint(equalToConstant: 150),
            photo.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            photo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            tableView.topAnchor.constraint(equalTo: photo.bottomAnchor, constant: 40),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - Extension tableView

extension DetailView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Hello World!"
        cell.imageView?.image = UIImage(systemName: "heart.fill")
        return cell
    }
}

extension DetailView: UITableViewDelegate {
    
}
