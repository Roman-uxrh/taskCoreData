//
//  ViewController.swift
//  taskCoreData
//
//  Created by admin on 29.03.2023.
//

import UIKit
import CoreData

final class ListUsersView: UIViewController {
    
    // MARK: - Outlets
    
    private lazy var nameField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.font = .systemFont(ofSize: 20)
        textField.textAlignment = .left
        textField.placeholder = "Wtite your name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .systemGray5
        textField.layer.cornerRadius = 10
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always

        return textField
    }()
    
    private lazy var pressButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("enter", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(addUser), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
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
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Users"
    }
    
    private func setupHierarchy() {
        view.addSubview(nameField)
        view.addSubview(pressButton)
        view.addSubview(tableView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            nameField.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            nameField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -22),
            nameField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 22),
            nameField.heightAnchor.constraint(equalToConstant: 50),
            
            pressButton.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 20),
            pressButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -22),
            pressButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 22),
            pressButton.heightAnchor.constraint(equalToConstant: 50),
            
            tableView.topAnchor.constraint(equalTo: pressButton.bottomAnchor, constant: 40),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // MARK: - Actions
    
    @objc
    func addUser() {
        guard let name = nameField.text else { return }
        CoreDataManager.shared.addNewUser(name: name, gender: "male", dateBorn: "01.01.1900")
        nameField.text = ""
        tableView.reloadData()
    }
}

// MARK: - Extension UITableView

extension ListUsersView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        CoreDataManager.shared.users?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let user = CoreDataManager.shared.users?[indexPath.row]
        cell.textLabel?.text = user?.name
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        if indexPath.section == 0 && (indexPath.row == 0 || indexPath.row == 5) {
//        } else {
//            let model = presenter?.model[indexPath.section][indexPath.row]
//            let detailVC = assembly.createDetailViewController(model ?? Model(image: "", firstLabel: "", secondLabel: "", update: true))
//            navigationController?.pushViewController(detailVC, animated: true)
//        }
        let user = CoreDataManager.shared.users?[indexPath.row]
        let detailViewController = DetailView()
        detailViewController.model = user
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
}
