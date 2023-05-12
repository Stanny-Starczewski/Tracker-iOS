import UIKit

final class TrackersViewController: UIViewController {
    
    private lazy var addButton: UIButton = {
        let button = UIButton.systemButton(
            with: UIImage(
                systemName: "plus",
                withConfiguration: UIImage.SymbolConfiguration(
                    pointSize: 18,
                    weight: .bold
                )
            )!,
            target: self,
            action: #selector(didTapPlusButton))
        button.tintColor = .BlackDay
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Трекеры"
        label.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        return label
    }()
    
    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.backgroundColor = .WhiteDay
        datePicker.tintColor = .Blue
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .compact
        datePicker.locale = Locale(identifier: "ru_RU")
        datePicker.calendar = Calendar(identifier: .iso8601)
        return datePicker
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchField = UISearchBar()
        searchField.placeholder = "Поиск"
        searchField.searchBarStyle = .minimal
        return searchField
    }()
    
    private let starIcon: UIImageView = {
        let starView = UIImageView()
        starView.image = UIImage(named: "StarIcon")
        return starView
    }()
    
    private let questionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.text = "Что будем отслеживать?"
        label.textColor = .BlackDay
        return label
    }()
    
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .WhiteDay
        configureViews()
        configureConstraints()
        
    }
    
    // MARK: - Actions
    
    @objc
    private func didTapPlusButton() {
        print("Plus tapped")
    }
}
 //MARK: - Layout methods

private extension TrackersViewController {
    func configureViews() {
        view.backgroundColor = .WhiteDay
        view.addSubview(titleLabel)
        view.addSubview(addButton)
        view.addSubview(datePicker)
        view.addSubview(searchBar)
        view.addSubview(stackView)
        stackView.addArrangedSubview(starIcon)
        stackView.addArrangedSubview(questionLabel)
        
        addButton.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        starIcon.translatesAutoresizingMaskIntoConstraints = false
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
    }

    func configureConstraints() {
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 13),
            addButton.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 13),
            datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            datePicker.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 13),
            searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            searchBar.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 45),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)

        ])
    }
}

// MARK: - SHOW PREVIEW

import SwiftUI
struct CreateTrackersVCProvider: PreviewProvider {
    static var previews: some View {
        TrackersViewController().showPreview()
    }
}
