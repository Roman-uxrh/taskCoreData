//
//  DetailView.swift
//  taskCoreData
//
//  Created by admin on 30.03.2023.
//

import UIKit

final class DetailView: UIViewController, DetailProtocolView {
    
    private var isEdit = false
    
    var presenter: DetailPresenterProtocol?
    
    var user: User? {
        didSet {
            nameTextField.text = user?.name
            genderTextField.text = user?.gender
            dateTextField.text = user?.dateBorn

            guard let image = user?.avatar else { return }
            photo.image = UIImage(data: image)
        }
    }
    
    // MARK: - Outlets
    
    private lazy var photo: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 125
        image.contentMode = .scaleAspectFill
        image.tintColor = .systemGray2
        image.clipsToBounds = true
        image.image = UIImage(systemName: "person.circle")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var imagePickerController: UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        return picker
    }()
    
    private lazy var buttonChangePhoto: UIButton = {
        let button = UIButton()
        button.imageView?.contentMode = .scaleAspectFill
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(сhangePhoto), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        return button
    }()
    
    private lazy var iconChangePhoto: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "gobackward")
        image.tintColor = .black
        image.contentMode = .scaleAspectFill
        image.isHidden = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.isUserInteractionEnabled = false
        textField.textColor = .black
        textField.font = .systemFont(ofSize: 25)
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.black.cgColor
        textField.setLeftIcon(UIImage(systemName: "person"))
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var dateTextField: UITextField = {
        let textField = UITextField()
        textField.isUserInteractionEnabled = false
        textField.textColor = .black
        textField.font = .systemFont(ofSize: 25)
        textField.text = "01.01.1900"
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.black.cgColor
        textField.setLeftIcon(UIImage(systemName: "calendar"))
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .compact
        datePicker.isHidden = true
        datePicker.addTarget(self, action: #selector(changeDate), for: .valueChanged)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()
    
    private lazy var genderTextField: UITextField = {
        let textField = UITextField()
        textField.isUserInteractionEnabled = false
        textField.textColor = .black
        textField.font = .systemFont(ofSize: 25)
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.black.cgColor
        textField.setLeftIcon(UIImage(systemName: "person.2.circle"))
        textField.text = "Gender is not selected"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var menu: UIMenu = {
        let male = UIAction(title: "male") { [weak self]
            action in
            self?.genderTextField.text = action.title
        }
        let female = UIAction(title: "female") { [weak self]
            action in
            self?.genderTextField.text = action.title
        }
        let other = UIAction(title: "other") { [weak self]
            action in
            self?.genderTextField.text = action.title
        }
        
        let elements: [UIAction] = [male, female, other]
        let menu = UIMenu(children: elements)
        return menu
    }()
    
    private lazy var changeGenderButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.isHidden = true
        button.menu = menu
        button.showsMenuAsPrimaryAction = true
        button.imageView?.contentMode = .scaleAspectFill
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var editProfileButton: UIButton = {
        let button = UIButton()
        button.setTitle("Edit", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 2.0
        button.layer.borderColor = UIColor.black.cgColor
        button.titleLabel?.font = .systemFont(ofSize: 25)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(editProfile), for: .touchUpInside)
        button.layer.cornerRadius = 10
        return button
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupHierarchy()
        setupLayout()
        presenter?.getUser()
    }
    
    // MARK: - Setups
    
    private func setupView() {
        view.backgroundColor = .white
    }
    
    private func setupHierarchy() {
        view.addSubview(photo)
        view.addSubview(buttonChangePhoto)
        view.addSubview(iconChangePhoto)
        view.addSubview(nameTextField)
        view.addSubview(dateTextField)
        view.addSubview(datePicker)
        view.addSubview(genderTextField)
        view.addSubview(changeGenderButton)
        view.addSubview(editProfileButton)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            photo.heightAnchor.constraint(equalToConstant: 250),
            photo.widthAnchor.constraint(equalToConstant: 250),
            photo.topAnchor.constraint(equalTo: view.topAnchor, constant: 130),
            photo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            buttonChangePhoto.topAnchor.constraint(equalTo: photo.bottomAnchor, constant: -40),
            buttonChangePhoto.widthAnchor.constraint(equalToConstant: 50),
            buttonChangePhoto.heightAnchor.constraint(equalToConstant: 50),
            buttonChangePhoto.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 50),
            
            iconChangePhoto.topAnchor.constraint(equalTo: photo.bottomAnchor, constant: -40),
            iconChangePhoto.widthAnchor.constraint(equalToConstant: 50),
            iconChangePhoto.heightAnchor.constraint(equalToConstant: 50),
            iconChangePhoto.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 50),
            
            nameTextField.heightAnchor.constraint(equalToConstant: 50),
            nameTextField.topAnchor.constraint(equalTo: photo.bottomAnchor, constant: 30),
            nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            nameTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            
            dateTextField.heightAnchor.constraint(equalToConstant: 50),
            dateTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 30),
            dateTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dateTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            dateTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            
            datePicker.topAnchor.constraint(equalTo: dateTextField.topAnchor, constant: 8),
            datePicker.rightAnchor.constraint(equalTo: dateTextField.rightAnchor, constant: -10),
            
            genderTextField.heightAnchor.constraint(equalToConstant: 50),
            genderTextField.topAnchor.constraint(equalTo: dateTextField.bottomAnchor, constant: 30),
            genderTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            genderTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            genderTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            
            changeGenderButton.heightAnchor.constraint(equalToConstant: 40),
            changeGenderButton.widthAnchor.constraint(equalToConstant: 40),
            changeGenderButton.rightAnchor.constraint(equalTo: genderTextField.rightAnchor, constant: -10),
            changeGenderButton.topAnchor.constraint(equalTo: genderTextField.topAnchor, constant: 3),
            
            editProfileButton.widthAnchor.constraint(equalToConstant: 90),
            editProfileButton.heightAnchor.constraint(equalToConstant: 40),
            editProfileButton.bottomAnchor.constraint(equalTo: photo.topAnchor, constant: 50),
            editProfileButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)
        ])
    }
    
    // MARK: - Methods
    
    func updateUserInfo() {
        guard let avatar = photo.image?.pngData(),
              let name = nameTextField.text, !name.isEmpty,
              let gender = genderTextField.text,
              let dateBorn = dateTextField.text
        else { return }
        
        presenter?.updateUser(avatar: avatar, name: name, gender: gender, dateBorn: dateBorn)
    }
    
    // MARK: - Actions
    
    @objc
    private func сhangePhoto() {
        present(imagePickerController, animated: true)
    }
    
    @objc
    private func changeDate() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        dateTextField.text = formatter.string(from: datePicker.date)
    }
    
    @objc
    private func editProfile() {
        if isEdit {
            isEdit = false
            nameTextField.isUserInteractionEnabled = false
            editProfileButton.setTitle("Edit", for: .normal)
            buttonChangePhoto.isHidden = true
            iconChangePhoto.isHidden = true
            datePicker.isHidden = true
            changeGenderButton.isHidden = true
            updateUserInfo()
        } else {
            isEdit = true
            nameTextField.isUserInteractionEnabled = true
            editProfileButton.setTitle("Save", for: .normal)
            buttonChangePhoto.isHidden = false
            iconChangePhoto.isHidden = false
            datePicker.isHidden = false
            changeGenderButton.isHidden = false
        }
    }
}

// MARK: - Extension UIPickerController

extension DetailView: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo
                               info: [UIImagePickerController.InfoKey : Any]) {
        let selectedImage = info[.originalImage] as! UIImage
        photo.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
